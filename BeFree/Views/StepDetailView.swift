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

    // MARK: - Phase

    /// Two-phase flow: Watch (video + notes) → Do (task + coach).
    /// The step is only marked completed from the Do phase.
    enum Phase {
        case watch
        case doing
    }

    @State private var phase: Phase = .watch
    @State private var showSuccess = false
    @State private var showCoachSheet = false

    private var hasVideo: Bool { !step.videoId.isEmpty }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.xl) {
                        header

                        switch phase {
                        case .watch:
                            watchContent
                        case .doing:
                            doContent
                        }
                    }
                    .padding(Theme.Spacing.lg)
                    .padding(.bottom, Theme.Spacing.md)
                }

                primaryCTA
                    .padding(.horizontal, Theme.Spacing.lg)
                    .padding(.top, Theme.Spacing.sm)
                    .padding(.bottom, Theme.Spacing.md)
                    .background(
                        Theme.Colors.background
                            .shadow(color: Theme.Colors.background.opacity(0.6), radius: 12, x: 0, y: -4)
                            .ignoresSafeArea(edges: .bottom)
                    )
            }
            .background(Theme.Colors.background)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .sheet(isPresented: $showCoachSheet) {
                CoachSheetView(step: step)
                    .environmentObject(viewModel)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            .onAppear(perform: setupInitialPhase)

            if showSuccess {
                successOverlay
            }
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: handleBack) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text(backTitle)
                        .font(Theme.Typography.body)
                }
                .foregroundColor(Theme.Colors.textPrimary)
            }
            .accessibilityLabel(backAccessibilityLabel)
        }
    }

    private var backTitle: String {
        switch phase {
        case .watch:
            return "Back"
        case .doing:
            return hasVideo ? "Watch" : "Back"
        }
    }

    private var backAccessibilityLabel: String {
        switch phase {
        case .watch:
            return "Back to dashboard"
        case .doing:
            return hasVideo ? "Back to video" : "Back to dashboard"
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack(spacing: Theme.Spacing.sm) {
                PhaseChip(phase: step.phase.toBusinessPhase)
                phaseBadge
            }

            Text(step.title)
                .font(Theme.Typography.title1)
                .foregroundColor(Theme.Colors.textPrimary)
        }
    }

    private var phaseBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: phase == .watch ? "play.circle.fill" : "checklist")
                .font(.system(size: 11, weight: .semibold))
            Text(phase == .watch ? "Watch" : "Do")
                .font(Theme.Typography.caption)
                .tracking(0.5)
                .textCase(.uppercase)
        }
        .foregroundColor(Theme.Colors.primaryBlue)
        .padding(.horizontal, Theme.Spacing.sm)
        .padding(.vertical, 4)
        .background(Theme.Colors.primaryBlueOpacity)
        .cornerRadius(Theme.CornerRadius.sm)
    }

    // MARK: - Watch phase content

    @ViewBuilder
    private var watchContent: some View {
        YouTubePlayerView(videoId: step.videoId)
            .cornerRadius(Theme.CornerRadius.sm)

        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            SectionLabel(icon: "eye.fill", title: "While watching")

            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                if step.watchNotes.isEmpty {
                    Text("Focus on the parts of the video that connect directly to your task.")
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .lineSpacing(3)
                } else {
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
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.divider, lineWidth: 0.633)
        )
    }

    // MARK: - Do phase content

    @ViewBuilder
    private var doContent: some View {
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
    }

    // MARK: - Primary CTA (fixed)

    @ViewBuilder
    private var primaryCTA: some View {
        switch phase {
        case .watch:
            PrimaryButton("Continue", icon: "arrow.right") {
                goToDoPhase()
            }
        case .doing:
            PrimaryButton("Complete", icon: "checkmark") {
                markDone()
            }
        }
    }

    // MARK: - Success overlay

    private var successOverlay: some View {
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

    // MARK: - Actions

    private func setupInitialPhase() {
        // Without a video the Watch phase has nothing to show — skip it.
        // Otherwise resume at Do if the user already pressed Continue for
        // this (still unfinished) step in an earlier session.
        if !hasVideo || viewModel.hasEnteredDoPhase(step) {
            phase = .doing
        } else {
            phase = .watch
        }
    }

    private func goToDoPhase() {
        viewModel.markDoPhaseEntered(step)
        withAnimation(.easeInOut(duration: 0.2)) {
            phase = .doing
        }
    }

    private func handleBack() {
        switch phase {
        case .watch:
            dismiss()
        case .doing:
            if hasVideo {
                withAnimation(.easeInOut(duration: 0.2)) {
                    phase = .watch
                }
            } else {
                dismiss()
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
