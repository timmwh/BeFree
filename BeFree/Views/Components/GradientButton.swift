//
//  GradientButton.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Primary gradient button with glow effect matching Figma design
struct GradientButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var isEnabled: Bool = true
    
    init(_ title: String, icon: String? = nil, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Gradient background
                Theme.Gradients.primaryButton
                    .cornerRadius(Theme.CornerRadius.md)
                
                // Shimmer overlay (optional animated effect)
                Theme.Gradients.shimmer
                    .cornerRadius(Theme.CornerRadius.md)
                
                // Content
                HStack(spacing: Theme.Spacing.sm) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: 20))
                    }
                    
                    Text(title)
                        .font(Theme.Typography.body)
                        .tracking(-0.3125)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
            }
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
        .primaryGlow() // Apply multi-layered glow effect
    }
}

#Preview {
    VStack(spacing: 20) {
        GradientButton("Complete Step", icon: "checkmark") {
            print("Button tapped")
        }
        
        GradientButton("View Your Roadmap →") {
            print("Roadmap tapped")
        }
        
        GradientButton("Disabled Button", isEnabled: false) {
            print("Shouldn't print")
        }
    }
    .padding()
    .background(Theme.Colors.background)
}

