//
//  SkeletonBar.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// Looping shimmer placeholder bar. Used by the Match-loading state to
/// stand in for model code, model name, and the bottom CTA. Animates a
/// brighter highlight horizontally across a muted track.
///
/// - Track: `rgba(37,37,48,0.25)`
/// - Highlight band: `rgba(37,37,48,0.5)`
/// - Cycle: 1.4s, eased linear, repeating forever.
struct SkeletonBar: View {
    let width: CGFloat
    let height: CGFloat
    var cornerRadius: CGFloat = 8

    @State private var phase: CGFloat = -1

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(hex: "252530").opacity(0.25))
            .frame(width: width, height: height)
            .overlay(
                GeometryReader { geo in
                    LinearGradient(
                        colors: [
                            Color(hex: "252530").opacity(0),
                            Color(hex: "252530").opacity(0.5),
                            Color(hex: "252530").opacity(0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.5)
                    .offset(x: phase * geo.size.width)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onAppear {
                withAnimation(.linear(duration: 1.4).repeatForever(autoreverses: false)) {
                    phase = 1.5
                }
            }
            .accessibilityHidden(true)
    }
}

/// Indeterminate horizontal progress segment used in the Match-loading card.
/// A 40%-wide gradient slug sweeps across a thin muted track.
struct IndeterminateProgressBar: View {
    var height: CGFloat = 4
    var trackColor: Color = Color(hex: "252530").opacity(0.38)

    @State private var phase: CGFloat = -0.4

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackColor)
                    .frame(height: height)

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Theme.Colors.primaryBlue, Theme.Colors.secondaryBlue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * 0.4, height: height)
                    .offset(x: phase * geo.size.width)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: false)) {
                    phase = 1.0
                }
            }
        }
        .frame(height: height)
        .accessibilityHidden(true)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 20) {
        SkeletonBar(width: 120, height: 14)
        SkeletonBar(width: 200, height: 20)
        IndeterminateProgressBar()
            .frame(width: 280)
    }
    .padding()
    .background(Theme.Colors.background)
}
