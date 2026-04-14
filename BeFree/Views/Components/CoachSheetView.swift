//
//  CoachSheetView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 09.04.26.
//

import SwiftUI

struct CoachSheetView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let step: Step
    @Environment(\.dismiss) var dismiss

    @State private var messages: [ChatMessage] = []
    @State private var inputText = ""
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    @FocusState private var isInputFocused: Bool

    private let aiService = AIService.shared

    private let suggestedQuestions = [
        "How do I get started with this step?",
        "What's the most common mistake here?",
        "How long should this realistically take?",
        "What if I'm stuck or overwhelmed?"
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Your Coach")
                        .font(Theme.Typography.bodySemiBold)
                        .foregroundColor(Theme.Colors.textPrimary)
                    Text("Ask anything about \"\(step.title)\"")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .lineLimit(1)
                }
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Theme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.vertical, Theme.Spacing.md)
            .background(Theme.Colors.cardBackground)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Theme.Colors.divider)
                    .frame(height: 0.5)
            }

            // Messages or empty state
            ScrollViewReader { proxy in
                ScrollView {
                    if messages.isEmpty {
                        emptyStateView
                    } else {
                        LazyVStack(spacing: Theme.Spacing.md) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                            if isLoading {
                                TypingIndicator()
                                    .id("typing")
                            }
                            if let error = errorMessage {
                                ErrorBanner(message: error) {
                                    errorMessage = nil
                                }
                                .id("error")
                            }
                        }
                        .padding(Theme.Spacing.lg)
                    }
                }
                .onChange(of: messages.count) { _, _ in
                    if let last = messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
                .onChange(of: isLoading) { _, loading in
                    if loading {
                        withAnimation { proxy.scrollTo("typing", anchor: .bottom) }
                    }
                }
            }

            // Input area
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Theme.Colors.divider)
                    .frame(height: 0.5)

                HStack(spacing: Theme.Spacing.sm) {
                    TextField("Ask your coach...", text: $inputText, axis: .vertical)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .lineLimit(1...4)
                        .focused($isInputFocused)
                        .onSubmit { sendMessage() }

                    Button(action: sendMessage) {
                        ZStack {
                            if isLoading || inputText.trimmingCharacters(in: .whitespaces).isEmpty {
                                Circle()
                                    .fill(Theme.Colors.cardBackground)
                                    .frame(width: 36, height: 36)
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Theme.Colors.textSecondary)
                            } else {
                                Circle()
                                    .fill(Theme.Gradients.primaryButton)
                                    .frame(width: 36, height: 36)
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .disabled(isLoading || inputText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.vertical, Theme.Spacing.md)
            }
            .background(Theme.Colors.cardBackground)
        }
        .background(Theme.Colors.background)
        .onAppear {
            if !aiService.isConfigured {
                errorMessage = "AI coach not configured. Add your OpenAI key to Config.swift."
            }
        }
    }

    // MARK: - Empty State

    private var emptyStateView: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer().frame(height: Theme.Spacing.xl)

            // Coach icon
            ZStack {
                Theme.Gradients.primaryButton
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .frame(width: 60, height: 60)
            .cornerRadius(Theme.CornerRadius.lg)
            .primaryGlow()

            VStack(spacing: Theme.Spacing.sm) {
                Text("Ask your coach")
                    .font(Theme.Typography.bodySemiBold)
                    .foregroundColor(Theme.Colors.textPrimary)
                Text("Get instant answers about this step,\ntailored to your \(viewModel.businessModel?.shortName ?? "business") path.")
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }

            // Suggested questions
            VStack(spacing: Theme.Spacing.sm) {
                ForEach(suggestedQuestions, id: \.self) { question in
                    Button(action: {
                        inputText = question
                        sendMessage()
                    }) {
                        Text(question)
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, Theme.Spacing.lg)
                            .padding(.vertical, Theme.Spacing.md)
                            .background(Theme.Colors.cardBackground)
                            .cornerRadius(Theme.CornerRadius.md)
                            .overlay(
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.md)
                                    .stroke(Theme.Colors.divider, lineWidth: 0.633)
                            )
                    }
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)

            Spacer()
        }
    }

    // MARK: - Actions

    private func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty, !isLoading else { return }

        let userMessage = ChatMessage(role: .user, content: text)
        messages.append(userMessage)
        inputText = ""
        isLoading = true
        errorMessage = nil
        isInputFocused = false

        aiService.sendMessage(
            text,
            history: messages.dropLast(),
            step: step,
            businessModel: viewModel.businessModel
        ) { result in
            isLoading = false
            switch result {
            case .success(let reply):
                messages.append(ChatMessage(role: .assistant, content: reply))
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

// MARK: - Message Bubble

private struct MessageBubble: View {
    let message: ChatMessage

    var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .bottom, spacing: Theme.Spacing.sm) {
            if isUser { Spacer(minLength: 48) }

            if !isUser {
                ZStack {
                    Theme.Gradients.primaryButton
                    Image(systemName: "sparkles")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 28, height: 28)
                .cornerRadius(Theme.CornerRadius.pill)
            }

            Text(message.content)
                .font(Theme.Typography.body)
                .foregroundColor(isUser ? .white : Theme.Colors.textPrimary)
                .lineSpacing(3)
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.vertical, Theme.Spacing.md)
                .background(
                    isUser
                        ? AnyView(Theme.Gradients.primaryButton)
                        : AnyView(Theme.Colors.cardBackground)
                )
                .cornerRadius(isUser ? 18 : 16)
                .overlay(
                    Group {
                        if !isUser {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Theme.Colors.divider, lineWidth: 0.633)
                        }
                    }
                )

            if !isUser { Spacer(minLength: 48) }
        }
    }
}

// MARK: - Typing Indicator

private struct TypingIndicator: View {
    @State private var animate = false

    var body: some View {
        HStack(alignment: .bottom, spacing: Theme.Spacing.sm) {
            ZStack {
                Theme.Gradients.primaryButton
                Image(systemName: "sparkles")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(width: 28, height: 28)
            .cornerRadius(Theme.CornerRadius.pill)

            HStack(spacing: 4) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Theme.Colors.textSecondary)
                        .frame(width: 7, height: 7)
                        .scaleEffect(animate ? 1.2 : 0.8)
                        .animation(
                            .easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(Double(i) * 0.15),
                            value: animate
                        )
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.vertical, Theme.Spacing.md)
            .background(Theme.Colors.cardBackground)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Theme.Colors.divider, lineWidth: 0.633)
            )

            Spacer(minLength: 48)
        }
        .onAppear { animate = true }
    }
}

// MARK: - Error Banner

private struct ErrorBanner: View {
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 14))
                .foregroundColor(Theme.Colors.warning)
            Text(message)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .lineLimit(2)
            Spacer()
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 12))
                    .foregroundColor(Theme.Colors.textSecondary)
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.warningBg)
        .cornerRadius(Theme.CornerRadius.sm)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.sm)
                .stroke(Theme.Colors.warningBorder, lineWidth: 0.633)
        )
    }
}

// MARK: - Preview

#Preview {
    CoachSheetView(step: DataService.shared.getFoundationSteps(for: "AAA")[0])
        .environmentObject(AppViewModel())
}
