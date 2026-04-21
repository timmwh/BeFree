//
//  NextStepCard.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// Featured "next step" callout used on the Dashboard. Card with radius 20,
/// `cardBackground`, subtle blue glow. The embedded gradient "Start →" panel
/// is purely visual — the entire card is one tap target to avoid nested
/// buttons inside a `NavigationLink`. The caller is responsible for wrapping
/// with a `NavigationLink` (or `Button`) as needed.
struct NextStepCard: View {
    let step: Step

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Theme.Colors.primaryBlue)
                Text("NEXT STEP")
                    .font(Theme.Typography.smallMedium)
                    .foregroundColor(Theme.Colors.primaryBlue)
                    .tracking(1)
            }

            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text(step.title)
                    .font(Theme.Typography.heading2)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)

                Text(step.description.components(separatedBy: "\n\n").first ?? step.description)
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
            }

            // Visual "Start" affordance — not a real Button; the entire card
            // is the tap target via the outer NavigationLink.
            HStack(spacing: Theme.Spacing.sm) {
                Text("Start")
                    .font(Theme.Typography.bodyMedium)
                Image(systemName: "arrow.right")
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Theme.Gradients.primaryButton)
            .cornerRadius(Theme.CornerRadius.md)
            .shadow(color: Theme.Colors.primaryBlue.opacity(0.5), radius: 20, x: 0, y: 0)
            .shadow(color: Theme.Colors.primaryBlue.opacity(0.3), radius: 40, x: 0, y: 0)
        }
        .padding(Theme.Spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .shadow(color: Theme.Colors.primaryBlue.opacity(0.1), radius: 40, x: 0, y: 0)
    }
}

#Preview {
    NextStepCard(step: DataService.shared.getAuthoredSteps(for: "AAA")[0])
        .padding()
        .background(Theme.Colors.background)
}
