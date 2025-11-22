//
//  ResourceCard.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct ResourceCard: View {
    let resource: Resource
    let showNewBadge: Bool
    
    init(resource: Resource, showNewBadge: Bool = false) {
        self.resource = resource
        self.showNewBadge = showNewBadge
    }
    
    private var iconName: String {
        switch resource.type {
        case .video:
            return "play.circle.fill"
        case .article:
            return "doc.text.fill"
        case .template:
            return "doc.on.doc.fill"
        }
    }
    
    var body: some View {
        Link(destination: URL(string: resource.url)!) {
            ZStack(alignment: .topTrailing) {
                HStack(spacing: Theme.Spacing.md) {
                    // Icon container
                    IconContainer(icon: iconName, size: .large, style: .blue)
                    
                    // Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(resource.title)
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .tracking(-0.3125)
                            .multilineTextAlignment(.leading)
                        
                        if let duration = resource.duration {
                            Text(duration)
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .tracking(-0.1504)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 20))
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                .padding(Theme.Spacing.xl)
                .background(Theme.Colors.cardBackground)
                .cornerRadius(Theme.CornerRadius.xl)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                        .stroke(Theme.Colors.borderOpacity, lineWidth: 0.633)
                )
                
                // New badge
                if showNewBadge {
                    NewBadge()
                        .offset(x: -8, y: -8)
                }
            }
        }
    }
}

