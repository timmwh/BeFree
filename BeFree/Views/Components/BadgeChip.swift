//
//  BadgeChip.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Badge and chip components for status, phases, and labels
struct BadgeChip: View {
    let text: String
    let icon: String?
    let variant: BadgeVariant
    
    enum BadgeVariant {
        // Phase badges (with icon)
        case phaseSetup
        case phaseAction
        case phaseGrowth
        case phaseScale
        
        // Status badges (no icon)
        case statusPrimary
        case statusSuccess
        case statusWarning
        case statusError
        
        // Special badges
        case new                // Gradient badge with sparkle icon
        case count(Int)         // Circular count badge
        
        var colors: (bg: Color, border: Color, text: Color) {
            switch self {
            case .phaseSetup:
                return (Theme.Colors.phaseSetupBg, Theme.Colors.phaseSetupBorder, Theme.Colors.phaseSetup)
            case .phaseAction:
                return (Theme.Colors.phaseActionBg, Theme.Colors.phaseActionBorder, Theme.Colors.phaseAction)
            case .phaseGrowth:
                return (Theme.Colors.phaseGrowthBg, Theme.Colors.phaseGrowthBorder, Theme.Colors.phaseGrowth)
            case .phaseScale:
                return (Theme.Colors.phaseScaleBg, Theme.Colors.phaseScaleBorder, Theme.Colors.phaseScale)
            case .statusPrimary:
                return (Theme.Colors.phaseSetupBg, Theme.Colors.phaseSetupBorder, Theme.Colors.phaseSetup)
            case .statusSuccess:
                return (Theme.Colors.successBg, Theme.Colors.successBorder, Theme.Colors.success)
            case .statusWarning:
                return (Theme.Colors.warningBg, Theme.Colors.warningBorder, Theme.Colors.warning)
            case .statusError:
                return (Theme.Colors.errorBg, Theme.Colors.errorBorder, Theme.Colors.error)
            case .new:
                return (.clear, .clear, .white)
            case .count:
                return (Theme.Colors.primaryBlue, .clear, .white)
            }
        }
        
        var isGradient: Bool {
            if case .new = self { return true }
            return false
        }
        
        var isPill: Bool {
            if case .count = self { return true }
            return true
        }
    }
    
    init(_ text: String, icon: String? = nil, variant: BadgeVariant) {
        self.text = text
        self.icon = icon
        self.variant = variant
    }
    
    var body: some View {
        HStack(spacing: 6) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(variant.colors.text)
            }
            
            Text(text)
                .font(Theme.Typography.small)
                .foregroundColor(variant.colors.text)
                .tracking(0)
        }
        .padding(.horizontal, variant.isPill ? 12 : 6)
        .padding(.vertical, variant.isPill ? 6 : 4)
        .background(
            Group {
                if variant.isGradient {
                    Theme.Gradients.primaryButton
                } else {
                    variant.colors.bg
                }
            }
        )
        .cornerRadius(Theme.CornerRadius.pill)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                .stroke(variant.colors.border, lineWidth: variant.isGradient ? 0 : 0.633)
        )
        .if(variant.isGradient) { view in
            view.subtleGlow()
        }
    }
}

// MARK: - Specialized Badge Views

/// Phase chip with icon - Used in roadmap
struct PhaseChipView: View {
    let phase: BusinessPhase
    
    var body: some View {
        switch phase {
        case .setup:
            BadgeChip("Setup", icon: "wrench.and.screwdriver.fill", variant: .phaseSetup)
        case .action:
            BadgeChip("Action", icon: "bolt.fill", variant: .phaseAction)
        case .growth:
            BadgeChip("Growth", icon: "chart.line.uptrend.xyaxis", variant: .phaseGrowth)
        case .scale:
            BadgeChip("Scale", icon: "arrow.up.right", variant: .phaseScale)
        }
    }
}

/// Status badge - Simple text badge
struct StatusBadge: View {
    enum Status {
        case primary, success, warning, error
        
        var badgeVariant: BadgeChip.BadgeVariant {
            switch self {
            case .primary: return .statusPrimary
            case .success: return .statusSuccess
            case .warning: return .statusWarning
            case .error: return .statusError
            }
        }
    }
    
    let status: Status
    let text: String
    
    init(_ status: Status, text: String) {
        self.status = status
        self.text = text
    }
    
    var body: some View {
        BadgeChip(text, variant: status.badgeVariant)
    }
}

/// New badge with sparkle icon
struct NewBadge: View {
    var body: some View {
        BadgeChip("✨ NEW", variant: .new)
    }
}

/// Count badge - Circular badge with number
struct CountBadge: View {
    let count: Int
    
    var displayText: String {
        count > 9 ? "9+" : "\(count)"
    }
    
    var body: some View {
        Text(displayText)
            .font(Theme.Typography.small)
            .foregroundColor(.white)
            .frame(minWidth: 20, minHeight: 20)
            .padding(.horizontal, count > 9 ? 6 : 0)
            .background(Theme.Colors.primaryBlue)
            .cornerRadius(Theme.CornerRadius.pill)
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            // Phase Chips
            VStack(alignment: .leading, spacing: 12) {
                Text("Phase Chips")
                    .font(Theme.Typography.heading3)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                HStack(spacing: 8) {
                    BadgeChip("Setup", icon: "wrench.fill", variant: .phaseSetup)
                    BadgeChip("Action", icon: "bolt.fill", variant: .phaseAction)
                }
                
                HStack(spacing: 8) {
                    BadgeChip("Growth", icon: "chart.line.uptrend.xyaxis", variant: .phaseGrowth)
                    BadgeChip("Scale", icon: "arrow.up.right", variant: .phaseScale)
                }
            }
            
            // Status Badges
            VStack(alignment: .leading, spacing: 12) {
                Text("Status Badges")
                    .font(Theme.Typography.heading3)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                HStack(spacing: 8) {
                    StatusBadge(.primary, text: "Primary")
                    StatusBadge(.success, text: "Success")
                    StatusBadge(.warning, text: "Warning")
                    StatusBadge(.error, text: "Error")
                }
            }
            
            // Special Badges
            VStack(alignment: .leading, spacing: 12) {
                Text("Special Badges")
                    .font(Theme.Typography.heading3)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                HStack(spacing: 12) {
                    NewBadge()
                    CountBadge(count: 3)
                    CountBadge(count: 12)
                }
            }
        }
        .padding()
    }
    .background(Theme.Colors.background)
}

