//
//  BeFreeApp.swift
//  BeFree
//
//  Created by Tim Meiwirth on 12.11.25.
//

import SwiftUI

@main
struct BeFreeApp: App {
    @StateObject private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if viewModel.hasCompletedOnboarding {
                    MainTabView()
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(viewModel)
            .preferredColorScheme(.dark)
        }
    }
}
