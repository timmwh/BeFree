//
//  MainTabView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI
import UIKit

/// Bottom tab bar per Figma 2002-1026: 3 tabs (Start / Roadmap / Profile)
/// inside a liquid-glass pill floating above content. The system `TabView`
/// is kept so per-tab lifecycle is preserved, but its native bar is hidden
/// and ours is rendered as a `safeAreaInset` overlay.
///
/// Visibility: pushed destinations (e.g. `StepDetailView`, `ProfileEditView`)
/// opt out via `.hidesCustomTabBar()`, which flows up through the
/// `CustomTabBarHiddenKey` preference so the bar only appears on the three
/// root screens.
struct MainTabView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isTabBarHidden: Bool = false

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            DashboardView()
                .tag(AppTab.start)
                .toolbar(.hidden, for: .tabBar)

            RoadmapView()
                .tag(AppTab.roadmap)
                .toolbar(.hidden, for: .tabBar)

            ProfileView()
                .tag(AppTab.profile)
                .toolbar(.hidden, for: .tabBar)
        }
        .onPreferenceChange(CustomTabBarHiddenKey.self) { hidden in
            withAnimation(.easeInOut(duration: 0.22)) {
                isTabBarHidden = hidden
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if !isTabBarHidden {
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    CustomTabBar(selected: $viewModel.selectedTab)
                        .frame(maxWidth: 393)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

// MARK: - Visibility preference

/// Propagated up from pushed destinations to hide the floating tab bar.
struct CustomTabBarHiddenKey: PreferenceKey {
    static let defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}

extension View {
    /// Hides the floating custom tab bar while this view is on screen.
    /// Used by pushed detail screens (StepDetail, ProfileEdit) so the bar
    /// only appears on the three root tabs.
    func hidesCustomTabBar(_ hidden: Bool = true) -> some View {
        preference(key: CustomTabBarHiddenKey.self, value: hidden)
    }
}

// MARK: - Custom tab bar

private struct CustomTabBar: View {
    @Binding var selected: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allTabs, id: \.self) { tab in
                tabButton(for: tab)
                    .frame(maxWidth: .infinity)
            }
        }
        // Figma: py-[10px] px-[8px]
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(glassBackground)
        // Figma: border 1px solid rgba(255,255,255,0.1)
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .strokeBorder(Color.white.opacity(0.10), lineWidth: 1)
        )
        // Figma: inset 0 1px 0 rgba(255,255,255,0.04)
        .overlay(alignment: .top) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.04), Color.clear],
                        startPoint: .top,
                        endPoint: UnitPoint(x: 0.5, y: 0.06)
                    )
                )
                .frame(height: 2)
                .allowsHitTesting(false)
        }
        // Figma: 0 8px 24px rgba(0,0,0,0.22)
        .shadow(color: .black.opacity(0.22), radius: 24, x: 0, y: 8)
    }

    /// Matches Figma tab bar: `background: rgba(30,30,42,0.25)` over a
    /// strong backdrop blur. Web uses `blur(40px) saturate(1.8)`; iOS maps
    /// that to `UIBlurEffect` (no public radius/saturation knobs) — we use
    /// `systemUltraThinMaterialDark` / `Light` so the bar stays glassy and
    /// content behind reads through the tint.
    private var glassBackground: some View {
        ZStack {
            LiquidGlassBackdropView()
            Color(hex: "1E1E2A").opacity(0.25)
        }
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    @ViewBuilder
    private func tabButton(for tab: AppTab) -> some View {
        let isSelected = selected == tab

        Button {
            withAnimation(.easeInOut(duration: 0.18)) {
                selected = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 22, weight: .regular))
                Text(tab.label)
                    .font(.system(size: 10, weight: .regular))
            }
            .foregroundColor(isSelected ? Theme.Colors.primaryBlue : Theme.Colors.textSecondary)
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(selectedPill(isSelected: isSelected))
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(tab.label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    /// Selected state pill — hugs the icon+label (matches Figma widths
    /// Start 63 / Roadmap 84 / Profile 70) and glows in primary blue.
    @ViewBuilder
    private func selectedPill(isSelected: Bool) -> some View {
        if isSelected {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Theme.Colors.primaryBlue.opacity(0.15))
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Theme.Colors.primaryBlue.opacity(0.10))
                    .shadow(color: Theme.Colors.primaryBlue.opacity(0.15),
                            radius: 20, x: 0, y: 0)
            }
        }
    }
}

/// UIKit blur behind the rgba tint — closest match to Figma/CSS
/// `backdrop-filter: blur(40px) saturate(1.8)` (iOS has no public blur radius
/// or saturation multiplier on `UIBlurEffect`).
private struct LiquidGlassBackdropView: UIViewRepresentable {
    @Environment(\.colorScheme) private var colorScheme

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let style: UIBlurEffect.Style = colorScheme == .dark
            ? .systemUltraThinMaterialDark
            : .systemUltraThinMaterialLight
        uiView.effect = UIBlurEffect(style: style)
    }
}

private extension AppTab {
    static let allTabs: [AppTab] = [.start, .roadmap, .profile]

    /// Outlined SF Symbols matching Figma 2002-1026 icon set.
    var icon: String {
        switch self {
        case .start:   return "house"
        case .roadmap: return "map"
        case .profile: return "person"
        }
    }

    var label: String {
        switch self {
        case .start:   return "Start"
        case .roadmap: return "Roadmap"
        case .profile: return "Profile"
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
}
