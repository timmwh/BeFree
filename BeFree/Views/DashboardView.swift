//
//  DashboardView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

// Figma: `2042:3869` (Dashboard / Main) + `2042:3874` (padded content container).
// Start tab only; tab bar clearance is provided solely by MainTabView's safeAreaInset.
// Layout rules enforced in this rebuild:
//   • NavigationStack is outermost — no ZStack between it and ScrollView.
//   • Background glow lives in .background(), never as a ZStack sibling.
//   • No manual bottom spacer — MainTabView.safeAreaInset is the single clearance mechanism.
//   • Streak card uses negative horizontal padding bleed (-16) at the call site.
struct DashboardView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: Theme.DashboardLayout.sectionSpacing) {
                    brandHeader
                    streakRow
                    nextStepSection
                    progressSection
                }
                .padding(.horizontal, Theme.DashboardLayout.horizontalInset)
                .padding(.top, Theme.DashboardLayout.topInset)
            }
            .scrollContentBackground(.hidden)
            .background(DashboardBackground())
        }
    }

    // MARK: - Brand header (2042:3875)

    private var brandHeader: some View {
        HStack(alignment: .center) {
            HStack(spacing: Theme.DashboardLayout.logoToWordmarkGap) {
                // Logo gradient tile
                ZStack {
                    Theme.Gradients.primaryButton
                    Image(systemName: "sparkles")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                .cornerRadius(Theme.CornerRadius.md)
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.4), radius: 5, x: 0, y: 0)
                .shadow(color: Theme.Colors.primaryBlue.opacity(0.2), radius: 10, x: 0, y: 0)

                Text("BeFree")
                    .font(Theme.Typography.dashboardBrand)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .tracking(Theme.DashboardLayout.beFreeTitleTracking)
            }

            Spacer(minLength: 0)

            streakPill
        }
    }

    private var streakPill: some View {
        HStack(spacing: Theme.DashboardLayout.streakPillIconToNumberGap) {
            Image(systemName: "flame.fill")
                .font(.system(size: 14))
                .foregroundColor(Theme.Colors.primaryBlue)

            Text("\(viewModel.userProgress.currentStreak)")
                .font(Theme.Typography.bodyMedium)
                .tracking(-0.31)
                .foregroundColor(Theme.Colors.textPrimary)
        }
        .padding(.horizontal, Theme.DashboardLayout.streakPillHorizontalPadding)
        .padding(.vertical, Theme.DashboardLayout.streakPillVerticalPadding)
        .frame(height: Theme.DashboardLayout.streakPillHeight)
        .background(Theme.Colors.cardBackgroundMuted)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Streak \(viewModel.userProgress.currentStreak) days")
    }

    // MARK: - Streak bar (2042:3891)
    // Edge-bleed: negative horizontal padding bleeds the card past the scroll-view content padding,
    // matching Figma node 2091:138 (left:-16, width:393.8). No GeometryReader.

    private var streakRow: some View {
        StreakBar(
            streakDays: viewModel.streakDays,
            currentDayIndex: viewModel.currentDayIndex
        )
        .padding(.horizontal, Theme.DashboardLayout.streakEdgeBleed)
    }

    // MARK: - Next Step (2042:3927)

    @ViewBuilder
    private var nextStepSection: some View {
        VStack(alignment: .leading, spacing: Theme.DashboardLayout.sectionHeaderSpacing) {
            SectionLabel(
                icon: "bolt.fill",
                title: "Next Step",
                color: Theme.Colors.secondaryBlue,
                iconColor: nil
            )

            if let next = viewModel.nextStep {
                NavigationLink(destination: StepDetailView(step: next)) {
                    NextStepCard(step: next)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                allCompletedCard
            }
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
        .padding(Theme.DashboardLayout.cardInnerPadding)
        .frame(minHeight: Theme.DashboardLayout.nextStepCardMinHeight)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
    }

    // MARK: - Progress (2042:3949)

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: Theme.DashboardLayout.sectionHeaderSpacing) {
            HStack(alignment: .center) {
                SectionLabel(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Progress",
                    color: Theme.Colors.textPrimary.opacity(0.9),
                    iconColor: Theme.Colors.textPrimary.opacity(0.9)
                )

                Spacer(minLength: 0)

                Button {
                    viewModel.selectedTab = .roadmap
                } label: {
                    HStack(spacing: 4) {
                        Text("Roadmap")
                            .font(Theme.Typography.caption)
                            .tracking(-0.15)
                            .foregroundColor(Theme.Colors.primaryBlue)
                        Image(systemName: "chevron.right")
                            .font(.system(size: Theme.DashboardLayout.roadmapRowChevronSize, weight: .semibold))
                            .foregroundColor(Theme.Colors.primaryBlue)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, Theme.DashboardLayout.progressHeaderHorizontalInset)

            progressCard
        }
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(viewModel.progressPercentage)%")
                .font(Theme.Typography.progressPercent)
                .tracking(Theme.DashboardLayout.progressPercentTracking)
                .foregroundColor(Theme.Colors.primaryBlue)
                .frame(height: Theme.DashboardLayout.progressPercentLineHeight, alignment: .topLeading)

            ProgressBar(
                progress: Double(viewModel.completedStepsCount) / max(1, Double(viewModel.totalStepsCount)),
                height: Theme.DashboardLayout.progressBarHeight,
                showSheen: true
            )
            .padding(.top, Theme.DashboardLayout.progressPercentToBarSpacing)

            Text("\(viewModel.completedStepsCount)/\(viewModel.totalStepsCount) completed")
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .tracking(-0.15)
                .padding(.top, Theme.DashboardLayout.progressBarToCaptionSpacing)
        }
        .padding(Theme.DashboardLayout.cardInnerPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: Theme.DashboardLayout.progressCardMinHeight, alignment: .topLeading)
        .background(Theme.Colors.cardBackgroundMuted)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }
}

// MARK: - Dashboard background (glow)
// Figma: #0a0a0f base + soft blue radial blur top-leading.
// Mounted via .background() on the ScrollView — never a ZStack sibling — so it never
// participates in layout width negotiation.

private struct DashboardBackground: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Theme.Colors.background
                .ignoresSafeArea()

            Circle()
                .fill(Theme.Colors.primaryBlue.opacity(0.06))
                .frame(width: 410, height: 410)
                .blur(radius: 68)
                .offset(x: -3, y: -13)
                .allowsHitTesting(false)
        }
    }
}

// MARK: - Section label (Figma 2042:3928 / 2042:3950)

private struct SectionLabel: View {
    let icon: String
    let title: String
    let color: Color
    var iconColor: Color?

    var body: some View {
        HStack(spacing: Theme.DashboardLayout.sectionLabelIconGap) {
            Image(systemName: icon)
                .font(.system(size: Theme.DashboardLayout.sectionLabelIconSize, weight: .semibold))
                .foregroundColor(iconColor ?? color)
            Text(title)
                .font(Theme.Typography.caption)
                .tracking(Theme.DashboardLayout.sectionLabelTracking)
                .foregroundColor(color)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(AppViewModel())
}
