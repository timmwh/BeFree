//
//  UserProgress.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

struct UserProgress: Codable {
    var selectedModelId: UUID?
    var completedStepIds: [UUID]
    var currentStreak: Int
    var lastCompletedDate: Date?
    var streakDays: [Date] // Last 7 days of activity
    
    init(
        selectedModelId: UUID? = nil,
        completedStepIds: [UUID] = [],
        currentStreak: Int = 0,
        lastCompletedDate: Date? = nil,
        streakDays: [Date] = []
    ) {
        self.selectedModelId = selectedModelId
        self.completedStepIds = completedStepIds
        self.currentStreak = currentStreak
        self.lastCompletedDate = lastCompletedDate
        self.streakDays = streakDays
    }
}

