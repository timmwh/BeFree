//
//  AppViewModel.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var userProgress: UserProgress
    @Published var allSteps: [Step] = []
    @Published var businessModel: BusinessModel?
    @Published var hasCompletedOnboarding: Bool
    
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
        
        allSteps = dataService.getFoundationSteps(for: businessModel?.shortName ?? "SMMA") + dataService.getFirstActionsSteps()
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
    
    var foundationSteps: [Step] {
        return allSteps.filter { $0.phase == .foundation }
    }
    
    var firstActionsSteps: [Step] {
        return allSteps.filter { $0.phase == .firstActions }
    }
    
    var completedStepsCount: Int {
        return userProgress.completedStepIds.count
    }
    
    var totalStepsCount: Int {
        return foundationSteps.count + firstActionsSteps.count
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
        
        saveProgress()
    }
    
    func selectModel(_ model: BusinessModel) {
        businessModel = model
        userProgress.selectedModelShortName = model.shortName
        allSteps = dataService.getFoundationSteps(for: model.shortName) + dataService.getFirstActionsSteps()
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
        updateStepsCompletionStatus()
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
