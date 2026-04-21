//
//  StepCard.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Step row used in the Roadmap step lists. Two visual variants driven by
/// `step.isCompleted`:
///
/// - **Pending** — `cardBackgroundMuted` background, empty 24px ring,
///   primary title, clock + duration, chevron.
/// - **Completed** — same shape with a filled `primaryBlue` circle + white
///   checkmark, title struck through in `textSecondary`, chevron unchanged.
struct StepCard: View {
    let step: Step
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Theme.Spacing.lg) {
                completionIndicator

                VStack(alignment: .leading, spacing: 4) {
                    Text(step.title)
                        .font(Theme.Typography.bodyMedium)
                        .foregroundColor(step.isCompleted ? Theme.Colors.textSecondary : Theme.Colors.textPrimary)
                        .strikethrough(step.isCompleted, color: Theme.Colors.textSecondary)
                        .multilineTextAlignment(.leading)

                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .font(.system(size: 11))
                            .foregroundColor(Theme.Colors.textSecondary)

                        Text("\(step.duration) min")
                            .font(Theme.Typography.small)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                }

                Spacer(minLength: Theme.Spacing.sm)

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(Theme.Spacing.lg)
            .background(Theme.Colors.cardBackgroundMuted)
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                    .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    private var completionIndicator: some View {
        if step.isCompleted {
            ZStack {
                Circle()
                    .fill(Theme.Colors.primaryBlue)
                    .frame(width: 24, height: 24)

                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        } else {
            Circle()
                .stroke(Theme.Colors.border, lineWidth: 1.9)
                .frame(width: 24, height: 24)
        }
    }
}
