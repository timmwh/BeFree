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
            MainTabView()
                .environmentObject(viewModel)
                .preferredColorScheme(.dark)
        }
    }
}
