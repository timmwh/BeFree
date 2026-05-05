//
//  Theme.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct Theme {
    // MARK: - Colors
    /// Core color palette extracted from Figma Design System
    struct Colors {
        // MARK: Base Colors
        /// Main app background (#0a0a0f) - Used for screens and main containers
        static let background = Color(hex: "0a0a0f")

        /// Card and component background (#13131a) - Used for cards, dialogs, and elevated surfaces
        static let cardBackground = Color(hex: "13131a")

        /// Muted card background (#13131a @ 50%) - Figma "transparent card" look
        static let cardBackgroundMuted = Color(hex: "13131a").opacity(0.5)

        // MARK: Primary Colors
        /// Primary blue (#3b82f6) - Used for primary actions, gradients, and highlights
        static let primaryBlue = Color(hex: "3b82f6")

        /// Secondary blue (#60a5fa) - Used for gradient ends and hover states
        static let secondaryBlue = Color(hex: "60a5fa")

        /// Primary blue with opacity - Used for icon containers and subtle backgrounds
        static let primaryBlueOpacity = Color(hex: "3b82f6").opacity(0.2)

        // MARK: Text Colors
        /// Primary text color (#e8e8f0) - Used for headings and important text
        static let textPrimary = Color(hex: "e8e8f0")

        /// Secondary text color (#8b8b9a) - Used for descriptions and secondary information
        static let textSecondary = Color(hex: "8b8b9a")

        /// Tertiary text color - Used for disabled states and subtle text
        static let textTertiary = Color(hex: "8b8b9a").opacity(0.6)

        /// Text with 90% opacity - Used for body text on cards
        static let textPrimaryOpacity = Color(hex: "e8e8f0").opacity(0.9)

        // MARK: Border & Divider
        /// Border color (#252530) - Used for card borders and dividers
        static let border = Color(hex: "252530")

        /// Border with opacity - Used for subtle borders
        static let borderOpacity = Color(hex: "252530").opacity(0.5)

        /// Lighter border for dividers
        static let divider = Color(hex: "252530").opacity(0.3)

        // MARK: Phase Colors (final 5-phase spine from Figma)
        // Each phase: base color + `.opacity(0.2)` bg variant + `.opacity(0.4)` border variant.

        /// Foundation phase - Blue (#3b82f6)
        static let phaseFoundation = Color(hex: "3b82f6")
        static let phaseFoundationBg = Color(hex: "3b82f6").opacity(0.2)
        static let phaseFoundationBorder = Color(hex: "3b82f6").opacity(0.4)

        /// Setup phase - Cyan (#06b6d4)
        static let phaseSetup = Color(hex: "06b6d4")
        static let phaseSetupBg = Color(hex: "06b6d4").opacity(0.2)
        static let phaseSetupBorder = Color(hex: "06b6d4").opacity(0.4)

        /// Position phase - Purple (#a855f7)
        static let phasePosition = Color(hex: "a855f7")
        static let phasePositionBg = Color(hex: "a855f7").opacity(0.2)
        static let phasePositionBorder = Color(hex: "a855f7").opacity(0.4)

        /// Launch phase - Amber (#f59e0b)
        static let phaseLaunch = Color(hex: "f59e0b")
        static let phaseLaunchBg = Color(hex: "f59e0b").opacity(0.2)
        static let phaseLaunchBorder = Color(hex: "f59e0b").opacity(0.4)

        /// Scale phase - Green (#05df72)
        static let phaseScale = Color(hex: "05df72")
        static let phaseScaleBg = Color(hex: "05df72").opacity(0.2)
        static let phaseScaleBorder = Color(hex: "05df72").opacity(0.4)

        // MARK: Status Colors
        /// Success state - Green
        static let success = Color(hex: "05df72")
        static let successBg = Color(hex: "00c950").opacity(0.2)
        static let successBorder = Color(hex: "00c950").opacity(0.3)

        /// Warning state - Yellow
        static let warning = Color(hex: "fdc700")
        static let warningBg = Color(hex: "f0b100").opacity(0.2)
        static let warningBorder = Color(hex: "f0b100").opacity(0.3)

        /// Error state - Red
        static let error = Color(hex: "ff6467")
        static let errorBg = Color(hex: "fb2c36").opacity(0.2)
        static let errorBorder = Color(hex: "fb2c36").opacity(0.3)
    }

    // MARK: - Typography
    /// Typography system using Inter font family (static TTF cuts; PostScript names from Inter 4.1).
    struct Typography {
        /// PostScript names bundled in `Fonts/*.ttf` — do not use `.weight()` on these (see UIKit descriptor logs).
        private enum Inter {
            static let regular = "Inter-Regular"
            static let medium = "Inter-Medium"
            static let semiBold = "Inter-SemiBold"
            static let bold = "Inter-Bold"
        }

        // MARK: Display & Headings
        /// Large heading (32px) - Used for page titles
        static let heading1 = Font.custom(Inter.regular, size: 32)

        /// Dashboard brand wordmark “BeFree” (Figma 2042:3885 — 30pt Regular, tracking in layout).
        static let dashboardBrand = Font.custom(Inter.regular, size: 30)

        /// Large percentage in Dashboard progress card (Figma 2042:3965 — 32pt Regular).
        static let progressPercent = Font.custom(Inter.regular, size: 32)

        /// Medium heading (24px) - Used for section titles
        static let heading2 = Font.custom(Inter.regular, size: 24)

        /// Small heading (20px) - Used for card titles
        static let heading3 = Font.custom(Inter.regular, size: 20)

        // MARK: Body Text
        /// Standard body text (16px) - Main content text
        static let body = Font.custom(Inter.regular, size: 16)
        static let bodyMedium = Font.custom(Inter.medium, size: 16)
        static let bodySemiBold = Font.custom(Inter.semiBold, size: 16)
        static let bodyBold = Font.custom(Inter.semiBold, size: 16) // Alias for compatibility

        // MARK: Small Text
        /// Caption text (14px) - Used for labels and descriptions
        static let caption = Font.custom(Inter.regular, size: 14)

        /// Small text (12px) - Used for badges and tiny labels
        static let small = Font.custom(Inter.regular, size: 12)
        static let smallMedium = Font.custom(Inter.medium, size: 12)

        /// Bottom tab labels (Figma 2042:3972 — Inter 9 / leading 12)
        static let tabLabel = Font.custom(Inter.regular, size: 9)

        // MARK: Onboarding
        static let onboardingLogoMark = Font.custom(Inter.semiBold, size: 44)
        static let onboardingTagline = Font.custom(Inter.semiBold, size: 22)
        static let onboardingQuestionTitle = Font.custom(Inter.bold, size: 30)
        static let onboardingConfirmationTitle = Font.custom(Inter.semiBold, size: 36)

        // MARK: Legacy Compatibility
        /// Legacy names for backward compatibility with existing views
        static let largeTitle = Font.system(size: 34, weight: .bold)
        static let title1 = Font.system(size: 28, weight: .bold)
        static let title2 = Font.system(size: 22, weight: .bold)
        static let title3 = Font.system(size: 20, weight: .semibold)
        static let callout = Font.system(size: 16, weight: .regular)
        static let subheadline = Font.system(size: 15, weight: .regular)
        static let footnote = Font.system(size: 13, weight: .regular)
        static let caption2 = Font.system(size: 11, weight: .regular)

        // MARK: Fallback System Fonts
        /// Fallback if Inter is not available
        static let systemHeading1 = Font.system(size: 32, weight: .regular)
        static let systemHeading2 = Font.system(size: 24, weight: .regular)
        static let systemBody = Font.system(size: 16, weight: .regular)
        static let systemCaption = Font.system(size: 14, weight: .regular)
        static let systemSmall = Font.system(size: 12, weight: .regular)
    }

    // MARK: - Spacing
    /// Consistent spacing system for margins and paddings
    struct Spacing {
        static let xs: CGFloat = 4      // Tight spacing
        static let sm: CGFloat = 8      // Small spacing
        static let md: CGFloat = 12     // Medium spacing (between elements)
        static let lg: CGFloat = 16     // Large spacing (card padding)
        static let xl: CGFloat = 20     // Extra large spacing
        static let xxl: CGFloat = 24    // Section spacing
        static let xxxl: CGFloat = 48   // Major section spacing
    }

    // MARK: - Tab bar (Figma 2042:3971 / 2042:3972 — Main Frames V2)
    /// Floating pill tab bar; values from Dev Mode export (node `2042:3972` inner layout).
    struct TabBar {
        static let cornerRadius: CGFloat = 24
        static let selectedCornerRadius: CGFloat = 18
        /// Insets of icon+label+highlight stack inside the pill.
        static let horizontalPadding: CGFloat = 8
        /// Figma: ~8 top, ~9.2 bottom in a 64.23pt-tall bar; average ≈8.
        static let verticalPadding: CGFloat = 8
        static let borderLineWidth: CGFloat = 0.633
        /// Slightly stronger than 0.08 so the bar edge reads when the fill matches the screen.
        static let borderWhiteOpacity: CGFloat = 0.10
        static let outerShadowRadius: CGFloat = 32
        static let outerShadowY: CGFloat = 8
        static let outerDropShadowOpacity: CGFloat = 0.18
        static let iconSize: CGFloat = 20
        /// Icon baseline → label (Figma ~2.5pt from icon bottom to `top-[28.98]`)
        static let iconLabelSpacing: CGFloat = 2.5
        /// Button row / selected pill height in spec.
        static let tabRowHeight: CGFloat = 46.979
        /// Outer width of the bar container in Figma (w-[353.811]).
        static let pillOuterWidth: CGFloat = 353.811
        /// Gaps between fixed-width tab columns (Figma: ~48.15 between adjacent highlights).
        static let columnGap: CGFloat = 48.15
        /// Sum of three pill widths + two gaps (used to scale when inner width is tight).
        static var naturalRowWidth: CGFloat {
            selectedPillWidthStart + columnGap + selectedPillWidthRoadmap + columnGap + selectedPillWidthProfile
        }
        /// Figma: selected highlight widths (Start, Roadmap, Profile) — not full flex column width.
        static let selectedPillWidthStart: CGFloat = 57
        static let selectedPillWidthRoadmap: CGFloat = 76.092
        static let selectedPillWidthProfile: CGFloat = 63.024
        /// Selected state outer glow (Figma `0 0 24` @ 0.3) — use slightly lower radius/opacity in Swift to avoid bloom.
        static let selectedGlowRadius: CGFloat = 14
        static let selectedGlowOpacity: Double = 0.15
        static let selectedFillPrimaryOpacity: CGFloat = 0.12
        static let selectedFillSecondaryOpacity: CGFloat = 0.07
        /// Screen insets for the whole floating bar (Tab section `px-20` in 2042:3971).
        static let barHorizontalScreenInset: CGFloat = 20
        /// Sits the pill closer to the home indicator; tune vs Figma frame 2042:3869.
        static let barBottomInset: CGFloat = -22   // safe_area(≈34) + (-22) = 12 pt visible gap
        /// Shell is **blur only** in code (Figma: transparent + backdrop blur); no separate fill.
        /// Total scroll clearance under floating bar (bar + screen insets + safe home).
        static let bottomClearanceTotal: CGFloat = 68
    }

    // MARK: - Dashboard Layout
    // Figma `2042:3869` (Dashboard / Main) + `2042:3874` (padded content container, Dev Mode).
    // Fractions rounded up to whole points (e.g. 15.996 → 16, 31.992 → 32, 101.239 → 102).
    // Dynamic Type may reflow; sizes match Figma at the default size class.
    struct DashboardLayout {
        // Screen edges (2042:3874)
        static let horizontalInset: CGFloat = 16
        static let topInset: CGFloat = 15
        static let sectionSpacing: CGFloat = 32
        static let sectionHeaderSpacing: CGFloat = 12

        // Brand + streak pill (2042:3875–3886)
        static let logoToWordmarkGap: CGFloat = 12
        static let beFreeTitleTracking: CGFloat = -0.31
        static let streakPillHeight: CGFloat = 42
        static let streakPillHorizontalPadding: CGFloat = 17
        static let streakPillVerticalPadding: CGFloat = 9
        static let streakPillIconToNumberGap: CGFloat = 8

        // Streak row (2042:3891)
        static let streakCardHeight: CGFloat = 102
        static let streakCardCornerRadius: CGFloat = 16
        static let streakColumnSpacing: CGFloat = 12
        static let streakDayLabelSpacing: CGFloat = 8
        static let streakInnerPadding: CGFloat = 17
        static let streakCircleSize: CGFloat = 44
        static let streakTodayRingSize: CGFloat = 51
        static let streakTodayRingBorder: CGFloat = 2.2
        static let streakTodayInnerDot: CGFloat = 15
        static let streakTodayRingShadow: CGFloat = 9

        // Next step card (2042:3933, 2042:3938–43)
        static let nextStepTitleToBody: CGFloat = 12
        /// Figma 2042:3942 body: ~26px line on 16pt — extra space between wrapped lines.
        static let nextStepBodyLineExtra: CGFloat = 6
        static let nextStepLabelIconSize: CGFloat = 16
        static let nextStepLabelIconGap: CGFloat = 8

        // Progress (2042:3949, 2042:3963–70)
        static let progressHeaderHorizontalInset: CGFloat = 4
        static let progressPercentToBarSpacing: CGFloat = 16
        static let progressBarToCaptionSpacing: CGFloat = 12
        static let progressBarHeight: CGFloat = 12
        static let progressPercentLineHeight: CGFloat = 48
        static let progressPercentTracking: CGFloat = 0.41
        static let roadmapRowChevronSize: CGFloat = 12

        static let cardInnerPadding: CGFloat = 24
        static let ctaHeight: CGFloat = 56

        // Section label — both headers (Figma: Next Step + Progress ~0.55, Roadmap “chevron” row)
        static let sectionLabelIconSize: CGFloat = 16
        static let sectionLabelIconGap: CGFloat = 8
        static let sectionLabelTracking: CGFloat = 0.55

        // ── Rebuild tokens (Dashboard v2) ──────────────────────────────────────────────────────

        /// Negative horizontal padding applied to the streak card to bleed edge-to-edge (Figma left:-16).
        static let streakEdgeBleed: CGFloat = -16

        /// Minimum height for the Next Step card; grows for long content or large Dynamic Type.
        static let nextStepCardMinHeight: CGFloat = 252

        /// Minimum height for the progress card.
        static let progressCardMinHeight: CGFloat = 158

        // Next Step card decorative bokeh dots (Figma 2042:3935–3937).
        // Positions are (x, y) offsets from the card's top-leading corner.
        static let bokeh1X: CGFloat = 108
        static let bokeh1Y: CGFloat = 48
        static let bokeh1Size: CGFloat = 8
        static let bokeh1Opacity: CGFloat = 0.31
        static let bokeh2X: CGFloat = 180
        static let bokeh2Y: CGFloat = 81
        static let bokeh2Size: CGFloat = 9          // 8.514 → 9
        static let bokeh2Opacity: CGFloat = 0.35
        static let bokeh3X: CGFloat = 252
        static let bokeh3Y: CGFloat = 124
        static let bokeh3Size: CGFloat = 8
        static let bokeh3Opacity: CGFloat = 0.30
        static let bokehBlur: CGFloat = 8
    }

    // MARK: - Corner Radius
    /// Border radius values for different component sizes
    struct CornerRadius {
        static let sm: CGFloat = 12     // Small elements
        static let md: CGFloat = 16     // Buttons and medium cards
        static let lg: CGFloat = 20     // Icon containers
        static let xl: CGFloat = 24     // Large cards
        static let pill: CGFloat = 999  // Fully rounded (badges, pills)
    }

    // MARK: - Shadows
    /// Shadow and glow effects for elevated components
    struct Shadow {
        /// Primary button glow effect - Multi-layered blue glow
        static let primaryGlow = [
            ShadowLayer(color: Color(hex: "3b82f6").opacity(0.5), radius: 20, x: 0, y: 0),
            ShadowLayer(color: Color(hex: "3b82f6").opacity(0.3), radius: 40, x: 0, y: 0),
            ShadowLayer(color: Color(hex: "3b82f6").opacity(0.2), radius: 60, x: 0, y: 0)
        ]

        /// Subtle glow for badges and small elements
        static let subtleGlow = [
            ShadowLayer(color: Color(hex: "3b82f6").opacity(0.4), radius: 20, x: 0, y: 0)
        ]
    }

    // MARK: - Gradients
    /// Gradient definitions for backgrounds and buttons
    struct Gradients {
        /// Primary button gradient - Blue gradient from top to bottom
        static let primaryButton = LinearGradient(
            colors: [Colors.primaryBlue, Colors.secondaryBlue],
            startPoint: .top,
            endPoint: .bottom
        )

        /// Shimmer overlay effect for buttons
        static let shimmer = LinearGradient(
            colors: [Color.clear, Color.white.opacity(0.2), Color.clear],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

// MARK: - Helper Types
/// Shadow layer for complex shadow effects
struct ShadowLayer {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

// MARK: - View Extensions
extension View {
    /// Applies primary glow effect (multi-layered)
    func primaryGlow() -> some View {
        self
            .shadow(color: Color(hex: "3b82f6").opacity(0.5), radius: 20, x: 0, y: 0)
            .shadow(color: Color(hex: "3b82f6").opacity(0.3), radius: 40, x: 0, y: 0)
            .shadow(color: Color(hex: "3b82f6").opacity(0.2), radius: 60, x: 0, y: 0)
    }

    /// Applies subtle glow effect
    func subtleGlow() -> some View {
        self.shadow(color: Color(hex: "3b82f6").opacity(0.4), radius: 20, x: 0, y: 0)
    }
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

