//
//  NextStepCard.swift
//  BeFree
//

import SwiftUI

// Figma 2042:3933 — featured "next step" card.
//
// Sizing: .padding(24) + .frame(minHeight:) so the card matches Figma at default
// Dynamic Type and grows gracefully rather than clipping at large sizes.
// No rigid .frame(height:) is used.
//
// Decorative layers (diagonal gradient + 3 bokeh dots) live in .background(), clipped
// to the card's RoundedRectangle. They are not layout siblings and never affect width.

/// Next Step featured card (Figma `2042:3933`). Tap is handled by an outer NavigationLink.
struct NextStepCard: View {
    let step: Step

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: Theme.DashboardLayout.nextStepTitleToBody) {
                Text(step.title)
                    .font(Theme.Typography.heading2)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .lineSpacing(4)
                    .tracking(0.07)

                Text(firstParagraph(from: step.description))
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineLimit(4)
                    .lineSpacing(Theme.DashboardLayout.nextStepBodyLineExtra)
                    .tracking(-0.31)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 16)

            ctaButton
        }
        .padding(Theme.DashboardLayout.cardInnerPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: Theme.DashboardLayout.nextStepCardMinHeight, alignment: .topLeading)
        .background(cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
        .shadow(color: Theme.Colors.primaryBlue.opacity(0.1), radius: 40, x: 0, y: 0)
    }

    // MARK: - Decorative background (gradient + bokeh dots)
    // Figma 2042:3934–3937. All layers clipped to the card shape.

    private var cardBackground: some View {
        ZStack(alignment: .topLeading) {
            // Base fill
            Theme.Colors.cardBackground

            // Diagonal gradient overlay (Figma 2042:3934, 10% opacity, 145.3°)
            LinearGradient(
                stops: [
                    .init(color: Theme.Colors.primaryBlue.opacity(0.2), location: 0),
                    .init(color: .clear, location: 0.5),
                    .init(color: Theme.Colors.secondaryBlue.opacity(0.2), location: 1)
                ],
                startPoint: UnitPoint(x: 0.1, y: 0),
                endPoint: UnitPoint(x: 0.9, y: 1)
            )
            .opacity(0.10)

            // Bokeh dot 1 (Figma 2042:3935)
            bokehDot(
                x: Theme.DashboardLayout.bokeh1X,
                y: Theme.DashboardLayout.bokeh1Y,
                size: Theme.DashboardLayout.bokeh1Size,
                opacity: Theme.DashboardLayout.bokeh1Opacity
            )

            // Bokeh dot 2 (Figma 2042:3936)
            bokehDot(
                x: Theme.DashboardLayout.bokeh2X,
                y: Theme.DashboardLayout.bokeh2Y,
                size: Theme.DashboardLayout.bokeh2Size,
                opacity: Theme.DashboardLayout.bokeh2Opacity
            )

            // Bokeh dot 3 (Figma 2042:3937)
            bokehDot(
                x: Theme.DashboardLayout.bokeh3X,
                y: Theme.DashboardLayout.bokeh3Y,
                size: Theme.DashboardLayout.bokeh3Size,
                opacity: Theme.DashboardLayout.bokeh3Opacity
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: Theme.CornerRadius.xl, style: .continuous))
    }

    private func bokehDot(x: CGFloat, y: CGFloat, size: CGFloat, opacity: CGFloat) -> some View {
        Circle()
            .fill(Theme.Colors.primaryBlue.opacity(0.5))
            .frame(width: size, height: size)
            .blur(radius: Theme.DashboardLayout.bokehBlur)
            .opacity(opacity)
            .offset(x: x, y: y)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: - CTA button (Figma 2042:3943–3947)
    // Horizontal blue gradient + shimmer overlay + triple glow shadow.

    private var ctaButton: some View {
        HStack(spacing: Theme.DashboardLayout.nextStepLabelIconGap) {
            Text("Start")
                .font(Theme.Typography.bodyMedium)
            Image(systemName: "arrow.right")
                .font(.system(size: Theme.DashboardLayout.nextStepLabelIconSize, weight: .semibold))
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: Theme.DashboardLayout.ctaHeight)
        .background(
            ZStack {
                // Base horizontal gradient (Figma: left→right primaryBlue→secondaryBlue)
                LinearGradient(
                    colors: [Theme.Colors.primaryBlue, Theme.Colors.secondaryBlue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                // Shimmer specular (Figma 2042:3944: clear→white@0.2→clear, left to right)
                LinearGradient(
                    colors: [.clear, Color.white.opacity(0.2), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: Theme.CornerRadius.md, style: .continuous))
        // Triple glow (Figma 2042:3943: 20@0.5 / 40@0.3 / 60@0.2)
        .shadow(color: Theme.Colors.primaryBlue.opacity(0.5), radius: 20, x: 0, y: 0)
        .shadow(color: Theme.Colors.primaryBlue.opacity(0.3), radius: 40, x: 0, y: 0)
        .shadow(color: Theme.Colors.primaryBlue.opacity(0.2), radius: 60, x: 0, y: 0)
    }

    private func firstParagraph(from text: String) -> String {
        text.components(separatedBy: "\n\n").first ?? text
    }
}

#Preview {
    NextStepCard(step: DataService.shared.getAuthoredSteps(for: "AAA")[0])
        .padding(.horizontal, 16)
        .background(Theme.Colors.background)
}
