//
//  StepDetailView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct StepDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    let step: Step
    
    @State private var isTimerRunning = false
    @State private var elapsedTime = 0
    @State private var timerTask: Task<Void, Never>?
    @State private var checkedSubtasks: Set<Int> = []
    @State private var showCompletionAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    PhaseChip(phase: step.phase.toBusinessPhase)
                    
                    Text(step.title)
                        .font(Theme.Typography.title1)
                        .foregroundColor(Theme.Colors.textPrimary)
                    
                    if isTimerRunning {
                        HStack(spacing: Theme.Spacing.xs) {
                            Image(systemName: "timer")
                                .font(.system(size: 14))
                            Text(formatTime(elapsedTime))
                                .font(Theme.Typography.callout)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(Theme.Colors.primaryBlue)
                    }
                }
                
                // Description Section
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    Text("What You'll Do Today")
                        .font(Theme.Typography.title3)
                        .foregroundColor(Theme.Colors.textPrimary)
                    
                    Text(step.description)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .lineSpacing(4)
                }
                
                // Subtasks Section
                if !step.subtasks.isEmpty {
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        Text("Tasks")
                            .font(Theme.Typography.title3)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        VStack(spacing: Theme.Spacing.sm) {
                            ForEach(Array(step.subtasks.enumerated()), id: \.offset) { index, subtask in
                                SubtaskRow(
                                    title: subtask,
                                    isChecked: checkedSubtasks.contains(index),
                                    onToggle: {
                                        if checkedSubtasks.contains(index) {
                                            checkedSubtasks.remove(index)
                                        } else {
                                            checkedSubtasks.insert(index)
                                        }
                                    }
                                )
                            }
                        }
                    }
                }
                
                // Resources Section
                if !step.resources.isEmpty {
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        Text("Resources")
                            .font(Theme.Typography.title3)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        VStack(spacing: Theme.Spacing.sm) {
                            ForEach(step.resources) { resource in
                                ResourceCard(resource: resource)
                            }
                        }
                    }
                }
                
                // Action Buttons
                VStack(spacing: Theme.Spacing.md) {
                    if !isTimerRunning {
                        PrimaryButton("Start Timer", icon: "play.fill") {
                            startTimer()
                        }
                    }
                    
                    if isTimerRunning {
                        PrimaryButton("Complete Step", icon: "checkmark") {
                            showCompletionAlert = true
                        }
                    }
                }
                .padding(.top, Theme.Spacing.lg)
            }
            .padding(Theme.Spacing.lg)
        }
        .background(Theme.Colors.background)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Complete Step?", isPresented: $showCompletionAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Complete") {
                completeStep()
            }
        } message: {
            Text("Mark this step as completed? You can always review the resources later.")
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // MARK: - Timer Functions
    
    private func startTimer() {
        isTimerRunning = true
        timerTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                elapsedTime += 1
            }
        }
    }
    
    private func stopTimer() {
        timerTask?.cancel()
        isTimerRunning = false
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    private func completeStep() {
        stopTimer()
        viewModel.completeStep(step)
        dismiss()
    }
}

// MARK: - Subtask Row Component

struct SubtaskRow: View {
    let title: String
    let isChecked: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: Theme.Spacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isChecked ? Theme.Colors.primaryBlue : Theme.Colors.cardBackground)
                        .frame(width: 24, height: 24)
                    
                    if isChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Theme.Colors.divider, lineWidth: 2)
                            .frame(width: 24, height: 24)
                    }
                }
                
                Text(title)
                    .font(Theme.Typography.callout)
                    .foregroundColor(isChecked ? Theme.Colors.textSecondary : Theme.Colors.textPrimary)
                    .strikethrough(isChecked)
                
                Spacer()
            }
            .padding(Theme.Spacing.md)
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.CornerRadius.md)
        }
    }
}

#Preview {
    NavigationStack {
        StepDetailView(step: DataService.shared.getFoundationSteps()[0])
            .environmentObject(AppViewModel())
    }
}

