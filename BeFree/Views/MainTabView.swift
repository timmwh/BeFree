//
//  MainTabView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Bottom tab bar per **Figma 2042:3972** (Main Frames V2): Start / Roadmap /
/// Profile in a floating pill. The system `TabView` is kept for per-tab
/// lifecycle; the native bar is hidden and this bar is a `safeAreaInset`.
///
/// **Shell:** Backdrop **blur** only (no local fill) — Figma: fully transparent with blur.
/// **iOS 26+:** `Glass` `.clear` (no `.tint`). **iOS 17–25:** `UIVisualEffectView` (blur material).
/// Edge definition: stroke + hairline + light shadow, not a colored pill body.
///
/// Pushed screens hide the bar via `.hidesCustomTabBar()` → `CustomTabBarHiddenKey`.
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
                        .frame(maxWidth: Theme.TabBar.pillOuterWidth)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, Theme.TabBar.barHorizontalScreenInset)
                .padding(.bottom, Theme.TabBar.barBottomInset)
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
    func hidesCustomTabBar(_ hidden: Bool = true) -> some View {
        preference(key: CustomTabBarHiddenKey.self, value: hidden)
    }
}

// MARK: - Custom tab bar

private struct CustomTabBar: View {
    @Binding var selected: AppTab
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private var barShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: Theme.TabBar.cornerRadius, style: .continuous)
    }

    /// Figma: 57 / 76.092 / 63.024pt columns with ~48.15pt gaps (not full-width flex — fixes oversized active glow).
    private var tabBarContent: some View {
        GeometryReader { geo in
            let innerW = geo.size.width
            let natural = Theme.TabBar.naturalRowWidth
            let scale = min(1, innerW / max(natural, 1))
            HStack(alignment: .center, spacing: Theme.TabBar.columnGap * scale) {
                ForEach(AppTab.allTabs, id: \.self) { tab in
                    let colW = Self.pillBaseWidth(for: tab) * scale
                    tabButton(for: tab, columnWidth: colW, contentScale: scale)
                }
            }
            .frame(maxWidth: .infinity, minHeight: geo.size.height, alignment: .center)
        }
        .frame(height: Theme.TabBar.tabRowHeight)
    }

    private static func pillBaseWidth(for tab: AppTab) -> CGFloat {
        switch tab {
        case .start: return Theme.TabBar.selectedPillWidthStart
        case .roadmap: return Theme.TabBar.selectedPillWidthRoadmap
        case .profile: return Theme.TabBar.selectedPillWidthProfile
        }
    }

    var body: some View {
        let paddedTabs = tabBarContent
            .padding(.horizontal, Theme.TabBar.horizontalPadding)
            .padding(.vertical, Theme.TabBar.verticalPadding)

        // Figma 2042:3972: bar fill is rgba(19,19,26,0.08) — a near-transparent tint, no blur.
        // reduceTransparency gets a slightly more opaque fallback so the bar stays legible.
        paddedTabs
            .background(
                barShape.fill(
                    reduceTransparency
                        ? Theme.Colors.cardBackground
                        : Color(hex: "13131a").opacity(0.08)
                )
            )
        .clipShape(barShape)
        .overlay(
            barShape
                .strokeBorder(
                    Color.white.opacity(Theme.TabBar.borderWhiteOpacity),
                    lineWidth: Theme.TabBar.borderLineWidth
                )
        )
        .overlay(alignment: .top) {
            barShape
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.03), Color.clear],
                        startPoint: .top,
                        endPoint: UnitPoint(x: 0.5, y: 0.04)
                    )
                )
                .frame(height: 1)
                .allowsHitTesting(false)
        }
        .compositingGroup()
        .shadow(
            color: .black.opacity(Theme.TabBar.outerDropShadowOpacity),
            radius: Theme.TabBar.outerShadowRadius,
            x: 0,
            y: Theme.TabBar.outerShadowY
        )
    }

    private func tabButton(for tab: AppTab, columnWidth: CGFloat, contentScale: CGFloat) -> some View {
        let isSelected = selected == tab
        let rowH = Theme.TabBar.tabRowHeight * contentScale

        return Button {
            withAnimation(.easeInOut(duration: 0.18)) {
                selected = tab
            }
        } label: {
            VStack(spacing: Theme.TabBar.iconLabelSpacing) {
                tabBarIcon(for: tab, scale: contentScale)
                Text(tab.label)
                    .font(Theme.Typography.tabLabel)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: true)
            }
            .foregroundColor(isSelected ? Theme.Colors.primaryBlue : Theme.Colors.textSecondary)
            .frame(width: columnWidth, height: rowH, alignment: .center)
            .background(alignment: .center) {
                selectedPill(isSelected: isSelected, width: columnWidth, height: rowH, contentScale: contentScale)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(tab.label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    @ViewBuilder
    private func tabBarIcon(for tab: AppTab, scale: CGFloat) -> some View {
        let side = Theme.TabBar.iconSize * scale
        switch tab {
        case .roadmap:
            Image(systemName: "map")
                .font(.system(size: side, weight: .light))
                .symbolRenderingMode(.monochrome)
                .frame(width: side, height: side)
        case .start:
            Image("TabBarIconStart")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: side, height: side)
        case .profile:
            Image("TabBarIconProfile")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: side, height: side)
        }
    }

    /// Figma 2042:3974 — fixed-size highlight; soft glow (Swift tones down Figma 24@0.3 to reduce bloom).
    @ViewBuilder
    private func selectedPill(isSelected: Bool, width: CGFloat, height: CGFloat, contentScale: CGFloat) -> some View {
        if isSelected {
            let r = Theme.TabBar.selectedCornerRadius * contentScale
            // CSS 140.5° clockwise from “up”
            let start = UnitPoint(x: 0.18, y: 0.12)
            let end = UnitPoint(x: 0.82, y: 0.88)
            let fill = LinearGradient(
                colors: [
                    Theme.Colors.primaryBlue.opacity(Theme.TabBar.selectedFillPrimaryOpacity),
                    Theme.Colors.secondaryBlue.opacity(Theme.TabBar.selectedFillSecondaryOpacity)
                ],
                startPoint: start,
                endPoint: end
            )

            RoundedRectangle(cornerRadius: r, style: .continuous)
                .fill(fill)
                .frame(width: width, height: height)
                .shadow(
                    color: Theme.Colors.primaryBlue.opacity(Theme.TabBar.selectedGlowOpacity),
                    radius: Theme.TabBar.selectedGlowRadius * contentScale,
                    x: 0,
                    y: 0
                )
                .overlay {
                    RoundedRectangle(cornerRadius: r, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [Color.white.opacity(0.1), Color.white.opacity(0.02)],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                }
        }
    }
}


private extension AppTab {
    static let allTabs: [AppTab] = [.start, .roadmap, .profile]

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
