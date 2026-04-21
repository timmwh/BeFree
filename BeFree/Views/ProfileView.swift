//
//  ProfileView.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// Profile tab per Figma 2005-1480. Hosts an internal segmented control
/// switching between a designed "Profile" sub-tab (community identity,
/// active path, progress stats) and an undesigned "Settings" placeholder.
struct ProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedSubTab: SubTab = .profile
    @State private var showModelPicker = false
    @State private var showResetConfirmation = false

    enum SubTab { case profile, settings }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                segmentedControl
                    .padding(.horizontal, Theme.Spacing.xl)
                    .padding(.top, Theme.Spacing.md)

                ScrollView {
                    Group {
                        switch selectedSubTab {
                        case .profile:  profileSubTab
                        case .settings: settingsPlaceholder
                        }
                    }
                    .padding(.top, Theme.Spacing.lg)
                    .padding(.horizontal, Theme.Spacing.xl)
                    .padding(.bottom, Theme.Spacing.xl)
                }
            }
            .background(Theme.Colors.background)
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

    // MARK: - Segmented control

    private var segmentedControl: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white.opacity(0.06), lineWidth: 0.633)
                )

            HStack(spacing: 0) {
                segmentedButton(.profile, label: "Profile")
                segmentedButton(.settings, label: "Settings")
            }
            .padding(3)
        }
        .frame(height: 45)
    }

    private func segmentedButton(_ tab: SubTab, label: String) -> some View {
        let isActive = selectedSubTab == tab
        return Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                selectedSubTab = tab
            }
        } label: {
            Text(label)
                .font(.system(size: 14, weight: isActive ? .semibold : .regular))
                .foregroundColor(isActive ? .white : Theme.Colors.textSecondary)
                .frame(maxWidth: .infinity)
                .frame(height: 38)
                .background(
                    Group {
                        if isActive {
                            RoundedRectangle(cornerRadius: 11)
                                .fill(Color.white.opacity(0.1))
                        }
                    }
                )
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Profile sub-tab

    private var profileSubTab: some View {
        VStack(alignment: .leading, spacing: 32) {
            avatarCard
            yourPathSection
            progressSection
            resetProgressButton
        }
    }

    // 6.3 — Avatar card → EditProfile

    private var avatarCard: some View {
        NavigationLink(destination: ProfileEditView()) {
            HStack(spacing: 16) {
                AvatarCircle(initials: viewModel.userProgress.avatarInitials, size: 56, fontSize: 20)

                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.userProgress.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)

                    Text(usernameDisplay)
                        .font(.system(size: 14))
                        .foregroundColor(Theme.Colors.textSecondary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(16)
            .background(Color.white.opacity(0.04))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.633)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var usernameDisplay: String {
        if let username = viewModel.userProgress.username, !username.isEmpty {
            return "@\(username)"
        }
        return "Add a username"
    }

    // Your Path

    private var yourPathSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            ProfileSectionLabel(icon: "sparkles", title: "Your Path")
            yourPathCard
        }
    }

    @ViewBuilder
    private var yourPathCard: some View {
        if let model = viewModel.businessModel {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    ZStack {
                        Theme.Gradients.primaryButton
                        Image(systemName: model.icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 48, height: 48)
                    .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(model.shortName.uppercased())
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Theme.Colors.primaryBlue)
                        Text(model.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Active")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(hex: "22c55e"))
                        .padding(.horizontal, 12)
                        .frame(height: 28)
                        .background(Color(hex: "22c55e").opacity(0.15))
                        .cornerRadius(Theme.CornerRadius.pill)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.CornerRadius.pill)
                                .stroke(Color(hex: "22c55e").opacity(0.3), lineWidth: 0.633)
                        )
                }

                Text(model.description)
                    .font(.system(size: 14))
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineSpacing(3)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button {
                    showModelPicker = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Switch Model")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 47)
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.08), lineWidth: 0.633)
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(20)
            .background(Color.white.opacity(0.04))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.633)
            )
        } else {
            Text("No business model selected.")
                .font(.system(size: 14))
                .foregroundColor(Theme.Colors.textSecondary)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.04))
                .cornerRadius(16)
        }
    }

    // Progress

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            ProfileSectionLabel(icon: "chart.bar.fill", title: "Progress")

            HStack(spacing: 0) {
                ProgressStat(value: "\(viewModel.completedStepsCount)/\(viewModel.totalStepsCount)", label: "Steps Done")
                ProgressDivider()
                ProgressStat(value: "\(viewModel.userProgress.currentStreak)", label: "Day Streak")
                ProgressDivider()
                ProgressStat(value: "\(viewModel.userProgress.totalSessionSeconds / 60)", label: "Min Invested")
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(Color.white.opacity(0.04))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.633)
            )
        }
    }

    // Reset progress (dev-only convenience — not in Figma)

    private var resetProgressButton: some View {
        Button {
            showResetConfirmation = true
        } label: {
            Text("Reset progress (dev)")
                .font(.system(size: 14))
                .foregroundColor(Theme.Colors.textTertiary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.02))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.05), lineWidth: 0.633)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Settings sub-tab placeholder (no Figma yet)

    private var settingsPlaceholder: some View {
        VStack(spacing: 12) {
            Spacer().frame(height: 80)

            Image(systemName: "gearshape.fill")
                .font(.system(size: 40))
                .foregroundColor(Theme.Colors.textTertiary)

            Text("Settings coming soon")
                .font(Theme.Typography.bodyMedium)
                .foregroundColor(Theme.Colors.textSecondary)

            Text("Notifications, theme, and more")
                .font(Theme.Typography.small)
                .foregroundColor(Theme.Colors.textTertiary)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Helpers

private struct ProfileSectionLabel: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}

private struct ProgressStat: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ProgressDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.white.opacity(0.08))
            .frame(width: 0.633, height: 44)
    }
}

/// Reusable green-gradient avatar with overlaid initials.
struct AvatarCircle: View {
    let initials: String
    var size: CGFloat = 56
    var fontSize: CGFloat = 20

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "34d399"), Color(hex: "10b981")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Text(initials)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
}
