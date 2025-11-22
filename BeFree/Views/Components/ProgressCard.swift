//
//  ProgressCard.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct ProgressCard: View {
    let completed: Int
    let total: Int
    
    var percentage: Int {
        guard total > 0 else { return 0 }
        return Int((Double(completed) / Double(total)) * 100)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                IconContainer(icon: "chart.line.uptrend.xyaxis", size: .small, style: .blue)
                
                Text("Progress")
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .tracking(-0.1504)
                
                Spacer()
            }
            
            HStack(alignment: .lastTextBaseline, spacing: Theme.Spacing.xs) {
                Text("\(percentage)%")
                    .font(Theme.Typography.heading2)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .tracking(0.0703)
                
                Spacer()
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.sm)
                        .fill(Theme.Colors.border)
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.sm)
                        .fill(Theme.Gradients.primaryButton)
                        .frame(width: geometry.size.width * (Double(completed) / Double(total)), height: 8)
                }
            }
            .frame(height: 8)
            
            Text("\(completed) of \(total) steps completed")
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .tracking(-0.1504)
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }
}

