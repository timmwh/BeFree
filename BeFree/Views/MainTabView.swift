//
//  MainTabView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            DashboardView()
                .tag(AppTab.start)
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Start")
                }

            RoadmapView()
                .tag(AppTab.roadmap)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Roadmap")
                }

            SettingsView()
                .tag(AppTab.profile)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(Theme.Colors.primaryBlue)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
}
