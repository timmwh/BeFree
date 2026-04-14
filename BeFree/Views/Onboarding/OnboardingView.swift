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
        case experienceQuestion
        case goalQuestion
        case match
        case modelPicker
        case confirmation
    }

    var progress: Double {
        switch currentPage {
        case .welcome:           return 0
        case .experienceQuestion: return 0.25
        case .goalQuestion:      return 0.5
        case .match:             return 0.75
        case .modelPicker:       return 0.75
        case .confirmation:      return 1.0
        }
    }

    var recommendedModel: BusinessModel {
        let models = viewModel.allBusinessModels
        // TikTok Shop → complete beginners and side-income seekers (fast results, zero capital)
        // AAA → experienced users and those building a full business or replacing their job
        switch (selectedExperience, selectedGoal) {
        case (_, .sideIncome):
            return models.first(where: { $0.shortName == "TikTok Shop" }) ?? models[0]
        case (.beginner, _):
            return models.first(where: { $0.shortName == "TikTok Shop" }) ?? models[0]
        default:
            return models.first(where: { $0.shortName == "AAA" }) ?? models[0]
        }
    }

    func goBack() {
        withAnimation(.easeInOut(duration: 0.3)) {
            switch currentPage {
            case .experienceQuestion: currentPage = .welcome
            case .goalQuestion:       currentPage = .experienceQuestion
            case .match:              currentPage = .goalQuestion
            case .modelPicker:        currentPage = .match
            default: break
            }
        }
    }

    func advance(to page: OnboardingPage) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentPage = page
        }
    }

    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Progress bar (hidden on welcome)
                if currentPage != .welcome {
                    OnboardingProgressBar(progress: progress)
                        .padding(.top, 56) // below status bar
                }

                // Back button row (shown on question + match screens)
                if [.experienceQuestion, .goalQuestion, .match, .modelPicker].contains(currentPage) {
                    HStack {
                        OnboardingBackButton(action: goBack)
                        Spacer()
                    }
                    .padding(.horizontal, Theme.Spacing.lg)
                    .padding(.top, Theme.Spacing.sm)
                }

                // Page content
                switch currentPage {
                case .welcome:
                    WelcomePageView {
                        advance(to: .experienceQuestion)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                case .experienceQuestion:
                    ExperienceQuestionView(
                        selected: $selectedExperience,
                        onContinue: { advance(to: .goalQuestion) }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                case .goalQuestion:
                    GoalQuestionView(
                        selected: $selectedGoal,
                        onContinue: {
                            viewModel.selectModel(recommendedModel)
                            advance(to: .match)
                        }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                case .match:
                    MatchPageView(
                        model: recommendedModel,
                        onAccept: { advance(to: .confirmation) },
                        onSeeAll: { advance(to: .modelPicker) }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                case .modelPicker:
                    ModelPickerPageView(
                        models: viewModel.allBusinessModels,
                        selectedModel: viewModel.businessModel ?? recommendedModel,
                        onSelect: { viewModel.selectModel($0) },
                        onContinue: { advance(to: .confirmation) }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                case .confirmation:
                    ConfirmationPageView(
                        model: viewModel.businessModel ?? recommendedModel,
                        onBegin: { viewModel.completeOnboarding() }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}

// MARK: - Shared Components

struct OnboardingProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Theme.Colors.border)
                Rectangle()
                    .fill(Theme.Colors.primaryBlue)
                    .frame(width: max(0, geo.size.width * progress))
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 3)
    }
}

struct OnboardingBackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Theme.Colors.textPrimary)
                .frame(width: 44, height: 44)
        }
    }
}

struct OnboardingContinueButton: View {
    let title: String
    var isEnabled: Bool = true
    let action: () -> Void

    init(_ title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.bodySemiBold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(isEnabled ? Theme.Colors.primaryBlue : Theme.Colors.cardBackground)
                .cornerRadius(26)
                .overlay(
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(isEnabled ? Color.clear : Theme.Colors.border, lineWidth: 1)
                )
        }
        .disabled(!isEnabled)
        .animation(.easeInOut(duration: 0.15), value: isEnabled)
    }
}

// MARK: - Questionnaire Data

enum ExperienceLevel: String, CaseIterable {
    case beginner = "Complete beginner"
    case tried = "Tried a few things"
    case experienced = "I have experience"

    var subtitle: String {
        switch self {
        case .beginner:    return "Starting completely from zero"
        case .tried:       return "Explored but haven't succeeded yet"
        case .experienced: return "Ready to scale what I know"
        }
    }
}

enum BusinessGoal: String, CaseIterable {
    case sideIncome   = "Earn extra income"
    case fullBusiness = "Build a full-time business"
    case replaceJob   = "Replace my current job"

    var subtitle: String {
        switch self {
        case .sideIncome:   return "On the side of what I already do"
        case .fullBusiness: return "Make this my primary focus"
        case .replaceJob:   return "Go all-in and quit my job"
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
            .frame(width: 80, height: 80)
            .cornerRadius(22)
            .primaryGlow()

            Spacer().frame(height: 28)

            Text("BeFree")
                .font(.custom("Inter", size: 44).weight(.semibold))
                .foregroundColor(Theme.Colors.textPrimary)
                .tracking(-1)

            Spacer().frame(height: Theme.Spacing.md)

            Text("Build your online business.")
                .font(.custom("Inter", size: 22).weight(.semibold))
                .foregroundColor(Theme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Spacer().frame(height: Theme.Spacing.sm)

            Text("One clear step. One guided session.\nOne daily win at a time.")
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer()

            OnboardingContinueButton("Get Started") {
                onGetStarted()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xxxl)
        }
    }
}

// MARK: - Experience Question Screen

private struct ExperienceQuestionView: View {
    @Binding var selected: ExperienceLevel?
    let onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Question
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("What's your\nstarting point?")
                    .font(.custom("Inter", size: 30).weight(.bold))
                    .foregroundColor(Theme.Colors.textPrimary)
                    .lineSpacing(2)

                Text("This helps us personalize your roadmap.")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.top, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xxl)

            // Options
            VStack(spacing: Theme.Spacing.sm) {
                ForEach(ExperienceLevel.allCases, id: \.self) { level in
                    OnboardingOptionCard(
                        title: level.rawValue,
                        subtitle: level.subtitle,
                        isSelected: selected == level
                    ) {
                        withAnimation(.easeInOut(duration: 0.15)) { selected = level }
                    }
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer()

            OnboardingContinueButton("Continue", isEnabled: selected != nil) {
                onContinue()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xxxl)
        }
    }
}

// MARK: - Goal Question Screen

private struct GoalQuestionView: View {
    @Binding var selected: BusinessGoal?
    let onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Question
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("What's your\nprimary goal?")
                    .font(.custom("Inter", size: 30).weight(.bold))
                    .foregroundColor(Theme.Colors.textPrimary)
                    .lineSpacing(2)

                Text("We'll recommend the best path for you.")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.top, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xxl)

            // Options
            VStack(spacing: Theme.Spacing.sm) {
                ForEach(BusinessGoal.allCases, id: \.self) { goal in
                    OnboardingOptionCard(
                        title: goal.rawValue,
                        subtitle: goal.subtitle,
                        isSelected: selected == goal
                    ) {
                        withAnimation(.easeInOut(duration: 0.15)) { selected = goal }
                    }
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer()

            OnboardingContinueButton("Continue", isEnabled: selected != nil) {
                onContinue()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xxxl)
        }
    }
}

// MARK: - Option Card (Cal AI style)

private struct OnboardingOptionCard: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Theme.Spacing.md) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(Theme.Typography.bodyMedium)
                        .foregroundColor(isSelected ? .white : Theme.Colors.textPrimary)
                    Text(subtitle)
                        .font(Theme.Typography.caption)
                        .foregroundColor(isSelected ? .white.opacity(0.75) : Theme.Colors.textSecondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.vertical, 18)
            .background(isSelected ? Theme.Colors.primaryBlue : Theme.Colors.cardBackground)
            .cornerRadius(Theme.CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                    .stroke(isSelected ? Color.clear : Theme.Colors.border, lineWidth: 0.633)
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
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        Text("Your perfect\nmatch")
                            .font(.custom("Inter", size: 30).weight(.bold))
                            .foregroundColor(Theme.Colors.textPrimary)
                            .lineSpacing(2)

                        Text("Based on your answers, we recommend:")
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                    .padding(.horizontal, Theme.Spacing.lg)
                    .padding(.top, Theme.Spacing.lg)

                    Spacer().frame(height: Theme.Spacing.xxl)

                    // Model card
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
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

                    Spacer().frame(height: Theme.Spacing.xl)
                }
            }

            // Fixed bottom buttons
            VStack(spacing: Theme.Spacing.md) {
                OnboardingContinueButton("Start with \(model.shortName)") {
                    onAccept()
                }

                Button("See all models") {
                    onSeeAll()
                }
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xxxl)
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
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Choose your path")
                    .font(.custom("Inter", size: 30).weight(.bold))
                    .foregroundColor(Theme.Colors.textPrimary)

                Text("All paths share the same Foundation.")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.top, Theme.Spacing.lg)

            Spacer().frame(height: Theme.Spacing.xl)

            ScrollView {
                VStack(spacing: Theme.Spacing.md) {
                    ForEach(models) { model in
                        ModelPickerCard(
                            model: model,
                            isSelected: model.shortName == selectedModel.shortName,
                            onSelect: { onSelect(model) }
                        )
                    }
                    Spacer().frame(height: Theme.Spacing.md)
                }
                .padding(.horizontal, Theme.Spacing.lg)
            }

            OnboardingContinueButton("Continue with \(selectedModel.shortName)") {
                onContinue()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xxxl)
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
                    IconContainer(icon: model.icon, size: .large, style: isSelected ? .blueGradient : .blue)

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

            ZStack {
                Theme.Colors.successBg
                Image(systemName: "checkmark")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(Theme.Colors.success)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(22)
            .shadow(color: Theme.Colors.success.opacity(0.3), radius: 24, x: 0, y: 0)

            Spacer().frame(height: Theme.Spacing.xl)

            Text("You're ready.")
                .font(.custom("Inter", size: 36).weight(.semibold))
                .foregroundColor(Theme.Colors.textPrimary)
                .tracking(-0.5)

            Spacer().frame(height: Theme.Spacing.sm)

            Text("Your business journey starts now.")
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textSecondary)

            Spacer().frame(height: Theme.Spacing.xxxl)

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

            OnboardingContinueButton("Begin My Journey") {
                onBegin()
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.bottom, Theme.Spacing.xxxl)
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingView()
        .environmentObject(AppViewModel())
}
