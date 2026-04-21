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
                // Progress bar (hidden on welcome; Match renders its own header).
                if currentPage != .welcome && currentPage != .match {
                    OnboardingProgressBar(progress: progress)
                        .padding(.top, 56) // below status bar
                }

                // Back button row (Match handles its own close button).
                if [.experienceQuestion, .goalQuestion, .modelPicker].contains(currentPage) {
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
                            // Persist the internal onboarding profile *before*
                            // selecting the model so it's available to the
                            // Match-screen AI prompt that fires onAppear.
                            viewModel.setOnboardingProfile(
                                experience: selectedExperience,
                                goal: selectedGoal
                            )
                            viewModel.selectModel(recommendedModel)
                            advance(to: .match)
                        }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                case .match:
                    MatchPageView(
                        model: recommendedModel,
                        experience: selectedExperience,
                        goal: selectedGoal,
                        onAccept: { advance(to: .confirmation) },
                        onSeeAll: { advance(to: .modelPicker) },
                        onClose: goBack
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

// MARK: - Questionnaire display labels
//
// The persisted enums live in `UserProgress.swift` with stable raw values
// (`beginner`, `someExperience`, …). These extensions only supply the
// human-readable copy used by the onboarding UI.

extension ExperienceLevel {
    var title: String {
        switch self {
        case .beginner:       return "Complete beginner"
        case .someExperience: return "Tried a few things"
        case .experienced:    return "I have experience"
        }
    }

    var subtitle: String {
        switch self {
        case .beginner:       return "Starting completely from zero"
        case .someExperience: return "Explored but haven't succeeded yet"
        case .experienced:    return "Ready to scale what I know"
        }
    }
}

extension BusinessGoal {
    var title: String {
        switch self {
        case .sideIncome:   return "Earn extra income"
        case .fullBusiness: return "Build a full-time business"
        case .replaceJob:   return "Replace my current job"
        }
    }

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
                .font(Theme.Typography.onboardingLogoMark)
                .foregroundColor(Theme.Colors.textPrimary)
                .tracking(-1)

            Spacer().frame(height: Theme.Spacing.md)

            Text("Build your online business.")
                .font(Theme.Typography.onboardingTagline)
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
                    .font(Theme.Typography.onboardingQuestionTitle)
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
                        title: level.title,
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
                    .font(Theme.Typography.onboardingQuestionTitle)
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
                        title: goal.title,
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

/// State machine for the personalized AI explanation block on Match.
/// `.hidden` covers all failure modes (no API key, network error, parse
/// error) — per product spec we silently drop the block instead of showing
/// retry / error UI.
private enum MatchExplanationState {
    case loading
    case success(String)
    case hidden
}

private struct MatchPageView: View {
    let model: BusinessModel
    let experience: ExperienceLevel?
    let goal: BusinessGoal?
    let onAccept: () -> Void
    let onSeeAll: () -> Void
    let onClose: () -> Void

    @State private var explanationState: MatchExplanationState = .loading

    private let aiService = AIService.shared

    var body: some View {
        VStack(spacing: 0) {
            matchHeader

            ScrollView {
                VStack(spacing: Theme.Spacing.xxl) {
                    hero
                    modelCard
                    bottomActions
                }
                .padding(.horizontal, Theme.Spacing.xxl)
                .padding(.bottom, Theme.Spacing.xl)
            }
        }
        .onAppear(perform: startExplanationFetch)
    }

    // MARK: - Header (close + progress)

    private var matchHeader: some View {
        HStack(spacing: Theme.Spacing.md) {
            Button(action: onClose) {
                Image(systemName: "xmark")
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
            .accessibilityLabel("Close match")

            ProgressBar(progress: 1, height: 4)
        }
        .padding(.horizontal, Theme.Spacing.xxl)
        .padding(.bottom, Theme.Spacing.lg)
    }

    // MARK: - Hero

    private var hero: some View {
        VStack(spacing: Theme.Spacing.lg) {
            ZStack {
                Theme.Gradients.primaryButton
                Image(systemName: "sparkles")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(Theme.CornerRadius.xl)
            .shadow(color: Theme.Colors.primaryBlue.opacity(0.3), radius: 30, x: 0, y: 0)

            VStack(spacing: Theme.Spacing.sm) {
                Text("Perfect Match Found")
                    .font(Theme.Typography.heading1)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Your personalized business model is ready")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, Theme.Spacing.lg)
    }

    // MARK: - Model card (loading / success / hidden)

    private var modelCard: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            switch explanationState {
            case .loading:
                loadingCardContent
            case .success(let text):
                successCardContent(text: text)
            case .hidden:
                successCardContent(text: nil)
            }
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }

    // Loading: full skeleton — model code/name/AI block all replaced with
    // shimmer placeholders + a microcopy line + indeterminate progress;
    // benefits are hidden entirely.
    @ViewBuilder
    private var loadingCardContent: some View {
        SkeletonBar(width: 120, height: 14)
        SkeletonBar(width: 200, height: 20)

        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            Text("Personalizing your recommendation…")
                .font(Theme.Typography.small)
                .foregroundColor(Theme.Colors.textSecondary)

            IndeterminateProgressBar()
        }
        .padding(.top, Theme.Spacing.sm)

        Rectangle()
            .fill(Color(hex: "252530").opacity(0.3))
            .frame(height: 1)
            .padding(.top, Theme.Spacing.sm)
    }

    // Success / hidden share the same shell. When `text == nil` the AI
    // paragraph block is omitted but kürzel + name + benefits stay.
    @ViewBuilder
    private func successCardContent(text: String?) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "sparkles")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Theme.Colors.primaryBlue)

            Text(model.shortName.uppercased())
                .font(Theme.Typography.smallMedium)
                .foregroundColor(Theme.Colors.primaryBlue)
                .tracking(1.5)
        }

        Text(model.name)
            .font(Theme.Typography.bodySemiBold)
            .foregroundColor(Theme.Colors.textPrimary)

        if let text = text, !text.isEmpty {
            Text(text)
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textPrimary.opacity(0.9))
                .lineSpacing(4)
                .padding(.top, Theme.Spacing.xs)
        }

        Rectangle()
            .fill(Color(hex: "252530").opacity(0.3))
            .frame(height: 1)
            .padding(.vertical, Theme.Spacing.xs)

        VStack(spacing: Theme.Spacing.md) {
            ForEach(model.benefits, id: \.self) { benefit in
                MatchBenefitRow(icon: benefitIcon(for: benefit), text: benefit)
            }
        }
    }

    // MARK: - Bottom actions (PrimaryButton + skeleton + See all)

    private var bottomActions: some View {
        VStack(spacing: Theme.Spacing.md) {
            switch explanationState {
            case .loading:
                MatchSkeletonButton()
            case .success, .hidden:
                PrimaryButton("Start with \(model.shortName)", icon: "arrow.right") {
                    onAccept()
                }
            }

            Button(action: onSeeAll) {
                Text("See all models")
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Theme.Spacing.sm)
            }
        }
        .padding(.top, Theme.Spacing.lg)
    }

    // MARK: - Actions

    private func startExplanationFetch() {
        // Re-entry guard: if we already have content, don't refetch.
        if case .loading = explanationState { } else { return }

        aiService.generateMatchExplanation(
            model: model,
            experience: experience,
            goal: goal
        ) { result in
            switch result {
            case .success(let text):
                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                explanationState = trimmed.isEmpty ? .hidden : .success(trimmed)
            case .failure:
                explanationState = .hidden
            }
        }
    }

    private func benefitIcon(for benefit: String) -> String {
        let lower = benefit.lowercased()
        if lower.contains("cost") || lower.contains("capital") || lower.contains("€") || lower.contains("$") { return "dollarsign.circle.fill" }
        if lower.contains("demand") || lower.contains("client") || lower.contains("market") { return "person.2.fill" }
        if lower.contains("scale") || lower.contains("scalable") || lower.contains("growing") { return "arrow.up.right" }
        if lower.contains("skill") || lower.contains("learn") { return "book.fill" }
        if lower.contains("income") || lower.contains("revenue") || lower.contains("commission") { return "chart.line.uptrend.xyaxis" }
        if lower.contains("remote") || lower.contains("flexible") { return "house.fill" }
        if lower.contains("startup") || lower.contains("tech") || lower.contains("technology") { return "sparkles" }
        if lower.contains("creative") || lower.contains("brand") { return "paintbrush.fill" }
        if lower.contains("recurring") || lower.contains("retainer") { return "repeat.circle.fill" }
        if lower.contains("competition") { return "trophy.fill" }
        if lower.contains("inventory") || lower.contains("shipping") || lower.contains("product") { return "shippingbox.fill" }
        if lower.contains("pricing") || lower.contains("premium") { return "tag.fill" }
        return "checkmark.seal.fill"
    }
}

// MARK: - Match skeleton button (loading-state CTA placeholder)

/// Full-width 56pt placeholder shown in place of the PrimaryButton while
/// the AI explanation is loading. Muted bg + a centered shimmer slug
/// mirroring Figma 2005-1625.
private struct MatchSkeletonButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .fill(Color(hex: "252530").opacity(0.25))

            SkeletonBar(width: 180, height: 18)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .accessibilityLabel("Personalizing your recommendation")
    }
}

// MARK: - Match benefit row (inline, replaces former BenefitCard)

private struct MatchBenefitRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            ZStack {
                LinearGradient(
                    colors: [Theme.Colors.primaryBlue.opacity(0.2),
                             Theme.Colors.secondaryBlue.opacity(0.15)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Theme.Colors.primaryBlue)
            }
            .frame(width: 44, height: 44)
            .cornerRadius(14)
            .shadow(color: Theme.Colors.primaryBlue.opacity(0.15), radius: 16, x: 0, y: 0)

            Text(text)
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            ZStack {
                LinearGradient(
                    colors: [Theme.Colors.success, Color(hex: "00c950")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 28, height: 28)
            .clipShape(Circle())
            .shadow(color: Theme.Colors.success.opacity(0.3), radius: 12, x: 0, y: 0)
        }
        .padding(14)
        .background(Color(hex: "13131a").opacity(0.6))
        .cornerRadius(Theme.CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                .stroke(Color(hex: "252530").opacity(0.3), lineWidth: 0.633)
        )
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
                    .font(Theme.Typography.onboardingQuestionTitle)
                    .foregroundColor(Theme.Colors.textPrimary)

                Text("Each model has its own videos, tasks, and foundation steps.")
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
                .font(Theme.Typography.onboardingConfirmationTitle)
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
