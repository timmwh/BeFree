//
//  MainTabView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Bottom tab bar per Figma: 3 tabs (Start / Roadmap / Profile) inside a
/// glass-morphism pill that floats above content. The system `TabView` is
/// kept (so view state and lifecycle are preserved per tab) but its native
/// tab bar is hidden via `.toolbar(.hidden, for: .tabBar)`; our own bar is
/// rendered as a bottom overlay.
struct MainTabView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            DashboardView()
                .tag(AppTab.start)

            RoadmapView()
                .tag(AppTab.roadmap)

            ProfileView()
                .tag(AppTab.profile)
        }
        .toolbar(.hidden, for: .tabBar)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBar(selected: $viewModel.selectedTab)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
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
        .padding(.horizontal, 13)
        .frame(height: 71)
        .background(
            ZStack {
                Color(hex: "1e1e2a").opacity(0.25)
                Color.clear.background(.ultraThinMaterial)
            }
        )
        .cornerRadius(28)
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.1), lineWidth: 0.633)
        )
        .shadow(color: .black.opacity(0.22), radius: 24, x: 0, y: 8)
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
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                Group {
                    if isSelected {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Theme.Colors.primaryBlue.opacity(0.15))
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Theme.Colors.primaryBlue.opacity(0.1))
                                .shadow(color: Theme.Colors.primaryBlue.opacity(0.15), radius: 20, x: 0, y: 0)
                        }
                    }
                }
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(tab.label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

private extension AppTab {
    static let allTabs: [AppTab] = [.start, .roadmap, .profile]

    var icon: String {
        switch self {
        case .start:   return "bolt.fill"
        case .roadmap: return "map.fill"
        case .profile: return "person.fill"
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
