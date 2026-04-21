//
//  PhaseChip.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Pill-shaped phase badge for the 5-phase spine. Renders one of three
/// visual states per Figma:
///
/// - `.active`    — fill-bg @ 0.2 + border @ 0.4 + label all in phase color.
/// - `.completed` — same shape with everything tinted Success-Green.
/// - `.locked`    — neutral grey at 60% opacity (used on locked Roadmap rows).
///
/// Default state is `.active` to keep existing call sites (`PhaseChip(phase:)`)
/// working unchanged.
struct PhaseChip: View {
    let phase: Phase
    var state: State = .active

    enum State {
        case active
        case completed
        case locked
    }

    private var icon: String {
        switch phase {
        case .foundation: return "cube.fill"
        case .setup:      return "wrench.and.screwdriver.fill"
        case .position:   return "scope"
        case .launch:     return "paperplane.fill"
        case .scale:      return "chart.line.uptrend.xyaxis"
        }
    }

    private var tint: Color {
        switch state {
        case .active:    return phase.color
        case .completed: return Theme.Colors.success
        case .locked:    return Theme.Colors.border
        }
    }

    private var bg: Color {
        switch state {
        case .active:    return phase.bg
        case .completed: return Theme.Colors.success.opacity(0.2)
        case .locked:    return Theme.Colors.border.opacity(0.2)
        }
    }

    private var borderColor: Color {
        switch state {
        case .active:    return phase.border
        case .completed: return Theme.Colors.success.opacity(0.4)
        case .locked:    return Theme.Colors.border.opacity(0.4)
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(tint)

            Text(phase.rawValue)
                .font(Theme.Typography.small)
                .foregroundColor(tint)
                .tracking(0)
        }
        .padding(.horizontal, 12.6)
        .padding(.vertical, 6.6)
        .background(bg)
        .cornerRadius(Theme.CornerRadius.pill)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                .stroke(borderColor, lineWidth: 0.633)
        )
        .opacity(state == .locked ? 0.6 : 1)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        ForEach(Phase.allCases, id: \.self) { phase in
            HStack(spacing: 8) {
                PhaseChip(phase: phase, state: .active)
                PhaseChip(phase: phase, state: .completed)
                PhaseChip(phase: phase, state: .locked)
            }
        }
    }
    .padding()
    .background(Theme.Colors.background)
}
