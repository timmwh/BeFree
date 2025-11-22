//
//  PhaseChip.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct PhaseChip: View {
    let phase: BusinessPhase
    
    private var phaseData: (name: String, icon: String, color: Color, bg: Color, border: Color) {
        switch phase {
        case .setup:
            return ("Setup", "wrench.fill", Theme.Colors.phaseSetup, Theme.Colors.phaseSetupBg, Theme.Colors.phaseSetupBorder)
        case .action:
            return ("Action", "bolt.fill", Theme.Colors.phaseAction, Theme.Colors.phaseActionBg, Theme.Colors.phaseActionBorder)
        case .growth:
            return ("Growth", "chart.line.uptrend.xyaxis", Theme.Colors.phaseGrowth, Theme.Colors.phaseGrowthBg, Theme.Colors.phaseGrowthBorder)
        case .scale:
            return ("Scale", "arrow.up.right", Theme.Colors.phaseScale, Theme.Colors.phaseScaleBg, Theme.Colors.phaseScaleBorder)
        }
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: phaseData.icon)
                .font(.system(size: 12))
                .foregroundColor(phaseData.color)
            
            Text(phaseData.name)
                .font(Theme.Typography.small)
                .foregroundColor(phaseData.color)
                .tracking(0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(phaseData.bg)
        .cornerRadius(Theme.CornerRadius.pill)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                .stroke(phaseData.border, lineWidth: 0.633)
        )
    }
}

