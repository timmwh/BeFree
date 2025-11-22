//
//  TaskCard.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Task card component for step lists - matches Figma design
struct TaskCard: View {
    let title: String
    let duration: String
    let isCompleted: Bool
    let action: () -> Void
    
    init(title: String, duration: String, isCompleted: Bool = false, action: @escaping () -> Void = {}) {
        self.title = title
        self.duration = duration
        self.isCompleted = isCompleted
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.xl) {
                // Checkbox
                ZStack {
                    Circle()
                        .stroke(isCompleted ? Theme.Colors.primaryBlue : Theme.Colors.border, lineWidth: 1.9)
                        .frame(width: 24, height: 24)
                    
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Theme.Colors.primaryBlue)
                    }
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .tracking(-0.3125)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(Theme.Colors.textSecondary)
                        
                        Text(duration)
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

#Preview {
    VStack(spacing: 12) {
        TaskCard(
            title: "Define Your Business Idea",
            duration: "15 min",
            isCompleted: false
        )
        
        TaskCard(
            title: "Research Your Target Market",
            duration: "30 min",
            isCompleted: true
        )
        
        TaskCard(
            title: "Create Your First Marketing Campaign",
            duration: "45 min",
            isCompleted: false
        )
    }
    .padding()
    .background(Theme.Colors.background)
}

