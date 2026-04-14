//
//  SettingsView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 09.04.26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showResetConfirmation = false
    @State private var showModelPicker = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.xl) {

                    // Current model section
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        SectionHeader(icon: "map.fill", title: "Your Path")

                        if let model = viewModel.businessModel {
                            CurrentModelCard(model: model) {
                                showModelPicker = true
                            }
                        }
                    }

                    // Progress section
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        SectionHeader(icon: "chart.line.uptrend.xyaxis", title: "Progress")

                        ProgressStatsCard(
                            completed: viewModel.completedStepsCount,
                            total: viewModel.totalStepsCount,
                            streak: viewModel.userProgress.currentStreak,
                            totalMinutes: viewModel.userProgress.totalSessionSeconds / 60
                        )
                    }

                    // Danger zone
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        SectionHeader(icon: "exclamationmark.triangle", title: "Reset")

                        Button(action: { showResetConfirmation = true }) {
                            HStack(spacing: Theme.Spacing.md) {
                                IconContainer(icon: "arrow.counterclockwise", size: .medium, style: .dark)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Reset Progress")
                                        .font(Theme.Typography.bodyMedium)
                                        .foregroundColor(Theme.Colors.error)
                                    Text("Clear all completed steps and streak data")
                                        .font(Theme.Typography.caption)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(Theme.Colors.textSecondary)
                            }
                            .padding(Theme.Spacing.lg)
                            .background(Theme.Colors.cardBackground)
                            .cornerRadius(Theme.CornerRadius.md)
                            .overlay(
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                                    .stroke(Theme.Colors.errorBorder, lineWidth: 0.633)
                            )
                        }
                    }
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.vertical, Theme.Spacing.lg)
            }
            .background(Theme.Colors.background)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("Reset All Progress?", isPresented: $showResetConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                viewModel.resetProgress()
            }
        } message: {
            Text("This will permanently delete all your completed steps, streak data, and session time. This cannot be undone.")
        }
        .sheet(isPresented: $showModelPicker) {
            ModelSwitcherSheet()
                .environmentObject(viewModel)
        }
    }
}

// MARK: - Section Header

private struct SectionHeader: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(Theme.Colors.primaryBlue)
            Text(title)
                .font(Theme.Typography.bodyBold)
                .foregroundColor(Theme.Colors.textPrimary)
        }
    }
}

// MARK: - Current Model Card

private struct CurrentModelCard: View {
    let model: BusinessModel
    let onSwitch: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            HStack(spacing: Theme.Spacing.md) {
                IconContainer(icon: model.icon, size: .large, style: .blueGradient)

                VStack(alignment: .leading, spacing: 4) {
                    Text(model.shortName)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.primaryBlue)
                        .tracking(0.5)
                        .textCase(.uppercase)
                    Text(model.name)
                        .font(Theme.Typography.bodySemiBold)
                        .foregroundColor(Theme.Colors.textPrimary)
                }

                Spacer()

                BadgeChip("Active", variant: .statusSuccess)
            }

            Text(model.description)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .lineSpacing(3)

            Button(action: onSwitch) {
                HStack {
                    Text("Switch Model")
                        .font(Theme.Typography.bodyMedium)
                        .foregroundColor(Theme.Colors.textPrimary)
                    Spacer()
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                .padding(.vertical, Theme.Spacing.md)
                .padding(.horizontal, Theme.Spacing.lg)
                .background(Theme.Colors.background)
                .cornerRadius(Theme.CornerRadius.sm)
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
}

// MARK: - Progress Stats Card

private struct ProgressStatsCard: View {
    let completed: Int
    let total: Int
    let streak: Int
    let totalMinutes: Int

    var body: some View {
        HStack(spacing: 0) {
            StatItem(value: "\(completed)/\(total)", label: "Steps Done")

            Divider()
                .background(Theme.Colors.divider)
                .frame(height: 40)

            StatItem(value: "\(streak)", label: "Day Streak")

            Divider()
                .background(Theme.Colors.divider)
                .frame(height: 40)

            StatItem(value: "\(totalMinutes)", label: "Min Invested")
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.divider, lineWidth: 0.633)
        )
    }
}

private struct StatItem: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(Theme.Typography.bodySemiBold)
                .foregroundColor(Theme.Colors.textPrimary)
            Text(label)
                .font(Theme.Typography.small)
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Model Switcher Sheet

struct ModelSwitcherSheet: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Switch Model")
                        .font(Theme.Typography.bodySemiBold)
                        .foregroundColor(Theme.Colors.textPrimary)
                    Text("Foundation progress is tracked separately per model.")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Theme.Colors.textSecondary)
                }
            }
            .padding(Theme.Spacing.lg)
            .background(Theme.Colors.cardBackground)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Theme.Colors.divider)
                    .frame(height: 0.5)
            }

            ScrollView {
                VStack(spacing: Theme.Spacing.md) {
                    ForEach(viewModel.allBusinessModels) { model in
                        SwitcherModelCard(
                            model: model,
                            isSelected: model.shortName == viewModel.businessModel?.shortName,
                            onSelect: {
                                viewModel.selectModel(model)
                                dismiss()
                            }
                        )
                    }
                }
                .padding(Theme.Spacing.lg)
            }
        }
        .background(Theme.Colors.background)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

private struct SwitcherModelCard: View {
    let model: BusinessModel
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                HStack(spacing: Theme.Spacing.md) {
                    IconContainer(
                        icon: model.icon,
                        size: .large,
                        style: isSelected ? .blueGradient : .blue
                    )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(model.shortName)
                            .font(Theme.Typography.caption)
                            .foregroundColor(isSelected ? Theme.Colors.primaryBlue : Theme.Colors.textSecondary)
                            .tracking(0.5)
                            .textCase(.uppercase)
                        Text(model.name)
                            .font(Theme.Typography.bodySemiBold)
                            .foregroundColor(Theme.Colors.textPrimary)
                    }

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Theme.Colors.primaryBlue)
                    } else {
                        Circle()
                            .stroke(Theme.Colors.border, lineWidth: 1.5)
                            .frame(width: 24, height: 24)
                    }
                }

                Text(model.description)
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineSpacing(3)
                    .multilineTextAlignment(.leading)
            }
            .padding(Theme.Spacing.lg)
            .background(isSelected ? Theme.Colors.primaryBlueOpacity : Theme.Colors.cardBackground)
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                    .stroke(
                        isSelected ? Theme.Colors.primaryBlue.opacity(0.5) : Theme.Colors.divider,
                        lineWidth: isSelected ? 1 : 0.633
                    )
            )
        }
    }
}

// MARK: - Preview

#Preview {
    SettingsView()
        .environmentObject(AppViewModel())
}
