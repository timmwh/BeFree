//
//  NextStepCard.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// Featured "next step" callout used on the Dashboard. Card with radius 20,
/// `cardBackground`, subtle blue glow. Shows:
///
/// - Uppercase `NEXT STEP` label with a `bolt.fill` mark in `primaryBlue`.
/// - H3 step title (up to 2 lines).
/// - Step description, capped at 3 lines.
/// - Embedded gradient `Start →` button that triggers `onStart`.
struct NextStepCard: View {
    let step: Step
    let onStart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            HStack(spacing: 6) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Theme.Colors.primaryBlue)

                Text("NEXT STEP")
                    .font(Theme.Typography.smallMedium)
                    .foregroundColor(Theme.Colors.primaryBlue)
                    .tracking(1)
            }

            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text(step.title)
                    .font(Theme.Typography.heading3)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(step.description)
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
            }

            Button(action: onStart) {
                HStack(spacing: Theme.Spacing.sm) {
                    Text("Start")
                        .font(Theme.Typography.bodySemiBold)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Theme.Gradients.primaryButton)
                .cornerRadius(Theme.CornerRadius.md)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(Theme.Spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .shadow(color: Theme.Colors.primaryBlue.opacity(0.15), radius: 24, x: 0, y: 8)
    }
}

#Preview {
    NextStepCard(
        step: DataService.shared.getAuthoredSteps(for: "AAA")[0],
        onStart: {}
    )
    .padding()
    .background(Theme.Colors.background)
}
