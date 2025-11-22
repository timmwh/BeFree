//
//  StepCard.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct StepCard: View {
    let step: Step
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Theme.Spacing.xl) {
                // Completion indicator (checkbox)
                ZStack {
                    Circle()
                        .stroke(step.isCompleted ? Theme.Colors.primaryBlue : Theme.Colors.border, lineWidth: 1.9)
                        .frame(width: 24, height: 24)
                    
                    if step.isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Theme.Colors.primaryBlue)
                    }
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(step.title)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .tracking(-0.3125)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(Theme.Colors.textSecondary)
                        
                        Text("\(step.duration) min")
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .tracking(-0.1504)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.vertical, Theme.Spacing.lg)
            .background(Theme.Colors.cardBackground.opacity(0.5))
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                    .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

