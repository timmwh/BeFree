//
//  YouTubePlayerView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 09.04.26.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(Theme.Colors.cardBackground)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard !videoId.isEmpty else {
            let placeholder = """
            <html>
            <body style="margin:0;background:#13131a;display:flex;align-items:center;justify-content:center;height:100vh;">
            <p style="color:#8b8b9a;font-family:-apple-system;font-size:14px;">Video coming soon</p>
            </body>
            </html>
            """
            webView.loadHTMLString(placeholder, baseURL: nil)
            return
        }

        let embedHTML = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
            * { margin: 0; padding: 0; }
            body { background: #13131a; }
            .container {
                position: relative;
                width: 100%;
                padding-bottom: 56.25%;
            }
            iframe {
                position: absolute;
                top: 0; left: 0;
                width: 100%; height: 100%;
                border: 0;
                border-radius: 12px;
            }
        </style>
        </head>
        <body>
        <div class="container">
            <iframe
                src="https://www.youtube.com/embed/\(videoId)?playsinline=1&rel=0&modestbranding=1"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
            </iframe>
        </div>
        </body>
        </html>
        """
        webView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

#Preview {
    YouTubePlayerView(videoId: "dQw4w9WgXcQ")
        .aspectRatio(16/9, contentMode: .fit)
        .cornerRadius(12)
        .padding()
        .background(Theme.Colors.background)
}
