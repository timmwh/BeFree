//
//  RoadmapView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

/// Roadmap tab per Figma 2002-1266.
///
/// - Header with a back button (returns to the Start tab) + 2-line title.
/// - Overall progress card.
/// - 5 phase cards (Foundation / Setup / Position / Launch / Scale) with a
///   left phase-color accent bar. Foundation–Launch are tap-to-expand and
///   reveal a list of `StepCard`s underneath; Scale shows an
///   "Ongoing after Launch" pill instead of an n/m counter and is not
///   expandable in the MVP.
struct RoadmapView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var expanded: Set<Phase> = [.foundation]

    private let activePhases: [Phase] = [.foundation, .setup, .position, .launch]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.xxl) {
                    header
                    overallProgressCard
                    phaseStack
                }
                .padding(.horizontal, Theme.Spacing.xxl)
                .padding(.top, Theme.Spacing.sm)
                .padding(.bottom, Theme.Spacing.xxxl)
            }
            .background(Theme.Colors.background)
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: Theme.Spacing.md) {
            Button {
                viewModel.selectedTab = .start
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Theme.Colors.textPrimary)
                    .frame(width: 44, height: 44)
                    .background(Theme.Colors.cardBackground)
                    .cornerRadius(Theme.CornerRadius.lg)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                            .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
                    )
            }
            .accessibilityLabel("Back to Start")

            VStack(alignment: .leading, spacing: 4) {
                Text("Your Roadmap")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Theme.Colors.textPrimary)

                Text("Follow these steps to build your business")
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }

            Spacer()
        }
    }

    // MARK: - Overall progress card

    private var overallProgressCard: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack(alignment: .top) {
                Text("Overall Progress")
                    .font(.system(size: 18))
                    .foregroundColor(Theme.Colors.textPrimary)

                Spacer()

                Text("\(viewModel.progressPercentage)%")
                    .font(.system(size: 28))
                    .foregroundColor(Theme.Colors.primaryBlue)
            }

            ProgressBar(
                progress: Double(viewModel.completedStepsCount) / max(1, Double(viewModel.totalStepsCount)),
                height: 6
            )

            Text("\(viewModel.completedStepsCount)/\(viewModel.totalStepsCount) completed")
                .font(.system(size: 12))
                .foregroundColor(Theme.Colors.textSecondary)
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

    // MARK: - Phase stack

    private var phaseStack: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            ForEach(activePhases, id: \.self) { phase in
                PhaseSectionCard(
                    phase: phase,
                    subtitle: subtitle(for: phase),
                    steps: viewModel.steps(for: phase),
                    isExpanded: expanded.contains(phase),
                    onToggle: { toggle(phase) }
                )
            }

            ScalePhaseCard(subtitle: subtitle(for: .scale))
        }
    }

    private func toggle(_ phase: Phase) {
        withAnimation(.easeInOut(duration: 0.2)) {
            if expanded.contains(phase) { expanded.remove(phase) }
            else { expanded.insert(phase) }
        }
    }

    private func subtitle(for phase: Phase) -> String {
        switch phase {
        case .foundation: return "Build the groundwork for your business"
        case .setup:      return "Prepare your tools and accounts"
        case .position:   return "Define your niche and offer"
        case .launch:     return "Take your first real-world actions"
        case .scale:      return "Grow and optimize continuously"
        }
    }
}

// MARK: - Active phase card (Foundation / Setup / Position / Launch)

private struct PhaseSectionCard: View {
    let phase: Phase
    let subtitle: String
    let steps: [Step]
    let isExpanded: Bool
    let onToggle: () -> Void

    private var completedCount: Int {
        steps.filter { $0.isCompleted }.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: onToggle) {
                ZStack(alignment: .leading) {
                    accentBar

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Image(systemName: phaseIcon)
                                    .font(.system(size: 18))
                                    .foregroundColor(phase.color)

                                Text(phase.rawValue)
                                    .font(.system(size: 18))
                                    .foregroundColor(Theme.Colors.textPrimary)
                            }

                            Text(subtitle)
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 220, alignment: .leading)
                        }

                        Spacer()

                        countPill
                        chevronSquare
                    }
                    .padding(.horizontal, Theme.Spacing.xl)
                    .padding(.vertical, Theme.Spacing.xl)
                    .padding(.leading, 0) // accent bar overlays leading edge
                }
                .background(Theme.Colors.cardBackground)
                .cornerRadius(Theme.CornerRadius.lg)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                        .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
                )
                .clipShape(RoundedRectangle(cornerRadius: Theme.CornerRadius.lg))
            }
            .buttonStyle(PlainButtonStyle())

            if isExpanded && !steps.isEmpty {
                VStack(spacing: 8) {
                    ForEach(steps) { step in
                        NavigationLink(destination: StepDetailView(step: step)) {
                            StepCard(step: step) { }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private var accentBar: some View {
        Rectangle()
            .fill(phase.color)
            .frame(width: 4)
            .frame(maxHeight: .infinity)
    }

    private var countPill: some View {
        Text("\(completedCount)/\(steps.count)")
            .font(.system(size: 13))
            .foregroundColor(phase.color)
            .padding(.horizontal, 10)
            .frame(height: 23)
            .background(phase.bg)
            .cornerRadius(Theme.CornerRadius.pill)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                    .stroke(phase.border, lineWidth: 0.633)
            )
    }

    private var chevronSquare: some View {
        Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Theme.Colors.textSecondary)
            .frame(width: 32, height: 32)
            .background(Theme.Colors.cardBackgroundMuted)
            .cornerRadius(Theme.CornerRadius.sm)
    }

    private var phaseIcon: String {
        switch phase {
        case .foundation: return "cube.fill"
        case .setup:      return "wrench.and.screwdriver.fill"
        case .position:   return "scope"
        case .launch:     return "paperplane.fill"
        case .scale:      return "chart.line.uptrend.xyaxis"
        }
    }
}

// MARK: - Scale phase card (no expansion, "Ongoing after Launch" pill)

private struct ScalePhaseCard: View {
    let subtitle: String

    private let phase: Phase = .scale

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(phase.color)
                .frame(width: 4)
                .frame(maxHeight: .infinity)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 18))
                            .foregroundColor(phase.color)

                        Text(phase.rawValue)
                            .font(.system(size: 18))
                            .foregroundColor(Theme.Colors.textPrimary)
                    }

                    Text(subtitle)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .frame(maxWidth: 220, alignment: .leading)
                }

                Spacer()

                Text("Ongoing after Launch")
                    .font(.system(size: 11))
                    .foregroundColor(phase.color)
                    .padding(.horizontal, 10)
                    .frame(height: 23)
                    .background(phase.bg)
                    .cornerRadius(Theme.CornerRadius.pill)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                            .stroke(phase.border, lineWidth: 0.633)
                    )
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.vertical, Theme.Spacing.xl)
        }
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .clipShape(RoundedRectangle(cornerRadius: Theme.CornerRadius.lg))
    }
}

#Preview {
    RoadmapView()
        .environmentObject(AppViewModel())
}
