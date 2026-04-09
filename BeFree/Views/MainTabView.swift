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
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }

            RoadmapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Roadmap")
                }

            SettingsView()
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
