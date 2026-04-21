//
//  PrimaryButton.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Primary CTA button per Figma: 56pt high, radius 16, vertical blue gradient
/// (`primaryBlue → secondaryBlue`), animated shimmer overlay, multi-layered
/// blue glow shadow.
///
/// Three explicit visual states:
/// - `.enabled` — gradient fill + label/icon + shimmer + glow.
/// - `.loading` — gradient fill, but the label is replaced by a spinner;
///   button is non-interactive.
/// - `.disabled` — flat `cardBackground` (`#252530`-ish) at 50% opacity, no
///   shimmer, no glow; button is non-interactive.
struct PrimaryButton: View {
    let title: String
    let icon: String?
    let state: State
    let action: () -> Void

    enum State {
        case enabled
        case loading
        case disabled
    }

    init(_ title: String,
         icon: String? = nil,
         state: State = .enabled,
         action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.state = state
        self.action = action
    }

    /// Convenience initializer kept for older call sites that pass a single
    /// `isEnabled` Bool. Maps to `.enabled` / `.disabled` (no loading state).
    init(_ title: String,
         icon: String? = nil,
         isEnabled: Bool,
         action: @escaping () -> Void) {
        self.init(title, icon: icon, state: isEnabled ? .enabled : .disabled, action: action)
    }

    private var isInteractive: Bool { state == .enabled }

    var body: some View {
        Button(action: action) {
            ZStack {
                background
                content
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(shimmerOverlay)
        }
        .disabled(!isInteractive)
        .if(state == .enabled) { view in
            view.primaryGlow()
        }
    }

    @ViewBuilder
    private var background: some View {
        switch state {
        case .enabled, .loading:
            Theme.Gradients.primaryButton
        case .disabled:
            Color(hex: "252530").opacity(0.5)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
        case .enabled, .disabled:
            HStack(spacing: Theme.Spacing.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(title)
                    .font(Theme.Typography.bodySemiBold)
                    .tracking(-0.3125)
            }
            .foregroundColor(.white.opacity(state == .disabled ? 0.6 : 1))
        }
    }

    @ViewBuilder
    private var shimmerOverlay: some View {
        if state == .enabled {
            ShimmerOverlay()
                .cornerRadius(Theme.CornerRadius.md)
                .allowsHitTesting(false)
        }
    }
}

// MARK: - Shimmer

/// Diagonal moving highlight, looped indefinitely. Sized to its parent.
private struct ShimmerOverlay: View {
    @State private var phase: CGFloat = -1

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            LinearGradient(
                colors: [
                    Color.white.opacity(0),
                    Color.white.opacity(0.25),
                    Color.white.opacity(0)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: width * 0.6)
            .offset(x: phase * width)
            .onAppear {
                withAnimation(.linear(duration: 2.4).repeatForever(autoreverses: false)) {
                    phase = 1.4
                }
            }
        }
        .clipped()
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton("Continue", icon: "arrow.right") {}
        PrimaryButton("Submitting", state: .loading) {}
        PrimaryButton("Disabled", state: .disabled) {}
    }
    .padding()
    .background(Theme.Colors.background)
}
