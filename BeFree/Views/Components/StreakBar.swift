//
//  StreakBar.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Horizontal 7-day streak ribbon. Container uses `cardBackgroundMuted`
/// (per Figma's transparent-card look). Three day states:
///
/// - **Completed** — filled `primaryBlue` circle (44pt) with a white
///   `checkmark` and a soft blue glow.
/// - **Today** — empty 44pt outline (2.089pt stroke) in `primaryBlue`,
///   blue glow, plus a 14pt inner dot in `primaryBlue`.
/// - **Future** — empty 44pt outline in `border`, no glow.
struct StreakBar: View {
    let streakDays: [Bool]    // 7 days, true = completed
    let currentDayIndex: Int  // 0-6 (Mon-Sun)

    private let dayLabels = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            ForEach(0..<7, id: \.self) { index in
                VStack(spacing: Theme.Spacing.xs) {
                    dayCircle(for: index)

                    Text(dayLabels[index])
                        .font(Theme.Typography.small)
                        .foregroundColor(currentDayIndex == index ? Theme.Colors.textPrimary : Theme.Colors.textSecondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.cardBackgroundMuted)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }

    @ViewBuilder
    private func dayCircle(for index: Int) -> some View {
        let isCompleted = streakDays[index]
        let isToday = currentDayIndex == index

        ZStack {
            if isCompleted {
                Circle()
                    .fill(Theme.Colors.primaryBlue)
                    .frame(width: 44, height: 44)
                    .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 12, x: 0, y: 0)

                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            } else if isToday {
                Circle()
                    .stroke(Theme.Colors.primaryBlue, lineWidth: 2.089)
                    .frame(width: 44, height: 44)
                    .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 12, x: 0, y: 0)

                Circle()
                    .fill(Theme.Colors.primaryBlue)
                    .frame(width: 14, height: 14)
            } else {
                Circle()
                    .stroke(Theme.Colors.border, lineWidth: 1.5)
                    .frame(width: 44, height: 44)
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        StreakBar(
            streakDays: [true, true, false, false, false, false, false],
            currentDayIndex: 2
        )
        StreakBar(
            streakDays: [true, true, true, true, true, true, true],
            currentDayIndex: 6
        )
    }
    .padding()
    .background(Theme.Colors.background)
}
