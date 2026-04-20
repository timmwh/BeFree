//
//  Step.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation
import SwiftUI

/// Single source of truth for business phases. Matches the final 5-phase spine
/// (Foundation → Setup → Position → Launch → Scale). Used by both data (Step.phase)
/// and UI (PhaseChip, roadmap sections).
enum Phase: String, Codable, CaseIterable {
    case foundation = "Foundation"
    case setup      = "Setup"
    case position   = "Position"
    case launch     = "Launch"
    case scale      = "Scale"

    /// Base phase color from Figma tokens.
    var color: Color {
        switch self {
        case .foundation: return Theme.Colors.phaseFoundation
        case .setup:      return Theme.Colors.phaseSetup
        case .position:   return Theme.Colors.phasePosition
        case .launch:     return Theme.Colors.phaseLaunch
        case .scale:      return Theme.Colors.phaseScale
        }
    }

    /// Fill-background variant (`.opacity(0.2)`).
    var bg: Color { color.opacity(0.2) }

    /// Border variant (`.opacity(0.4)`).
    var border: Color { color.opacity(0.4) }
}

struct Step: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let duration: Int
    let phase: Phase
    let videoId: String
    let watchNotes: [String]
    let expectedOutput: String
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        duration: Int,
        phase: Phase,
        videoId: String = "",
        watchNotes: [String] = [],
        expectedOutput: String = "",
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.duration = duration
        self.phase = phase
        self.videoId = videoId
        self.watchNotes = watchNotes
        self.expectedOutput = expectedOutput
        self.isCompleted = isCompleted
    }
}
