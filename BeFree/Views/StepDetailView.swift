//
//  StepDetailView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Step detail screen per Figma 2002-1129 (Watch) and 2002-1195 (Do).
/// Single header with circular back button, PhaseChip, and "Step X/Y"
/// counter, plus an H1 title below. Two content modes swapped via the
/// primary CTA (Continue → Complete). No Watch/Do phase badge per the
/// final Figma spec.
struct StepDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss

    let step: Step

    /// Two-phase flow inside the detail: Watch (video + notes) → Do
    /// (task + coach). Named `WatchDoPhase` to avoid shadowing the
    /// business `Phase` enum.
    enum WatchDoPhase {
        case watch
        case doing
    }

    @State private var phase: WatchDoPhase = .watch
    @State private var showSuccess = false
    @State private var showCoachSheet = false

    private var hasVideo: Bool { !step.videoId.isEmpty }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                header

                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.xxl) {
                        switch phase {
                        case .watch:
                            watchContent
                        case .doing:
                            doContent
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.xxl)
                    .padding(.top, Theme.Spacing.sm)
                    .padding(.bottom, 120) // leave room for the fixed CTA + gradient
                }
            }
            .background(Theme.Colors.background)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showCoachSheet) {
                CoachSheetView(step: step)
                    .environmentObject(viewModel)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            .onAppear(perform: setupInitialPhase)

            // Fixed bottom gradient-fade + CTA overlay.
            VStack(spacing: 0) {
                Spacer()
                bottomCTA
            }

            if showSuccess {
                successOverlay
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            HStack(spacing: 10) {
                Button(action: handleBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Theme.Colors.textPrimary)
                        .frame(width: 44, height: 44)
                        .background(Theme.Colors.cardBackground)
                        .cornerRadius(Theme.CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
                        )
                }
                .accessibilityLabel(backAccessibilityLabel)

                PhaseChip(phase: step.phase)

                Spacer()

                if let counter = stepCounter {
                    Text(counter)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
            }

            Text(step.title)
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(Theme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, Theme.Spacing.xxl)
        .padding(.top, Theme.Spacing.sm)
        .padding(.bottom, Theme.Spacing.md)
    }

    private var stepCounter: String? {
        guard let idx = viewModel.stepIndex(of: step) else { return nil }
        return "Step \(idx)/\(viewModel.totalStepsCount)"
    }

    private var backAccessibilityLabel: String {
        switch phase {
        case .watch: return "Back to dashboard"
        case .doing: return hasVideo ? "Back to video" : "Back to dashboard"
        }
    }

    // MARK: - Watch content

    @ViewBuilder
    private var watchContent: some View {
        videoCard

        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            SectionLabel(icon: "eye.fill", title: "While Watching")

            VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                if step.watchNotes.isEmpty {
                    Text("Focus on the parts of the video that connect directly to your task.")
                        .font(.system(size: 15))
                        .foregroundColor(Theme.Colors.textPrimary)
                        .lineSpacing(3)
                } else {
                    ForEach(Array(step.watchNotes.enumerated()), id: \.offset) { index, note in
                        NumberedBullet(index: index + 1, text: note)
                    }
                }
            }
            .padding(Theme.Spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.CornerRadius.lg)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                    .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
            )
        }
    }

    private var videoCard: some View {
        YouTubePlayerView(videoId: step.videoId)
            .frame(height: 194)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(Theme.CornerRadius.lg)
    }

    // MARK: - Do content

    @ViewBuilder
    private var doContent: some View {
        DoSection(
            icon: "checkmark.rectangle.stack",
            title: "Your Task"
        ) {
            Text(step.description)
                .font(.system(size: 15))
                .foregroundColor(Theme.Colors.textPrimary)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

        if !step.expectedOutput.isEmpty {
            DoSection(
                icon: "shippingbox",
                title: "Expected Output"
            ) {
                Text(step.expectedOutput)
                    .font(.system(size: 15))
                    .italic()
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }

        AICoachEntry(onTap: { showCoachSheet = true })
    }

    // MARK: - Bottom CTA (fixed + gradient fade)

    private var bottomCTA: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [
                    Theme.Colors.background.opacity(0),
                    Theme.Colors.background.opacity(0.9),
                    Theme.Colors.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 140)
            .allowsHitTesting(false)

            Group {
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
            .padding(.horizontal, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.md)
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
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 30, x: 0, y: 0)
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

// MARK: - Section label (uppercase micro-header)

private struct SectionLabel: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(Theme.Colors.primaryBlue)

            Text(title.uppercased())
                .font(Theme.Typography.small)
                .foregroundColor(Theme.Colors.primaryBlue)
                .tracking(1.2)
        }
    }
}

// MARK: - Numbered bullet (Watch notes)

private struct NumberedBullet: View {
    let index: Int
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: Theme.Spacing.md) {
            Text("\(index)")
                .font(.system(size: 13))
                .foregroundColor(Theme.Colors.primaryBlue)
                .frame(width: 28, height: 28)
                .background(Theme.Colors.primaryBlue.opacity(0.2))
                .cornerRadius(10)

            Text(text)
                .font(.system(size: 15))
                .foregroundColor(Theme.Colors.textPrimary)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Do phase section (titled card)

private struct DoSection<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            SectionLabel(icon: icon, title: title)

            content()
                .padding(Theme.Spacing.xl)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Theme.Colors.cardBackground)
                .cornerRadius(Theme.CornerRadius.lg)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                        .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
                )
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        StepDetailView(step: DataService.shared.getAuthoredSteps(for: "AAA")[0])
            .environmentObject(AppViewModel())
    }
}

