//
//  YouTubePlayerView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 09.04.26.
//

import SwiftUI
import UIKit
import WebKit

/// Gleicht kleine Scroll-Insets/Offsets im `WKWebView`, die den Embed-Inhalt vertikal verschieben können.
private func pinYouTubeWebViewScrollToTop(_ webView: WKWebView) {
    let sv = webView.scrollView
    sv.contentInset = .zero
    sv.verticalScrollIndicatorInsets = .zero
    sv.horizontalScrollIndicatorInsets = .zero
    sv.setContentOffset(.zero, animated: false)
}

// MARK: - Public SwiftUI surface (poster → web player)

struct YouTubePlayerView: View {
    let videoId: String

    @State private var showWebPlayer = false

    var body: some View {
        Group {
            if videoId.isEmpty {
                videoComingSoonPlaceholder
                    .frame(maxWidth: .infinity)
                    .aspectRatio(16 / 9, contentMode: .fit)
            } else {
                // Eine feste 16:9-Fläche + overlay: Poster und WebView teilen exakt dieselben Bounds
                // (vermeidet unterschiedliche Layout-Pfade bei if/else im Group).
                Color.clear
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        if showWebPlayer {
                            YouTubeWebPlayer(videoId: videoId, autoplay: true)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            posterTapToPlay
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .clipped()
            }
        }
        .onChange(of: videoId) { _, _ in
            showWebPlayer = false
        }
    }

    private var videoComingSoonPlaceholder: some View {
        Text("Video coming soon")
            .font(Theme.Typography.body)
            .foregroundColor(Theme.Colors.textSecondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.Colors.cardBackground)
    }

    private var posterTapToPlay: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            ZStack {
                AsyncImage(url: Self.thumbnailURL(for: videoId)) { phase in
                    switch phase {
                    case .empty:
                        Theme.Colors.cardBackground
                            .overlay {
                                ProgressView()
                                    .tint(Theme.Colors.textSecondary)
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Theme.Colors.cardBackground
                            .overlay {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 56))
                                    .foregroundStyle(Theme.Colors.textSecondary)
                            }
                    @unknown default:
                        Theme.Colors.cardBackground
                    }
                }
                .frame(width: w, height: h)
                .clipped()

                Color.black.opacity(0.22)
                    .frame(width: w, height: h)
                    .allowsHitTesting(false)

                Image(systemName: "play.circle.fill")
                    .font(.system(size: 64))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .white.opacity(0.35))
                    .shadow(color: .black.opacity(0.35), radius: 10, y: 4)
                    .allowsHitTesting(false)
            }
            .frame(width: w, height: h)
            .contentShape(Rectangle())
            .onTapGesture { showWebPlayer = true }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Video abspielen")
            .accessibilityAddTraits(.isButton)
        }
    }

    private static func thumbnailURL(for videoId: String) -> URL? {
        URL(string: "https://img.youtube.com/vi/\(videoId)/hqdefault.jpg")
    }
}

// MARK: - WKWebView embed

private struct YouTubeWebPlayer: UIViewRepresentable {
    let videoId: String
    var autoplay: Bool = false

    private static let htmlBaseURL = URL(string: "https://www.youtube.com")!

    private static var mobileSafariLikeUserAgent: String {
        let v = UIDevice.current.systemVersion
        let vUnderscore = v.replacingOccurrences(of: ".", with: "_")
        return "Mozilla/5.0 (iPhone; CPU iPhone OS \(vUnderscore) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(v) Mobile/15E148 Safari/604.1"
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var loadedKey: String?
        private var loadGeneration: Int = 0
        private var shouldRunAutoplayJS: Bool = false
        /// `didFinish` feuert auch für Subframes — nur einmal Autoplay pro Embed-Load starten.
        private var autoplayScheduledForGeneration: Int?

        func prepareForNewLoad(autoplay: Bool) {
            loadGeneration += 1
            shouldRunAutoplayJS = autoplay
            autoplayScheduledForGeneration = nil
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            guard shouldRunAutoplayJS else { return }
            guard let url = webView.url,
                  url.host?.contains("youtube.com") == true,
                  url.path.contains("/embed/")
            else { return }
            let gen = loadGeneration
            guard autoplayScheduledForGeneration != gen else { return }
            autoplayScheduledForGeneration = gen
            Self.scheduleAutoplay(webView: webView, attempt: 0, generation: gen, coordinator: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self, weak webView] in
                guard let self, let webView, self.loadGeneration == gen else { return }
                pinYouTubeWebViewScrollToTop(webView)
            }
        }

        private static func scheduleAutoplay(
            webView: WKWebView,
            attempt: Int,
            generation: Int,
            coordinator: Coordinator
        ) {
            guard attempt < 16 else { return }
            let delays: [TimeInterval] = [0.04, 0.1, 0.2, 0.35, 0.55, 0.8, 1.2, 1.7, 2.3, 3.0, 3.8, 4.8, 6.0, 7.5, 9.0]
            let delay = attempt < delays.count ? delays[attempt] : 10.0

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                guard coordinator.loadGeneration == generation else { return }

                let js = """
                (function(){
                  try {
                    var videos = document.querySelectorAll('video');
                    for (var i = 0; i < videos.length; i++) {
                      var v = videos[i];
                      var p = v.play();
                      if (p && p.catch) { p.catch(function(){}); }
                    }
                    var btn = document.querySelector('.ytp-large-play-button, button.ytp-large-play-button');
                    if (btn && btn.offsetParent !== null) { btn.click(); return 'btn'; }
                    if (videos.length > 0) { return 'vid'; }
                  } catch (e) {}
                  return 'none';
                })();
                """

                webView.evaluateJavaScript(js) { result, _ in
                    guard coordinator.loadGeneration == generation else { return }
                    if let s = result as? String, s == "btn" || s == "vid" { return }
                    scheduleAutoplay(webView: webView, attempt: attempt + 1, generation: generation, coordinator: coordinator)
                }
            }
        }

        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard navigationAction.navigationType == .linkActivated,
                  let url = navigationAction.request.url
            else {
                decisionHandler(.allow)
                return
            }
            if Self.shouldOpenExternally(url) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {
            if navigationAction.targetFrame == nil, let url = navigationAction.request.url {
                UIApplication.shared.open(url)
            }
            return nil
        }

        private static func shouldOpenExternally(_ url: URL) -> Bool {
            let host = url.host?.lowercased() ?? ""
            guard host.contains("youtube.com") || host.contains("youtu.be") else { return false }
            let path = url.path.lowercased()
            if path.hasPrefix("/embed/") { return false }
            return true
        }
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.defaultWebpagePreferences.preferredContentMode = .mobile

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.customUserAgent = Self.mobileSafariLikeUserAgent
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = UIColor(Theme.Colors.cardBackground)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
        webView.clipsToBounds = true
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let coordinator = context.coordinator

        if videoId.isEmpty {
            coordinator.loadedKey = nil
            coordinator.prepareForNewLoad(autoplay: false)
            let placeholder = """
            <html>
            <body style="margin:0;background:#13131a;display:flex;align-items:center;justify-content:center;height:100vh;">
            <p style="color:#8b8b9a;font-family:-apple-system;font-size:14px;">Video coming soon</p>
            </body>
            </html>
            """
            webView.loadHTMLString(placeholder, baseURL: Self.htmlBaseURL)
            pinYouTubeWebViewScrollToTop(webView)
            return
        }

        let key = "\(videoId)|autoplay=\(autoplay)"
        if coordinator.loadedKey == key {
            pinYouTubeWebViewScrollToTop(webView)
            return
        }

        guard let safeId = Self.sanitizedVideoId(videoId) else { return }
        guard let embedURL = Self.embedURL(for: safeId, autoplay: autoplay) else { return }

        coordinator.prepareForNewLoad(autoplay: autoplay)
        coordinator.loadedKey = key
        webView.load(URLRequest(url: embedURL))
        DispatchQueue.main.async {
            pinYouTubeWebViewScrollToTop(webView)
        }
    }

    /// Nur typische YouTube-Video-IDs (kein eingeschleuster Inhalt in der URL).
    private static func sanitizedVideoId(_ raw: String) -> String? {
        guard raw.count <= 32,
              raw.range(of: "^[a-zA-Z0-9_-]+$", options: .regularExpression) != nil
        else { return nil }
        return raw
    }

    private static func embedURL(for videoId: String, autoplay: Bool) -> URL? {
        var components = URLComponents(string: "https://www.youtube.com/embed/\(videoId)")
        var items: [URLQueryItem] = [
            URLQueryItem(name: "playsinline", value: "1"),
            URLQueryItem(name: "rel", value: "0"),
            URLQueryItem(name: "modestbranding", value: "1"),
            URLQueryItem(name: "origin", value: "https://www.youtube.com"),
        ]
        if autoplay {
            items.append(URLQueryItem(name: "autoplay", value: "1"))
        }
        components?.queryItems = items
        return components?.url
    }
}

#Preview {
    YouTubePlayerView(videoId: "dQw4w9WgXcQ")
        .cornerRadius(12)
        .padding()
        .background(Theme.Colors.background)
}
