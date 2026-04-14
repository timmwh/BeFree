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

    @State private var showSuccess = false
    @State private var showCoachSheet = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.xl) {
                    // Header
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        PhaseChip(phase: step.phase.toBusinessPhase)

                        Text(step.title)
                            .font(Theme.Typography.title1)
                            .foregroundColor(Theme.Colors.textPrimary)
                    }

                    // YouTube Video
                    YouTubePlayerView(videoId: step.videoId)
                        .aspectRatio(16/9, contentMode: .fit)
                        .cornerRadius(Theme.CornerRadius.sm)

                    // Watch Notes
                    if !step.watchNotes.isEmpty {
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionLabel(icon: "eye.fill", title: "While watching")

                            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                                ForEach(step.watchNotes, id: \.self) { note in
                                    HStack(alignment: .top, spacing: Theme.Spacing.sm) {
                                        Circle()
                                            .fill(Theme.Colors.primaryBlue)
                                            .frame(width: 6, height: 6)
                                            .padding(.top, 7)
                                        Text(note)
                                            .font(Theme.Typography.body)
                                            .foregroundColor(Theme.Colors.textSecondary)
                                            .lineSpacing(3)
                                    }
                                }
                            }
                        }
                        .padding(Theme.Spacing.lg)
                        .background(Theme.Colors.cardBackground)
                        .cornerRadius(Theme.CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                                .stroke(Theme.Colors.divider, lineWidth: 0.633)
                        )
                    }

                    // Your Task
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        SectionLabel(icon: "checkmark.circle.fill", title: "Your Task")

                        Text(step.description)
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .lineSpacing(4)
                    }
                    .padding(Theme.Spacing.lg)
                    .background(Theme.Colors.cardBackground)
                    .cornerRadius(Theme.CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                            .stroke(Theme.Colors.divider, lineWidth: 0.633)
                    )

                    // Expected Output
                    if !step.expectedOutput.isEmpty {
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionLabel(icon: "doc.text.fill", title: "Expected Output")

                            Text(step.expectedOutput)
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .lineSpacing(3)
                                .italic()
                        }
                        .padding(Theme.Spacing.lg)
                        .background(Theme.Colors.cardBackground)
                        .cornerRadius(Theme.CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                                .stroke(Theme.Colors.divider, lineWidth: 0.633)
                        )
                    }

                    // AI Coach
                    Button(action: { showCoachSheet = true }) {
                        HStack(spacing: Theme.Spacing.md) {
                            ZStack {
                                Theme.Gradients.primaryButton
                                Image(systemName: "sparkles")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .cornerRadius(Theme.CornerRadius.sm)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Ask your coach")
                                    .font(Theme.Typography.bodyMedium)
                                    .foregroundColor(Theme.Colors.textPrimary)
                                Text("Stuck or have a question? Get instant guidance.")
                                    .font(Theme.Typography.caption)
                                    .foregroundColor(Theme.Colors.textSecondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Theme.Colors.textSecondary)
                        }
                        .padding(Theme.Spacing.lg)
                        .background(Theme.Colors.cardBackground)
                        .cornerRadius(Theme.CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                                .stroke(Theme.Colors.primaryBlue.opacity(0.3), lineWidth: 0.633)
                        )
                    }

                    // Mark as Done
                    PrimaryButton("Mark as Done", icon: "checkmark") {
                        markDone()
                    }
                    .padding(.top, Theme.Spacing.sm)
                }
                .padding(Theme.Spacing.lg)
            }
            .background(Theme.Colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showCoachSheet) {
                CoachSheetView(step: step)
                    .environmentObject(viewModel)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }

            // Success overlay
            if showSuccess {
                ZStack {
                    Theme.Colors.background.opacity(0.85)
                        .ignoresSafeArea()

                    VStack(spacing: Theme.Spacing.lg) {
                        ZStack {
                            Theme.Colors.successBg
                            Image(systemName: "checkmark")
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(Theme.Colors.success)
                        }
                        .frame(width: 96, height: 96)
                        .cornerRadius(Theme.CornerRadius.xl)
                        .shadow(color: Theme.Colors.success.opacity(0.4), radius: 30, x: 0, y: 0)
                        .scaleEffect(showSuccess ? 1 : 0.5)
                        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showSuccess)

                        Text("Step Complete")
                            .font(Theme.Typography.bodySemiBold)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .opacity(showSuccess ? 1 : 0)
                            .animation(.easeIn(duration: 0.2).delay(0.15), value: showSuccess)
                    }
                }
                .transition(.opacity)
            }
        }
    }

    private func markDone() {
        viewModel.completeStep(step, sessionSeconds: 0)
        withAnimation(.easeIn(duration: 0.2)) {
            showSuccess = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            dismiss()
        }
    }
}

// MARK: - Section Label

private struct SectionLabel: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: Theme.Spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(Theme.Colors.primaryBlue)
            Text(title)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.primaryBlue)
                .tracking(0.5)
                .textCase(.uppercase)
        }
    }
}

#Preview {
    NavigationStack {
        StepDetailView(step: DataService.shared.getFoundationSteps(for: "AAA")[0])
            .environmentObject(AppViewModel())
    }
}
