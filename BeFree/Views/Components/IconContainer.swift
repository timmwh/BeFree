//
//  IconContainer.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Icon container with background - Used across multiple components
struct IconContainer: View {
    let icon: String
    let size: IconSize
    let style: IconStyle
    
    enum IconSize {
        case small      // 20x20 container, 12x12 icon
        case medium     // 44x44 container, 20x20 icon
        case large      // 48x48 container, 20x20 icon
        
        var containerSize: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 44
            case .large: return 48
            }
        }
        
        var iconSize: CGFloat {
            switch self {
            case .small: return 12
            case .medium: return 20
            case .large: return 20
            }
        }
    }
    
    enum IconStyle {
        case blue               // Blue background with opacity
        case blueGradient       // Blue gradient with glow
        case ghost              // No background
        case dark               // Dark background with border
        
        var backgroundColor: Color {
            switch self {
            case .blue: return Theme.Colors.primaryBlueOpacity
            case .blueGradient: return .clear
            case .ghost: return .clear
            case .dark: return Theme.Colors.cardBackground
            }
        }
    }
    
    init(icon: String, size: IconSize = .medium, style: IconStyle = .blue) {
        self.icon = icon
        self.size = size
        self.style = style
    }
    
    var body: some View {
        ZStack {
            if style == .blueGradient {
                Theme.Gradients.primaryButton
            } else {
                style.backgroundColor
            }
            
            Image(systemName: icon)
                .font(.system(size: size.iconSize))
                .foregroundColor(style == .dark ? Theme.Colors.textSecondary : .white)
        }
        .frame(width: size.containerSize, height: size.containerSize)
        .cornerRadius(Theme.CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                .stroke(Theme.Colors.borderOpacity, lineWidth: style == .dark ? 0.633 : 0)
        )
        .if(style == .blueGradient) { view in
            view.subtleGlow()
        }
    }
}

// MARK: - Helper Extension
extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            IconContainer(icon: "star.fill", size: .medium, style: .blue)
            IconContainer(icon: "flame.fill", size: .medium, style: .blueGradient)
            IconContainer(icon: "chart.line.uptrend.xyaxis", size: .medium, style: .ghost)
            IconContainer(icon: "arrow.left", size: .medium, style: .dark)
        }
        
        HStack(spacing: 16) {
            IconContainer(icon: "bell.fill", size: .small, style: .blue)
            IconContainer(icon: "heart.fill", size: .large, style: .blueGradient)
        }
    }
    .padding()
    .background(Theme.Colors.background)
}

