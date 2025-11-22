//
//  BackButton.swift
//  BeFree
//
//  Created by AI Assistant on 22.11.25.
//

import SwiftUI

/// Standardized back navigation button
struct BackButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            IconContainer(icon: "arrow.left", size: .medium, style: .dark)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack {
            BackButton {
                print("Back tapped")
            }
            Spacer()
        }
        
        Spacer()
    }
    .padding()
    .background(Theme.Colors.background)
}

