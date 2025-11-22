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
        
        // MARK: Phase Colors
        /// Setup phase - Blue (#51a2ff)
        static let phaseSetup = Color(hex: "51a2ff")
        static let phaseSetupBg = Color(hex: "2b7fff").opacity(0.2)
        static let phaseSetupBorder = Color(hex: "2b7fff").opacity(0.3)
        
        /// Action phase - Yellow (#fdc700)
        static let phaseAction = Color(hex: "fdc700")
        static let phaseActionBg = Color(hex: "f0b100").opacity(0.2)
        static let phaseActionBorder = Color(hex: "f0b100").opacity(0.3)
        
        /// Growth phase - Green (#05df72)
        static let phaseGrowth = Color(hex: "05df72")
        static let phaseGrowthBg = Color(hex: "00c950").opacity(0.2)
        static let phaseGrowthBorder = Color(hex: "00c950").opacity(0.3)
        
        /// Scale phase - Purple (#c27aff)
        static let phaseScale = Color(hex: "c27aff")
        static let phaseScaleBg = Color(hex: "ad46ff").opacity(0.2)
        static let phaseScaleBorder = Color(hex: "ad46ff").opacity(0.3)
        
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
    /// Typography system using Inter font family
    struct Typography {
        // MARK: Display & Headings
        /// Large heading (32px) - Used for page titles
        static let heading1 = Font.custom("Inter", size: 32).weight(.regular)
        
        /// Medium heading (24px) - Used for section titles
        static let heading2 = Font.custom("Inter", size: 24).weight(.regular)
        
        /// Small heading (20px) - Used for card titles
        static let heading3 = Font.custom("Inter", size: 20).weight(.regular)
        
        // MARK: Body Text
        /// Standard body text (16px) - Main content text
        static let body = Font.custom("Inter", size: 16).weight(.regular)
        static let bodyMedium = Font.custom("Inter", size: 16).weight(.medium)
        static let bodySemiBold = Font.custom("Inter", size: 16).weight(.semibold)
        static let bodyBold = Font.custom("Inter", size: 16).weight(.semibold) // Alias for compatibility
        
        // MARK: Small Text
        /// Caption text (14px) - Used for labels and descriptions
        static let caption = Font.custom("Inter", size: 14).weight(.regular)
        
        /// Small text (12px) - Used for badges and tiny labels
        static let small = Font.custom("Inter", size: 12).weight(.regular)
        static let smallMedium = Font.custom("Inter", size: 12).weight(.medium)
        
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

