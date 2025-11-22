//
//  BenefitCard.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Card component displaying a benefit/feature with icon and checkmark
struct BenefitCard: View {
    let icon: String
    let title: String
    let showCheckmark: Bool
    
    init(icon: String, title: String, showCheckmark: Bool = true) {
        self.icon = icon
        self.title = title
        self.showCheckmark = showCheckmark
    }
    
    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            // Icon container
            IconContainer(icon: icon, size: .medium, style: .blue)
            
            // Title
            Text(title)
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textPrimaryOpacity)
                .tracking(-0.3125)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Checkmark
            if showCheckmark {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Theme.Colors.primaryBlue)
            }
        }
        .padding(.horizontal, Theme.Spacing.xl)
        .padding(.vertical, Theme.Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.divider, lineWidth: 0.633)
        )
    }
}

#Preview {
    VStack(spacing: 12) {
        BenefitCard(
            icon: "dollarsign.circle.fill",
            title: "Low startup cost (€0–€100)"
        )
        
        BenefitCard(
            icon: "chart.line.uptrend.xyaxis",
            title: "High demand from businesses"
        )
        
        BenefitCard(
            icon: "arrow.up.right",
            title: "Scalable service model"
        )
        
        BenefitCard(
            icon: "book.fill",
            title: "Learn valuable marketing skills",
            showCheckmark: false
        )
    }
    .padding()
    .background(Theme.Colors.background)
}

