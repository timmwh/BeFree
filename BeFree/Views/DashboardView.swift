//
//  DashboardView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var navigateToStepDetail = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                    // Greeting
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(viewModel.greeting()), Tim")
                            .font(Theme.Typography.largeTitle)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        Text("Let's build your business today.")
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                    .padding(.top, Theme.Spacing.md)
                    
                    // Streak Bar
                    StreakBar(
                        streakDays: viewModel.streakDays,
                        currentDayIndex: viewModel.currentDayIndex
                    )
                    
                    // Next Step Section
                    if let nextStep = viewModel.nextStep {
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(Theme.Colors.primaryBlue)
                                
                                Text("Next Step")
                                    .font(Theme.Typography.bodyBold)
                                    .foregroundColor(Theme.Colors.textPrimary)
                            }
                            
                            // Next Step Card
                            VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                                    Text(nextStep.title)
                                        .font(Theme.Typography.title2)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                    
                                    Text(nextStep.description.components(separatedBy: "\n\n").first ?? nextStep.description)
                                        .font(Theme.Typography.callout)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                        .lineLimit(3)
                                    
                                    HStack(spacing: Theme.Spacing.xs) {
                                        Image(systemName: "clock")
                                            .font(.system(size: 12))
                                        Text("\(nextStep.duration) min")
                                            .font(Theme.Typography.caption)
                                    }
                                    .foregroundColor(Theme.Colors.textSecondary)
                                }
                                
                                NavigationLink(destination: StepDetailView(step: nextStep)) {
                                    HStack(spacing: Theme.Spacing.sm) {
                                        Text("Start")
                                            .font(Theme.Typography.bodyBold)
                                        
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                    .foregroundColor(Theme.Colors.textPrimary)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(
                                        LinearGradient(
                                            colors: [Theme.Colors.primaryBlue, Theme.Colors.secondaryBlue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(Theme.CornerRadius.md)
                                }
                            }
                            .padding(Theme.Spacing.lg)
                            .background(Theme.Colors.cardBackground)
                            .cornerRadius(Theme.CornerRadius.lg)
                        }
                    } else {
                        // All steps completed
                        VStack(spacing: Theme.Spacing.md) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 64))
                                .foregroundColor(Theme.Colors.success)
                            
                            Text("Congratulations!")
                                .font(Theme.Typography.title2)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            Text("You've completed all available steps")
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(Theme.Spacing.xl)
                        .background(Theme.Colors.cardBackground)
                        .cornerRadius(Theme.CornerRadius.lg)
                    }
                    
                    // Progress Section
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 16))
                                .foregroundColor(Theme.Colors.primaryBlue)
                            
                            Text("Progress")
                                .font(Theme.Typography.bodyBold)
                                .foregroundColor(Theme.Colors.textPrimary)
                        }
                        
                        ProgressCard(
                            completed: viewModel.completedStepsCount,
                            total: viewModel.totalStepsCount
                        )
                    }
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.bottom, Theme.Spacing.xl)
            }
            .background(Theme.Colors.background)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(AppViewModel())
}

