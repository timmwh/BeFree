//
//  StreakBar.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct StreakBar: View {
    let streakDays: [Bool] // Last 7 days, true if completed
    let currentDayIndex: Int // Which day is today (0-6)
    
    private let dayLabels = ["M", "T", "W", "T", "F", "S", "S"]
    
    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            ForEach(0..<7, id: \.self) { index in
                VStack(spacing: Theme.Spacing.xs) {
                    ZStack {
                        // Background circle
                        Circle()
                            .fill(streakDays[index] ? Theme.Colors.primaryBlue : Theme.Colors.cardBackground)
                            .frame(width: 44, height: 44)
                        
                        // Today indicator ring
                        if currentDayIndex == index {
                            Circle()
                                .stroke(Theme.Colors.primaryBlue, lineWidth: 2)
                                .frame(width: 44, height: 44)
                        }
                        
                        // Checkmark or dot
                        if streakDays[index] {
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        } else if currentDayIndex == index {
                            Circle()
                                .fill(Theme.Colors.primaryBlue)
                                .frame(width: 12, height: 12)
                        }
                    }
                    
                    Text(dayLabels[index])
                        .font(Theme.Typography.small)
                        .foregroundColor(currentDayIndex == index ? Theme.Colors.textPrimary : Theme.Colors.textSecondary)
                }
            }
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }
}

