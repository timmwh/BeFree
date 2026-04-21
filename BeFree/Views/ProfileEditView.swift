//
//  ProfileEditView.swift
//  BeFree
//
//  Created by AI Assistant on 20.04.26.
//

import SwiftUI

/// Edit Profile screen per Figma 2005-1583. Edits the community identity
/// (firstName, lastName, username) — never the internal onboarding profile.
/// Save persists via `AppViewModel.setCommunityProfile(...)` then dismisses.
struct ProfileEditView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var showPhotoNotice = false

    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView {
                    VStack(spacing: 32) {
                        avatarBlock
                        textFields
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 140) // space for sticky save + gradient
                }
            }

            VStack(spacing: 0) {
                Spacer()
                stickySaveButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .hidesCustomTabBar()
        .onAppear(perform: loadFromViewModel)
        .alert("Photo editing coming soon", isPresented: $showPhotoNotice) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You'll be able to choose a profile photo in a future update.")
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: 16) {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Circle())
            }
            .accessibilityLabel("Back")

            Text("Edit Profile")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)

            // Spacer balance to keep the title centered.
            Color.clear.frame(width: 40, height: 40)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    // MARK: - Avatar block

    private var avatarBlock: some View {
        VStack(spacing: 18) {
            ZStack(alignment: .bottomTrailing) {
                AvatarCircle(initials: previewInitials, size: 100, fontSize: 36)

                ZStack {
                    Circle()
                        .fill(Color(hex: "1a1a24"))
                        .overlay(
                            Circle()
                                .stroke(Color(hex: "0a0a0f"), lineWidth: 1.9)
                        )

                    Image(systemName: "camera.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30)
                .offset(x: 0, y: 0)
            }

            Button(action: { showPhotoNotice = true }) {
                Text("Change Photo")
                    .font(.system(size: 14))
                    .foregroundColor(Theme.Colors.textSecondary)
            }
        }
    }

    private var previewInitials: String {
        let f = firstName.trimmingCharacters(in: .whitespacesAndNewlines).first.map { String($0) } ?? ""
        let l = lastName.trimmingCharacters(in: .whitespacesAndNewlines).first.map { String($0) } ?? ""
        let combined = (f + l).uppercased()
        return combined.isEmpty ? "?" : combined
    }

    // MARK: - Text fields

    private var textFields: some View {
        VStack(spacing: 16) {
            EditField(label: "First Name", text: $firstName)
            EditField(label: "Last Name", text: $lastName)
            EditField(label: "Username", text: $username, autocapitalization: .never)
        }
    }

    // MARK: - Save button + gradient fade

    private var stickySaveButton: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [
                    Theme.Colors.background.opacity(0),
                    Theme.Colors.background.opacity(0.9),
                    Theme.Colors.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 130)
            .allowsHitTesting(false)

            Button(action: save) {
                Text("Save")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "0a0a0f"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(14)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
    }

    // MARK: - Actions

    private func loadFromViewModel() {
        firstName = viewModel.userProgress.firstName ?? ""
        lastName  = viewModel.userProgress.lastName ?? ""
        username  = viewModel.userProgress.username ?? ""
    }

    private func save() {
        viewModel.setCommunityProfile(
            firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty,
            lastName:  lastName.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty,
            username:  username.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        )
        dismiss()
    }
}

// MARK: - Edit field

private struct EditField: View {
    let label: String
    @Binding var text: String
    var autocapitalization: TextInputAutocapitalization = .words

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(Theme.Colors.textSecondary)

            TextField("", text: $text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled(label == "Username")
                .frame(height: 22)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.04))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.08), lineWidth: 0.633)
        )
    }
}

// MARK: - String helper

private extension String {
    var nilIfEmpty: String? { isEmpty ? nil : self }
}

#Preview {
    NavigationStack {
        ProfileEditView()
            .environmentObject(AppViewModel())
    }
}
