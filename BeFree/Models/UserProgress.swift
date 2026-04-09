//
//  UserProgress.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

struct UserProgress: Codable {
    var selectedModelShortName: String?
    var completedStepIds: [UUID]
    var currentStreak: Int
    var lastCompletedDate: Date?
    var streakDays: [Date]
    var totalSessionSeconds: Int

    init(
        selectedModelShortName: String? = nil,
        completedStepIds: [UUID] = [],
        currentStreak: Int = 0,
        lastCompletedDate: Date? = nil,
        streakDays: [Date] = [],
        totalSessionSeconds: Int = 0
    ) {
        self.selectedModelShortName = selectedModelShortName
        self.completedStepIds = completedStepIds
        self.currentStreak = currentStreak
        self.lastCompletedDate = lastCompletedDate
        self.streakDays = streakDays
        self.totalSessionSeconds = totalSessionSeconds
    }
}

