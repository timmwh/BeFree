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
    /// Steps where the user already reached the "Do" phase (pressed Continue)
    /// but has not yet marked the step as completed. Used to resume the user
    /// directly in the Do phase when re-opening an unfinished step.
    /// Cleared on final Complete of the step.
    var doPhaseStepIds: Set<UUID>

    init(
        selectedModelShortName: String? = nil,
        completedStepIds: [UUID] = [],
        currentStreak: Int = 0,
        lastCompletedDate: Date? = nil,
        streakDays: [Date] = [],
        totalSessionSeconds: Int = 0,
        doPhaseStepIds: Set<UUID> = []
    ) {
        self.selectedModelShortName = selectedModelShortName
        self.completedStepIds = completedStepIds
        self.currentStreak = currentStreak
        self.lastCompletedDate = lastCompletedDate
        self.streakDays = streakDays
        self.totalSessionSeconds = totalSessionSeconds
        self.doPhaseStepIds = doPhaseStepIds
    }

    // MARK: - Codable (backward compatible)

    private enum CodingKeys: String, CodingKey {
        case selectedModelShortName
        case completedStepIds
        case currentStreak
        case lastCompletedDate
        case streakDays
        case totalSessionSeconds
        case doPhaseStepIds
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedModelShortName = try container.decodeIfPresent(String.self, forKey: .selectedModelShortName)
        self.completedStepIds = try container.decodeIfPresent([UUID].self, forKey: .completedStepIds) ?? []
        self.currentStreak = try container.decodeIfPresent(Int.self, forKey: .currentStreak) ?? 0
        self.lastCompletedDate = try container.decodeIfPresent(Date.self, forKey: .lastCompletedDate)
        self.streakDays = try container.decodeIfPresent([Date].self, forKey: .streakDays) ?? []
        self.totalSessionSeconds = try container.decodeIfPresent(Int.self, forKey: .totalSessionSeconds) ?? 0
        self.doPhaseStepIds = try container.decodeIfPresent(Set<UUID>.self, forKey: .doPhaseStepIds) ?? []
    }
}
