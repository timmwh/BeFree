//
//  PersistenceService.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let userProgress = "userProgress"
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    private init() {}
    
    // MARK: - User Progress
    
    func saveUserProgress(_ progress: UserProgress) {
        if let encoded = try? JSONEncoder().encode(progress) {
            defaults.set(encoded, forKey: Keys.userProgress)
        }
    }
    
    func loadUserProgress() -> UserProgress {
        guard let data = defaults.data(forKey: Keys.userProgress),
              let progress = try? JSONDecoder().decode(UserProgress.self, from: data) else {
            return UserProgress()
        }
        return progress
    }
    
    // MARK: - Onboarding
    
    func setOnboardingCompleted(_ completed: Bool) {
        defaults.set(completed, forKey: Keys.hasCompletedOnboarding)
    }
    
    func hasCompletedOnboarding() -> Bool {
        return defaults.bool(forKey: Keys.hasCompletedOnboarding)
    }
    
    // MARK: - Streak Management
    
    func updateStreak(progress: inout UserProgress) {
        let now = Date()
        
        if let lastDate = progress.lastCompletedDate {
            let daysSinceLastCompletion = now.startOfDay().daysDifference(from: lastDate.startOfDay())
            
            if daysSinceLastCompletion == 0 {
                // Same day, no change to streak
                return
            } else if daysSinceLastCompletion == 1 {
                // Consecutive day, increment streak
                progress.currentStreak += 1
            } else {
                // Streak broken, reset to 1
                progress.currentStreak = 1
            }
        } else {
            // First completion
            progress.currentStreak = 1
        }
        
        progress.lastCompletedDate = now
        
        // Update streak days (last 7 days)
        updateStreakDays(progress: &progress)
    }
    
    private func updateStreakDays(progress: inout UserProgress) {
        let now = Date()
        let calendar = Calendar.current
        
        // Keep only dates from last 7 days
        progress.streakDays = progress.streakDays.filter { date in
            let daysDifference = now.startOfDay().daysDifference(from: date.startOfDay())
            return daysDifference >= 0 && daysDifference < 7
        }
        
        // Add today if not already there
        if !progress.streakDays.contains(where: { calendar.isDate($0, inSameDayAs: now) }) {
            progress.streakDays.append(now)
        }
    }
    
    // MARK: - Helper Methods
    
    func getStreakDaysArray(progress: UserProgress) -> [Bool] {
        let now = Date()
        let calendar = Calendar.current
        var streakArray = [Bool](repeating: false, count: 7)
        
        // Calculate which day of week today is (0 = Monday, 6 = Sunday)
        let todayWeekday = (calendar.component(.weekday, from: now) + 5) % 7
        
        // Fill in the array for the last 7 days
        for i in 0..<7 {
            let daysAgo = todayWeekday - i
            if daysAgo < 0 { continue }
            
            let targetDate = calendar.date(byAdding: .day, value: -daysAgo, to: now)!
            let hasActivity = progress.streakDays.contains { streakDate in
                calendar.isDate(streakDate, inSameDayAs: targetDate)
            }
            streakArray[i] = hasActivity
        }
        
        return streakArray
    }
    
    func getCurrentDayIndex() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        // Convert Sunday=1, Monday=2... to Monday=0, Tuesday=1...
        return (weekday + 5) % 7
    }
}

