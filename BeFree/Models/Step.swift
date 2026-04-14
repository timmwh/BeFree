//
//  Step.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

enum Phase: String, Codable {
    case foundation = "Foundation"
    case firstActions = "First Actions"
    case growth = "Growth"
    case advanced = "Advanced"
    
    var toBusinessPhase: BusinessPhase {
        switch self {
        case .foundation:
            return .setup
        case .firstActions:
            return .action
        case .growth:
            return .growth
        case .advanced:
            return .scale
        }
    }
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
    let subtasks: [String]
    let resources: [Resource]
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
        subtasks: [String] = [],
        resources: [Resource] = [],
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
        self.subtasks = subtasks
        self.resources = resources
        self.isCompleted = isCompleted
    }
}
