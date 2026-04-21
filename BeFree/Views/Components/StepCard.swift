//
//  StepCard.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Roadmap step row per Figma 2002-1266.
///
/// Pure visual — the whole row is the tap target via the caller's
/// `NavigationLink` (or `Button`). Embedding a `Button` here would cause
/// nested-button issues and stop the outer `NavigationLink` from firing.
///
/// Variants driven by `step.isCompleted`:
/// - **Pending** — `cardBackground`, empty 28pt ring, primary 15pt title,
///   right-side duration pill.
/// - **Completed** — same shell with a filled `primaryBlue` 28pt circle
///   + white checkmark, title struck through in `textSecondary`.
struct StepCard: View {
    let step: Step

    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            completionIndicator

            Text(step.title)
                .font(.system(size: 15))
                .foregroundColor(step.isCompleted ? Theme.Colors.textSecondary : Theme.Colors.textPrimary)
                .strikethrough(step.isCompleted, color: Theme.Colors.textSecondary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            durationPill
        }
        .padding(.horizontal, Theme.Spacing.lg)
        .padding(.vertical, 16)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private var completionIndicator: some View {
        if step.isCompleted {
            ZStack {
                Circle()
                    .fill(Theme.Colors.primaryBlue)
                    .frame(width: 28, height: 28)

                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
        } else {
            Circle()
                .stroke(Theme.Colors.border, lineWidth: 1.9)
                .frame(width: 28, height: 28)
        }
    }

    private var durationPill: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock")
                .font(.system(size: 10))
                .foregroundColor(Theme.Colors.textSecondary)

            Text("\(step.duration) min")
                .font(.system(size: 11))
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .padding(.horizontal, 8)
        .frame(height: 22)
        .background(Color(hex: "252530").opacity(0.38))
        .cornerRadius(Theme.CornerRadius.pill)
    }
}
