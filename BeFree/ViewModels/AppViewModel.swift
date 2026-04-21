//
//  AppViewModel.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation
import Combine

/// Top-level tabs. Used both as `TabView.selection` and as a bindable
/// state other screens can mutate to request a tab switch
/// (e.g. Dashboard's "Roadmap →" link).
enum AppTab: Hashable {
    case start
    case roadmap
    case profile
}

class AppViewModel: ObservableObject {
    @Published var userProgress: UserProgress
    @Published var allSteps: [Step] = []
    @Published var businessModel: BusinessModel?
    @Published var hasCompletedOnboarding: Bool
    @Published var selectedTab: AppTab = .start
    
    private let dataService = DataService.shared
    private let persistenceService = PersistenceService.shared
    
    init() {
        self.userProgress = persistenceService.loadUserProgress()
        self.hasCompletedOnboarding = persistenceService.hasCompletedOnboarding()
        loadData()
    }
    
    // MARK: - Data Loading
    
    private func loadData() {
        let models = dataService.getBusinessModels()
        
        if let shortName = userProgress.selectedModelShortName,
           let saved = models.first(where: { $0.shortName == shortName }) {
            businessModel = saved
        } else if !hasCompletedOnboarding {
            // Onboarding will set the model — don't auto-select
            businessModel = nil
        } else {
            // Fallback: default to first model
            businessModel = models.first
        }

        allSteps = dataService.getAuthoredSteps(for: businessModel?.shortName ?? "AAA")
        updateStepsCompletionStatus()
    }
    
    private func updateStepsCompletionStatus() {
        for index in allSteps.indices {
            allSteps[index].isCompleted = userProgress.completedStepIds.contains(allSteps[index].id)
        }
    }
    
    // MARK: - Computed Properties

    var nextStep: Step? {
        return allSteps.first { !$0.isCompleted }
    }

    /// Returns all authored steps for a given phase, in canonical order.
    /// Scale currently has no authored steps in the MVP.
    func steps(for phase: Phase) -> [Step] {
        return allSteps.filter { $0.phase == phase }
    }

    /// 1-based ordinal of a step within the full authored sequence
    /// (Foundation → Setup → Position → Launch). Returns nil for unknown steps
    /// and for Scale-phase steps (Scale is excluded from the counter).
    func stepIndex(of step: Step) -> Int? {
        guard step.phase != .scale,
              let idx = allSteps.firstIndex(where: { $0.id == step.id })
        else { return nil }
        return idx + 1
    }

    var completedStepsCount: Int {
        return userProgress.completedStepIds.count
    }

    /// Total authored steps across all active phases (excludes Scale, which has no steps in MVP).
    var totalStepsCount: Int {
        return allSteps.count
    }
    
    var progressPercentage: Int {
        guard totalStepsCount > 0 else { return 0 }
        return Int((Double(completedStepsCount) / Double(totalStepsCount)) * 100)
    }
    
    var streakDays: [Bool] {
        return persistenceService.getStreakDaysArray(progress: userProgress)
    }
    
    var currentDayIndex: Int {
        return persistenceService.getCurrentDayIndex()
    }
    
    var allBusinessModels: [BusinessModel] {
        return dataService.getBusinessModels()
    }
    
    // MARK: - Actions
    
    func completeStep(_ step: Step, sessionSeconds: Int = 0) {
        if !userProgress.completedStepIds.contains(step.id) {
            userProgress.completedStepIds.append(step.id)
        }
        
        if sessionSeconds > 0 {
            userProgress.totalSessionSeconds += sessionSeconds
        }
        
        persistenceService.updateStreak(progress: &userProgress)
        
        if let index = allSteps.firstIndex(where: { $0.id == step.id }) {
            allSteps[index].isCompleted = true
        }

        // Clean up transient phase marker once the step is truly complete.
        userProgress.doPhaseStepIds.remove(step.id)

        saveProgress()
    }

    // MARK: - Do-phase resume marker

    /// Remembers that the user has already advanced past the Watch phase
    /// (i.e. pressed Continue) for this step. Used to resume directly in
    /// the Do phase when re-opening an unfinished step.
    func markDoPhaseEntered(_ step: Step) {
        guard !userProgress.completedStepIds.contains(step.id) else { return }
        let (inserted, _) = userProgress.doPhaseStepIds.insert(step.id)
        if inserted {
            saveProgress()
        }
    }

    func hasEnteredDoPhase(_ step: Step) -> Bool {
        return userProgress.doPhaseStepIds.contains(step.id)
    }
    
    func selectModel(_ model: BusinessModel) {
        businessModel = model
        userProgress.selectedModelShortName = model.shortName
        allSteps = dataService.getAuthoredSteps(for: model.shortName)
        updateStepsCompletionStatus()
        saveProgress()
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        persistenceService.setOnboardingCompleted(true)
    }

    func resetProgress() {
        userProgress.completedStepIds = []
        userProgress.currentStreak = 0
        userProgress.lastCompletedDate = nil
        userProgress.streakDays = []
        userProgress.totalSessionSeconds = 0
        userProgress.doPhaseStepIds = []
        updateStepsCompletionStatus()
        saveProgress()
    }

    // MARK: - Onboarding profile (internal)

    /// Persists onboarding profile answers. Never rendered in UI; used only
    /// as input for the AI match-explanation prompt.
    func setOnboardingProfile(experience: ExperienceLevel?, goal: BusinessGoal?) {
        userProgress.onboardingExperience = experience
        userProgress.onboardingGoal = goal
        saveProgress()
    }

    // MARK: - Community identity (visible on Profile / Edit Profile)

    func setCommunityProfile(firstName: String?, lastName: String?, username: String?) {
        userProgress.firstName = firstName
        userProgress.lastName = lastName
        userProgress.username = username
        saveProgress()
    }

    private func saveProgress() {
        persistenceService.saveUserProgress(userProgress)
    }
    
    // MARK: - Helpers
    
    func getStep(by id: UUID) -> Step? {
        return allSteps.first { $0.id == id }
    }
    
    func greeting() -> String {
        return Date().timeOfDayGreeting()
    }
}
