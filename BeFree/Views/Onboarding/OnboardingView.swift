//
//  OnboardingView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 09.04.26.
//

import SwiftUI

// MARK: - Onboarding Coordinator

struct OnboardingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var currentPage: OnboardingPage = .welcome
    @State private var selectedExperience: ExperienceLevel? = nil
    @State private var selectedGoal: BusinessGoal? = nil

    enum OnboardingPage {
        case welcome
        case questionnaire
        case match
        case modelPicker
        case confirmation
    }

    var recommendedModel: BusinessModel {
        let models = viewModel.allBusinessModels
        switch (selectedExperience, selectedGoal) {
        case (.experienced, _):
            return models.first(where: { $0.shortName == "AAA" }) ?? models[0]
        case (_, .replaceJob):
            return models.first(where: { $0.shortName == "Growth OS" }) ?? models[0]
        case (.tried, .sideIncome):
            return models.first(where: { $0.shortName == "Brandscaling" }) ?? models[0]
        default:
            return models.first(where: { $0.shortName == "SMMA" }) ?? models[0]
        }
    }

    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            switch currentPage {
            case .welcome:
                WelcomePageView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        currentPage = .questionnaire
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))

            case .questionnaire:
                QuestionnairePageView(
                    selectedExperience: $selectedExperience,
                    selectedGoal: $selectedGoal,
                    onContinue: {
                        viewModel.selectModel(recommendedModel)
                        withAnimation(.easeInOut(duration: 0.4)) {
                            currentPage = .match
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))

            case .match:
                MatchPageView(
                    model: recommendedModel,
                    onAccept: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            currentPage = .confirmation
                        }
                    },
                    onSeeAll: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            currentPage = .modelPicker
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))

            case .modelPicker:
                ModelPickerPageView(
                    models: viewModel.allBusinessModels,
                    selectedModel: viewModel.businessModel ?? recommendedModel,
                    onSelect: { model in
                        viewModel.selectModel(model)
                    },
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            currentPage = .confirmation
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))

            case .confirmation:
                ConfirmationPageView(
                    model: viewModel.businessModel ?? recommendedModel,
                    onBegin: {
                        viewModel.completeOnboarding()
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))
            }
        }
    }
}

// MARK: - Questionnaire Data

enum ExperienceLevel: String, CaseIterable {
    case beginner = "Complete beginner"
    case tried = "Tried a few things"
    case experienced = "I have experience"

    var icon: String {
        switch self {
        case .beginner: return "1.circle"
        case .tried: return "2.circle"
        case .experienced: return "3.circle"
        }
    }

    var subtitle: String {
        switch self {
        case .beginner: return "Starting completely from zero"
        case .tried: return "Explored but haven't succeeded yet"
        case .experienced: return "Ready to scale what I know"
        }
    }
}

enum BusinessGoal: String, CaseIterable {
    case sideIncome = "Earn extra income"
    case fullBusiness = "Build a full-time business"
    case replaceJob = "Replace my current job"

    var icon: String {
        switch self {
        case .sideIncome: return "dollarsign.circle"
        case .fullBusiness: return "building.2"
        case .replaceJob: return "arrow.up.forward.circle"
        }
    }

    var subtitle: String {
        switch self {
        case .sideIncome: return "On the side of what I already do"
        case .fullBusiness: return "Make this my primary focus"
        case .replaceJob: return "Go all-in and quit my job"
        }
    }
}

// MARK: - Welcome Page

private struct WelcomePageView: View {
    let onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Logo
            ZStack {
                Theme.Gradients.primaryButton
                Image(systemName: "sparkles")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(width: 88, height: 88)
            .cornerRadius(Theme.CornerRadius.xl)
            .primaryGlow()

            Spacer().frame(height: Theme.Spacing.xl)

            // App name
            Text("BeFree")
                .font(.custom("Inter", size: 48).weight(.semibold))
                .foregroundColor(Theme.Colors.textPrimary)
                .tracking(-1)

            Spacer().frame(height: Theme.Spacing.md)

            Text("Build your online business.")
                .font(Theme.Typography.heading2)
                .foregroundColor(Theme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Spacer().frame(height: Theme.Spacing.sm)

            Text("One clear step. One guided session.\nOne daily win at a time.")
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer()

            // Features list
            VStack(spacing: Theme.Spacing.sm) {
                WelcomeFeatureRow(icon: "map.fill", text: "A proven step-by-step roadmap")
                WelcomeFeatureRow(icon: "timer", text: "Guided daily sessions with a timer")
                WelcomeFeatureRow(icon: "flame.fill", text: "Streak tracking to keep you going")
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xxxl)

            // CTA
            GradientButton("Get Started", icon: "arrow.right") {
                onGetStarted()
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xl)
        }
        .padding(.horizontal, Theme.Spacing.lg)
    }
}

private struct WelcomeFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            IconContainer(icon: icon, size: .medium, style: .blue)
            Text(text)
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textPrimaryOpacity)
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 20))
                .foregroundColor(Theme.Colors.primaryBlue)
        }
        .padding(.horizontal, Theme.Spacing.xl)
        .padding(.vertical, Theme.Spacing.lg)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Theme.Colors.divider, lineWidth: 0.633)
        )
    }
}

// MARK: - Questionnaire Page

private struct QuestionnairePageView: View {
    @Binding var selectedExperience: ExperienceLevel?
    @Binding var selectedGoal: BusinessGoal?
    let onContinue: () -> Void

    var canContinue: Bool {
        selectedExperience != nil && selectedGoal != nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                BadgeChip("Step 1 of 2", variant: .statusPrimary)
                    .padding(.top, Theme.Spacing.xxxl)

                Text("A few quick\nquestions")
                    .font(Theme.Typography.heading1)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .lineSpacing(2)

                Text("We'll use these to personalize your path.")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xxxl)

            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.xl) {
                    // Q1
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        Text("What's your starting point?")
                            .font(Theme.Typography.bodySemiBold)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .padding(.horizontal, Theme.Spacing.lg)

                        VStack(spacing: Theme.Spacing.sm) {
                            ForEach(ExperienceLevel.allCases, id: \.self) { level in
                                OnboardingOptionCard(
                                    icon: level.icon,
                                    title: level.rawValue,
                                    subtitle: level.subtitle,
                                    isSelected: selectedExperience == level
                                ) {
                                    withAnimation(.easeInOut(duration: 0.15)) {
                                        selectedExperience = level
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                    }

                    // Q2
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        Text("What's your primary goal?")
                            .font(Theme.Typography.bodySemiBold)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .padding(.horizontal, Theme.Spacing.lg)

                        VStack(spacing: Theme.Spacing.sm) {
                            ForEach(BusinessGoal.allCases, id: \.self) { goal in
                                OnboardingOptionCard(
                                    icon: goal.icon,
                                    title: goal.rawValue,
                                    subtitle: goal.subtitle,
                                    isSelected: selectedGoal == goal
                                ) {
                                    withAnimation(.easeInOut(duration: 0.15)) {
                                        selectedGoal = goal
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                    }

                    Spacer().frame(height: Theme.Spacing.xl)
                }
            }

            // Continue button
            GradientButton("Continue", icon: "arrow.right", isEnabled: canContinue) {
                onContinue()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xl)
        }
    }
}

// MARK: - Option Card

private struct OnboardingOptionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Theme.Spacing.md) {
                IconContainer(
                    icon: icon,
                    size: .medium,
                    style: isSelected ? .blueGradient : .blue
                )

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(Theme.Typography.bodyMedium)
                        .foregroundColor(Theme.Colors.textPrimary)
                    Text(subtitle)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Theme.Colors.primaryBlue)
                } else {
                    Circle()
                        .stroke(Theme.Colors.border, lineWidth: 1.5)
                        .frame(width: 22, height: 22)
                }
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

// MARK: - Match Page

private struct MatchPageView: View {
    let model: BusinessModel
    let onAccept: () -> Void
    let onSeeAll: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    BadgeChip("Step 2 of 2", variant: .statusPrimary)
                        .padding(.top, Theme.Spacing.xxxl)

                    Text("Your perfect\nmatch")
                        .font(Theme.Typography.heading1)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .lineSpacing(2)

                    Text("Based on your answers, we recommend:")
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                .padding(.horizontal, Theme.Spacing.lg)

                Spacer().frame(height: Theme.Spacing.xxl)

                // Model card
                VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                    // Model header
                    HStack(spacing: Theme.Spacing.md) {
                        IconContainer(icon: model.icon, size: .large, style: .blueGradient)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(model.shortName)
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.primaryBlue)
                                .tracking(1)
                                .textCase(.uppercase)

                            Text(model.name)
                                .font(Theme.Typography.bodySemiBold)
                                .foregroundColor(Theme.Colors.textPrimary)
                        }
                    }

                    Text(model.description)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .lineSpacing(4)

                    // Benefits
                    VStack(spacing: Theme.Spacing.sm) {
                        ForEach(model.benefits, id: \.self) { benefit in
                            BenefitCard(icon: benefitIcon(for: benefit), title: benefit)
                        }
                    }
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.cardBackground)
                .cornerRadius(Theme.CornerRadius.xl)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                        .stroke(Theme.Colors.divider, lineWidth: 0.633)
                )
                .padding(.horizontal, Theme.Spacing.lg)

                Spacer().frame(height: Theme.Spacing.xxxl)

                // CTAs
                VStack(spacing: Theme.Spacing.md) {
                    GradientButton("Start with \(model.shortName)") {
                        onAccept()
                    }

                    Button("See all models") {
                        onSeeAll()
                    }
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.bottom, Theme.Spacing.xl)
            }
        }
    }

    private func benefitIcon(for benefit: String) -> String {
        let lower = benefit.lowercased()
        if lower.contains("cost") || lower.contains("€") || lower.contains("$") { return "dollarsign.circle.fill" }
        if lower.contains("demand") || lower.contains("client") { return "person.2.fill" }
        if lower.contains("scale") || lower.contains("scalable") { return "arrow.up.right" }
        if lower.contains("skill") || lower.contains("learn") { return "book.fill" }
        if lower.contains("income") || lower.contains("revenue") { return "chart.line.uptrend.xyaxis" }
        if lower.contains("remote") || lower.contains("flexible") { return "house.fill" }
        if lower.contains("startup") || lower.contains("tech") { return "sparkles" }
        if lower.contains("creative") || lower.contains("brand") { return "paintbrush.fill" }
        if lower.contains("recurring") || lower.contains("retainer") { return "repeat.circle.fill" }
        return "star.fill"
    }
}

// MARK: - Model Picker Page

private struct ModelPickerPageView: View {
    let models: [BusinessModel]
    let selectedModel: BusinessModel
    let onSelect: (BusinessModel) -> Void
    let onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Choose your path")
                    .font(Theme.Typography.heading1)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .padding(.top, Theme.Spacing.xxxl)

                Text("All paths share the same Foundation. Pick the model that excites you.")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineSpacing(4)
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xxl)

            ScrollView {
                VStack(spacing: Theme.Spacing.md) {
                    ForEach(models) { model in
                        ModelPickerCard(
                            model: model,
                            isSelected: model.shortName == selectedModel.shortName,
                            onSelect: { onSelect(model) }
                        )
                    }
                    Spacer().frame(height: Theme.Spacing.xl)
                }
                .padding(.horizontal, Theme.Spacing.lg)
            }

            GradientButton("Continue with \(selectedModel.shortName)") {
                onContinue()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xl)
        }
    }
}

private struct ModelPickerCard: View {
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

// MARK: - Confirmation Page

private struct ConfirmationPageView: View {
    let model: BusinessModel
    let onBegin: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Success icon
            ZStack {
                Theme.Colors.successBg
                Image(systemName: "checkmark")
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(Theme.Colors.success)
            }
            .frame(width: 88, height: 88)
            .cornerRadius(Theme.CornerRadius.xl)
            .shadow(color: Theme.Colors.success.opacity(0.3), radius: 24, x: 0, y: 0)

            Spacer().frame(height: Theme.Spacing.xl)

            Text("You're ready.")
                .font(.custom("Inter", size: 40).weight(.semibold))
                .foregroundColor(Theme.Colors.textPrimary)
                .tracking(-0.5)

            Spacer().frame(height: Theme.Spacing.sm)

            Text("Your business journey starts now.")
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textSecondary)

            Spacer().frame(height: Theme.Spacing.xxxl)

            // Selected model summary
            HStack(spacing: Theme.Spacing.md) {
                IconContainer(icon: model.icon, size: .medium, style: .blueGradient)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Your path")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                    Text(model.name)
                        .font(Theme.Typography.bodyMedium)
                        .foregroundColor(Theme.Colors.textPrimary)
                }

                Spacer()
            }
            .padding(Theme.Spacing.lg)
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                    .stroke(Theme.Colors.divider, lineWidth: 0.633)
            )
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer()

            GradientButton("Begin My Journey", icon: "sparkles") {
                onBegin()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xl)
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingView()
        .environmentObject(AppViewModel())
}
