//
//  AICoachEntry.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// "Ask your coach" call-out used on the Do-phase StepDetail. Reusable shell
/// with a 44pt blue-gradient icon container, two-line title/subtitle, and a
/// chevron. Tap fires `onTap`.
struct AICoachEntry: View {
    var title: String = "Ask your coach"
    var subtitle: String = "Stuck or have a question? Get instant guidance."
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Theme.Spacing.md) {
                ZStack {
                    Theme.Gradients.primaryButton
                    Image(systemName: "sparkles")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: 44)
                .cornerRadius(Theme.CornerRadius.sm)
                .subtleGlow()

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(Theme.Typography.bodyMedium)
                        .foregroundColor(Theme.Colors.textPrimary)
                    Text(subtitle)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(Theme.Spacing.lg)
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                    .stroke(Theme.Colors.primaryBlue.opacity(0.3), lineWidth: 0.633)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AICoachEntry(onTap: {})
        .padding()
        .background(Theme.Colors.background)
}
