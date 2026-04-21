//
//  ModelSwitcherSheet.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//
//  Extracted from the old SettingsView during the Phase 6 Profile rebuild.
//  Presented from ProfileView's "Switch Model" button on the Your Path card.
//

import SwiftUI

/// Modal model switcher. Picking a row updates the AppViewModel and dismisses
/// the sheet immediately. Foundation progress is per-model so users see a
/// short note about that.
struct ModelSwitcherSheet: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

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

    private var header: some View {
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
        .buttonStyle(PlainButtonStyle())
    }
}
