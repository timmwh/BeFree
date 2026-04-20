//
//  PhaseChip.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Pill-shaped phase badge. Phase 1 adds active/completed/locked states;
/// Phase 0 only migrates the enum and tokens.
struct PhaseChip: View {
    let phase: Phase

    private var icon: String {
        switch phase {
        case .foundation: return "cube.fill"
        case .setup:      return "wrench.and.screwdriver.fill"
        case .position:   return "scope"
        case .launch:     return "paperplane.fill"
        case .scale:      return "chart.line.uptrend.xyaxis"
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(phase.color)

            Text(phase.rawValue)
                .font(Theme.Typography.small)
                .foregroundColor(phase.color)
                .tracking(0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(phase.bg)
        .cornerRadius(Theme.CornerRadius.pill)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                .stroke(phase.border, lineWidth: 0.633)
        )
    }
}
