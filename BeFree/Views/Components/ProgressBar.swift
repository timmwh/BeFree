//
//  ProgressBar.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// Shared horizontal progress bar used by the Dashboard progress card,
/// Roadmap overall-progress card, and the onboarding header.
///
/// - `progress` is clamped to `0...1`.
/// - Track color: `#1a1a24`.
/// - Fill: vertical-feel `primaryBlue → secondaryBlue` gradient with a soft
///   blue glow shadow.
struct ProgressBar: View {
    let progress: Double
    var height: CGFloat = 8

    private var clamped: Double {
        min(max(progress, 0), 1)
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(hex: "1a1a24"))
                    .frame(height: height)

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Theme.Colors.primaryBlue, Theme.Colors.secondaryBlue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * clamped, height: height)
                    .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 8, x: 0, y: 0)
            }
        }
        .frame(height: height)
        .accessibilityElement()
        .accessibilityLabel("Progress")
        .accessibilityValue("\(Int(clamped * 100)) percent")
    }
}

#Preview {
    VStack(spacing: 16) {
        ProgressBar(progress: 0)
        ProgressBar(progress: 0.25)
        ProgressBar(progress: 0.6, height: 10)
        ProgressBar(progress: 1, height: 12)
    }
    .padding()
    .background(Theme.Colors.background)
}
