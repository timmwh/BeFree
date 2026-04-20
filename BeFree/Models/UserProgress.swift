//
//  UserProgress.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

// MARK: - Onboarding profile (internal, never rendered in UI)

/// Experience level captured during onboarding. Drives the match
/// recommendation + is fed to the AI match-explanation prompt. Never rendered.
enum ExperienceLevel: String, Codable, CaseIterable {
    case beginner
    case someExperience
    case experienced
}

/// Goal captured during onboarding. Drives the match recommendation + is fed
/// to the AI match-explanation prompt. Never rendered.
enum BusinessGoal: String, Codable, CaseIterable {
    case sideIncome
    case fullBusiness
    case replaceJob
}

// MARK: - UserProgress

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

    // Onboarding profile — internal, never shown in UI.
    var onboardingExperience: ExperienceLevel?
    var onboardingGoal: BusinessGoal?

    // Community identity — edited via EditProfile, shown on ProfileView.
    var firstName: String?
    var lastName: String?
    var username: String?

    init(
        selectedModelShortName: String? = nil,
        completedStepIds: [UUID] = [],
        currentStreak: Int = 0,
        lastCompletedDate: Date? = nil,
        streakDays: [Date] = [],
        totalSessionSeconds: Int = 0,
        doPhaseStepIds: Set<UUID> = [],
        onboardingExperience: ExperienceLevel? = nil,
        onboardingGoal: BusinessGoal? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        username: String? = nil
    ) {
        self.selectedModelShortName = selectedModelShortName
        self.completedStepIds = completedStepIds
        self.currentStreak = currentStreak
        self.lastCompletedDate = lastCompletedDate
        self.streakDays = streakDays
        self.totalSessionSeconds = totalSessionSeconds
        self.doPhaseStepIds = doPhaseStepIds
        self.onboardingExperience = onboardingExperience
        self.onboardingGoal = onboardingGoal
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
    }

    // MARK: - Computed

    /// Two-letter avatar initials derived from the community identity.
    /// Falls back to "?" when no name is set yet.
    var avatarInitials: String {
        let first = firstName?.trimmingCharacters(in: .whitespacesAndNewlines).first.map { String($0) } ?? ""
        let last = lastName?.trimmingCharacters(in: .whitespacesAndNewlines).first.map { String($0) } ?? ""
        let combined = (first + last).uppercased()
        return combined.isEmpty ? "?" : combined
    }

    /// Full display name. Falls back to "Your Profile" when no name is set.
    var displayName: String {
        let first = firstName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let last = lastName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let combined = [first, last].filter { !$0.isEmpty }.joined(separator: " ")
        return combined.isEmpty ? "Your Profile" : combined
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
        case onboardingExperience
        case onboardingGoal
        case firstName
        case lastName
        case username
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
        self.onboardingExperience = try container.decodeIfPresent(ExperienceLevel.self, forKey: .onboardingExperience)
        self.onboardingGoal = try container.decodeIfPresent(BusinessGoal.self, forKey: .onboardingGoal)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
    }
}
