//
//  CardContainer.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Base card container with optional pulsing gradient animation
struct CardContainer<Content: View>: View {
    let content: Content
    let padding: PaddingSize
    let animate: Bool
    
    enum PaddingSize {
        case sm, md, lg
        
        var value: CGFloat {
            switch self {
            case .sm: return Theme.Spacing.md
            case .md: return Theme.Spacing.lg
            case .lg: return Theme.Spacing.xl
            }
        }
    }
    
    init(padding: PaddingSize = .md, animate: Bool = false, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.animate = animate
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Background with optional animation gradient
            if animate {
                LinearGradient(
                    colors: [
                        Theme.Colors.primaryBlue.opacity(0.05),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .opacity(0.12)
            }
            
            // Content
            content
                .padding(padding.value)
        }
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.CornerRadius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        CardContainer(padding: .sm) {
            Text("Small padding card")
                .foregroundColor(Theme.Colors.textPrimary)
        }
        
        CardContainer(padding: .md, animate: true) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Animated Card")
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                Text("Base card with pulsing gradient animation")
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
        }
        
        CardContainer(padding: .lg) {
            Text("Large padding card")
                .foregroundColor(Theme.Colors.textPrimary)
        }
    }
    .padding()
    .background(Theme.Colors.background)
}

