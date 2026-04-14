//
//  RoadmapView.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import SwiftUI

struct RoadmapView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isFoundationExpanded = true
    @State private var isFirstActionsExpanded = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Roadmap")
                            .font(Theme.Typography.largeTitle)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        Text("Follow these steps to build your business")
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                    .padding(.top, Theme.Spacing.md)
                    
                    // Overall Progress Card
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        HStack {
                            Text("Overall Progress")
                                .font(Theme.Typography.title3)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            Spacer()
                            
                            Text("\(viewModel.completedStepsCount)/\(viewModel.totalStepsCount)")
                                .font(Theme.Typography.title2)
                                .foregroundColor(Theme.Colors.primaryBlue)
                        }
                        
                        // Progress Bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.sm)
                                    .fill(Theme.Colors.divider)
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.sm)
                                    .fill(
                                        LinearGradient(
                                            colors: [Theme.Colors.primaryBlue, Theme.Colors.secondaryBlue],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(
                                        width: geometry.size.width * (Double(viewModel.completedStepsCount) / Double(viewModel.totalStepsCount)),
                                        height: 8
                                    )
                            }
                        }
                        .frame(height: 8)
                        
                        Text("\(viewModel.progressPercentage)% completed")
                            .font(Theme.Typography.callout)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                    .padding(Theme.Spacing.lg)
                    .background(Theme.Colors.cardBackground)
                    .cornerRadius(Theme.CornerRadius.lg)
                    
                    // Foundation Phase
                    PhaseSection(
                        title: "Foundation",
                        subtitle: "Build the groundwork for your business",
                        steps: viewModel.foundationSteps,
                        isExpanded: $isFoundationExpanded,
                        isLocked: false
                    )
                    
                    // First Actions Phase
                    PhaseSection(
                        title: "First Actions",
                        subtitle: "Take your first steps in the market",
                        steps: viewModel.firstActionsSteps,
                        isExpanded: $isFirstActionsExpanded,
                        isLocked: false
                    )
                    
                    // Growth Phase (Locked)
                    LockedPhaseSection(
                        title: "Growth",
                        subtitle: "Scale your business to the next level"
                    )
                    
                    // Scale Phase (Locked)
                    LockedPhaseSection(
                        title: "Scale",
                        subtitle: "Master advanced strategies"
                    )
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.bottom, Theme.Spacing.xl)
            }
            .background(Theme.Colors.background)
        }
    }
}

// MARK: - Phase Section Component

struct PhaseSection: View {
    let title: String
    let subtitle: String
    let steps: [Step]
    @Binding var isExpanded: Bool
    let isLocked: Bool
    
    var completedCount: Int {
        steps.filter { $0.isCompleted }.count
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            // Phase Header
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(Theme.Typography.title3)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        Text(subtitle)
                            .font(Theme.Typography.footnote)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                    
                    Spacer()
                    
                    if !steps.isEmpty {
                        Text("\(completedCount)/\(steps.count)")
                            .font(Theme.Typography.callout)
                            .foregroundColor(Theme.Colors.primaryBlue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Theme.Colors.primaryBlue.opacity(0.2))
                            .cornerRadius(Theme.CornerRadius.sm)
                    }
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.cardBackground)
                .cornerRadius(Theme.CornerRadius.lg)
            }
            
            // Steps List
            if isExpanded && !steps.isEmpty {
                VStack(spacing: Theme.Spacing.sm) {
                    ForEach(steps) { step in
                        NavigationLink(destination: StepDetailView(step: step)) {
                            StepCard(step: step) { }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Locked Phase Section Component

struct LockedPhaseSection: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Theme.Typography.title3)
                    .foregroundColor(Theme.Colors.textSecondary)
                
                Text(subtitle)
                    .font(Theme.Typography.footnote)
                    .foregroundColor(Theme.Colors.textTertiary)
            }
            
            Spacer()
            
            HStack(spacing: 6) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 12))
                Text("Coming Soon")
                    .font(Theme.Typography.caption)
            }
            .foregroundColor(Theme.Colors.textTertiary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Theme.Colors.divider)
            .cornerRadius(Theme.CornerRadius.sm)
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.cardBackground.opacity(0.5))
        .cornerRadius(Theme.CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.lg)
                .stroke(Theme.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview {
    RoadmapView()
        .environmentObject(AppViewModel())
}

