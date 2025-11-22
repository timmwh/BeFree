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
        // Load business model (SMMA for MVP)
        let models = dataService.getBusinessModels()
        if let smma = models.first {
            businessModel = smma
            if userProgress.selectedModelId == nil {
                userProgress.selectedModelId = smma.id
                saveProgress()
            }
        }
        
        // Load all steps
        allSteps = dataService.getFoundationSteps() + dataService.getFirstActionsSteps()
        
        // Update completion status from saved progress
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
        return foundationSteps.count + 2 // Foundation + 2 placeholder first actions
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
    
    // MARK: - Actions
    
    func completeStep(_ step: Step) {
        // Mark step as completed
        if !userProgress.completedStepIds.contains(step.id) {
            userProgress.completedStepIds.append(step.id)
        }
        
        // Update streak
        persistenceService.updateStreak(progress: &userProgress)
        
        // Update step completion status
        if let index = allSteps.firstIndex(where: { $0.id == step.id }) {
            allSteps[index].isCompleted = true
        }
        
        // Save progress
        saveProgress()
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        persistenceService.setOnboardingCompleted(true)
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

