//
//  StatCard.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Stat card component showing metrics with icon
struct StatCard: View {
    let icon: String
    let label: String
    let value: String
    
    init(icon: String, label: String, value: String) {
        self.icon = icon
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            // Icon
            IconContainer(icon: icon, size: .medium, style: .blue)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .tracking(-0.1504)
                
                Text(value)
                    .font(Theme.Typography.heading2)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .tracking(0.0703)
            }
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        StatCard(
            icon: "checkmark.circle.fill",
            label: "Steps Completed",
            value: "3/12"
        )
        
        StatCard(
            icon: "flame.fill",
            label: "Day Streak",
            value: "7"
        )
        
        StatCard(
            icon: "chart.line.uptrend.xyaxis",
            label: "Progress",
            value: "25%"
        )
    }
    .padding()
    .background(Theme.Colors.background)
}

