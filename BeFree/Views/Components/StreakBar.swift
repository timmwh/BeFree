//
//  StreakBar.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

// Figma 2042:3891 / 2091:138 (WeeklyBarSlot).
//
// Layout strategy — edge-bleed (Figma-faithful):
//   The design node explicitly sets left:-16 and width:393.8 inside a 16pt-padded
//   container, meaning the streak card is intentionally edge-to-edge. We honour
//   this with fixed 44pt circles + static spacing; the caller (DashboardView)
//   applies .padding(.horizontal, -16) to bleed past the scroll-view padding.
//
//   This avoids every bug from the old implementation:
//   • No GeometryReader → no subtraction-then-re-pad double-padding.
//   • Sizes are never derived at runtime → no shrunken 32pt circles.
//   • The card is never a sibling inside a ZStack → no width-negotiation issue.

/// Horizontal 7-day streak row (Figma `2042:3891`). Fixed 44 pt circles; edge-bleed handled by caller.
struct StreakBar: View {
    let streakDays: [Bool]    // 7 entries, true = completed
    let currentDayIndex: Int  // 0-based Mon-Sun

    private let dayLabels = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        HStack(spacing: Theme.DashboardLayout.streakColumnSpacing) {
            ForEach(0..<7, id: \.self) { index in
                dayColumn(index: index)
            }
        }
        // 8 pt inner padding on all sides so circles never touch the card border.
        // Column layout is 44 pt wide (see dayColumn), so the today ring (51 pt) has
        // 8 - 3.5 = 4.5 pt visual clearance — enough to avoid clipping at the corners.
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: Theme.DashboardLayout.streakCardHeight)
        .background(Theme.Colors.cardBackgroundMuted)
        .cornerRadius(Theme.DashboardLayout.streakCardCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.DashboardLayout.streakCardCornerRadius)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }

    // MARK: - Day column

    private func dayColumn(index: Int) -> some View {
        VStack(spacing: Theme.DashboardLayout.streakDayLabelSpacing) {
            dayCircle(for: index)

            Text(dayLabels[index])
                .font(Theme.Typography.small)
                .foregroundColor(
                    currentDayIndex == index ? Theme.Colors.textPrimary : Theme.Colors.textSecondary
                )
        }
        // Constrain the column to the base circle size so the today ring (51 pt)
        // visually overflows its column without widening the HStack layout.
        .frame(width: Theme.DashboardLayout.streakCircleSize)
    }

    // MARK: - Circle states

    @ViewBuilder
    private func dayCircle(for index: Int) -> some View {
        let isCompleted = streakDays[index]
        let isToday = currentDayIndex == index

        if isCompleted {
            completedCircle
        } else if isToday {
            todayCircle
        } else {
            futureCircle
        }
    }

    // Figma 2042:3893 — blue gradient fill + double glow.
    private var completedCircle: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Theme.Colors.primaryBlue, Theme.Colors.secondaryBlue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: Theme.DashboardLayout.streakCircleSize,
                       height: Theme.DashboardLayout.streakCircleSize)
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 5, x: 0, y: 0)
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.2), radius: 10, x: 0, y: 0)

            Image(systemName: "checkmark")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
        }
        .frame(width: Theme.DashboardLayout.streakCircleSize,
               height: Theme.DashboardLayout.streakCircleSize)
    }

    // Figma 2042:3913 — outer ring 51pt with glow + inner solid dot 15pt.
    private var todayCircle: some View {
        let ring = Theme.DashboardLayout.streakTodayRingSize
        let border = Theme.DashboardLayout.streakTodayRingBorder
        let dot = Theme.DashboardLayout.streakTodayInnerDot

        return ZStack {
            Circle()
                .fill(Theme.Colors.primaryBlue.opacity(0.2))
                .overlay(
                    Circle()
                        .stroke(Theme.Colors.primaryBlue, lineWidth: border)
                )
                .frame(width: ring, height: ring)
                .shadow(
                    color: Theme.Colors.primaryBlue.opacity(0.46),
                    radius: Theme.DashboardLayout.streakTodayRingShadow,
                    x: 0, y: 0
                )

            Circle()
                .fill(Theme.Colors.primaryBlue)
                .frame(width: dot, height: dot)
        }
        // Frame the today cell at the ring size so it doesn't clip.
        .frame(width: ring, height: ring)
    }

    // Figma 2042:3916 — muted fill + hairline border.
    private var futureCircle: some View {
        Circle()
            .fill(Color(hex: "1f1f2e").opacity(0.5))
            .overlay(
                Circle()
                    .stroke(Theme.Colors.border, lineWidth: 0.633)
            )
            .frame(width: Theme.DashboardLayout.streakCircleSize,
                   height: Theme.DashboardLayout.streakCircleSize)
    }
}

#Preview {
    VStack(spacing: 16) {
        StreakBar(
            streakDays: [true, true, true, false, false, false, false],
            currentDayIndex: 3
        )
        StreakBar(
            streakDays: [true, true, true, true, true, true, true],
            currentDayIndex: 6
        )
    }
    .padding(.horizontal, 16)
    .background(Theme.Colors.background)
}
