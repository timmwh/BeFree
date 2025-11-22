//
//  BusinessPhase.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import Foundation

/// Business phase enum for UI components - matches Figma design
enum BusinessPhase: String, Codable, CaseIterable {
    case setup = "Setup"
    case action = "Action"
    case growth = "Growth"
    case scale = "Scale"
}

