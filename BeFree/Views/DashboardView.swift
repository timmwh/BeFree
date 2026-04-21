//
//  DashboardView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Start tab per Figma 2002-923: BeFree brand header + streak pill,
/// StreakBar, Next-Step section, Progress section with a "Roadmap →"
/// text link that switches the tab programmatically.
struct DashboardView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.xxl + 8) {
                    brandHeader

                    StreakBar(
                        streakDays: viewModel.streakDays,
                        currentDayIndex: viewModel.currentDayIndex
                    )

                    nextStepSection

                    progressSection
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.top, Theme.Spacing.xxl)
                .padding(.bottom, Theme.Spacing.xxxl)
            }
            .background(Theme.Colors.background)
        }
    }

    // MARK: - Brand header (logo + streak pill)

    private var brandHeader: some View {
        HStack {
            HStack(spacing: Theme.Spacing.md) {
                ZStack {
                    Theme.Gradients.primaryButton
                    Image(systemName: "sparkles")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                .cornerRadius(Theme.CornerRadius.md)
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 10, x: 0, y: 0)
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.2), radius: 20, x: 0, y: 0)

                Text("BeFree")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(Theme.Colors.textPrimary)
            }

            Spacer()

            streakPill
        }
    }

    private var streakPill: some View {
        HStack(spacing: 8) {
            Image(systemName: "flame.fill")
                .font(.system(size: 14))
                .foregroundColor(Theme.Colors.primaryBlue)

            Text("\(viewModel.userProgress.currentStreak)")
                .font(Theme.Typography.bodyMedium)
                .foregroundColor(Theme.Colors.textPrimary)
        }
        .padding(.horizontal, Theme.Spacing.lg)
        .padding(.vertical, 9)
        .background(Theme.Colors.cardBackgroundMuted)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Streak \(viewModel.userProgress.currentStreak) days")
    }

    // MARK: - Next Step

    @ViewBuilder
    private var nextStepSection: some View {
        if let next = viewModel.nextStep {
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                SectionLabel(icon: "bolt.fill", title: "Next Step", color: Theme.Colors.secondaryBlue)

                NavigationLink(destination: StepDetailView(step: next)) {
                    NextStepCard(step: next)
                }
                .buttonStyle(PlainButtonStyle())
            }
        } else {
            allCompletedCard
        }
    }

    private var allCompletedCard: some View {
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

    // MARK: - Progress

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                SectionLabel(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Progress",
                    color: Theme.Colors.textPrimary.opacity(0.9),
                    iconColor: Theme.Colors.textPrimary.opacity(0.9)
                )

                Spacer()

                Button {
                    viewModel.selectedTab = .roadmap
                } label: {
                    HStack(spacing: 4) {
                        Text("Roadmap")
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.primaryBlue)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(Theme.Colors.primaryBlue)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, Theme.Spacing.xs)

            progressCard
        }
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            Text("\(viewModel.progressPercentage)%")
                .font(.system(size: 32, weight: .regular))
                .foregroundColor(Theme.Colors.primaryBlue)

            ProgressBar(
                progress: Double(viewModel.completedStepsCount) / max(1, Double(viewModel.totalStepsCount)),
                height: 12
            )

            Text("\(viewModel.completedStepsCount)/\(viewModel.totalStepsCount) completed")
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .padding(Theme.Spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.cardBackgroundMuted)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }
}

// MARK: - Helpers

private struct SectionLabel: View {
    let icon: String
    let title: String
    let color: Color
    var iconColor: Color?

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(iconColor ?? color)
            Text(title)
                .font(Theme.Typography.caption)
                .foregroundColor(color)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(AppViewModel())
}
