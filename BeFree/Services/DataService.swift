//
//  DataService.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private init() {}
    
    // MARK: - Business Models
    
    func getBusinessModels() -> [BusinessModel] {
        return [
            BusinessModel(
                name: "Social Media Marketing Agency",
                shortName: "SMMA",
                description: "Help local businesses grow their online presence through social media management and advertising.",
                icon: "chart.line.uptrend.xyaxis",
                benefits: [
                    "Low startup cost (€0–€100)",
                    "High demand from businesses",
                    "Scalable service model",
                    "Learn valuable marketing skills"
                ]
            )
        ]
    }
    
    // MARK: - Foundation Steps
    
    func getFoundationSteps() -> [Step] {
        return [
            // Step 1 - Fully detailed
            Step(
                title: "Define Your Business Idea",
                description: "In this step, you'll learn how to identify and validate profitable business ideas.\n\nYou'll understand which niches are currently in demand, how to analyze your target audience, and how to ensure your idea has potential.\n\nBy the end of this step, you'll have a clear direction for your business and know exactly who you want to serve.",
                duration: 15,
                phase: .foundation,
                subtasks: [
                    "Watch the niche selection guide",
                    "Research 3-5 potential niches",
                    "Document your top choice",
                    "Write down why this niche excites you"
                ],
                resources: [
                    Resource(
                        title: "How to Choose a Profitable Niche for Your Agency",
                        type: .video,
                        url: "https://www.youtube.com/watch?v=mFiXhWo1r4s",
                        duration: "12 min"
                    ),
                    Resource(
                        title: "The Ultimate Guide to Finding Your Niche",
                        type: .article,
                        url: "https://www.hubspot.com/business-ideas",
                        duration: "8 min read"
                    ),
                    Resource(
                        title: "Niche Selection Worksheet",
                        type: .template,
                        url: "https://www.notion.so/templates/niche-research",
                        duration: nil
                    )
                ]
            ),
            
            // Step 2 - Fully detailed
            Step(
                title: "Analyze Target Audience",
                description: "Understanding your target audience is crucial for building a successful SMMA business.\n\nIn this step, you'll learn how to identify your ideal client, understand their pain points, and discover where they spend their time online.\n\nYou'll create a detailed audience profile that will guide all your future marketing decisions. This clarity will make every aspect of your business—from pricing to marketing—much more effective.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Define your ideal client demographics",
                    "List their top 3 pain points",
                    "Identify where they spend time online",
                    "Document their buying behavior patterns"
                ],
                resources: [
                    Resource(
                        title: "How to Define Your Target Audience",
                        type: .video,
                        url: "https://www.youtube.com/watch?v=jpXGYHjL5ck",
                        duration: "15 min"
                    ),
                    Resource(
                        title: "Customer Avatar Complete Guide",
                        type: .article,
                        url: "https://www.digitalmarketer.com/customer-avatar-worksheet/",
                        duration: "10 min read"
                    ),
                    Resource(
                        title: "Audience Research Template",
                        type: .template,
                        url: "https://www.notion.so/templates/target-audience",
                        duration: nil
                    ),
                    Resource(
                        title: "Understanding Customer Pain Points",
                        type: .article,
                        url: "https://blog.hubspot.com/service/customer-pain-points",
                        duration: "7 min read"
                    )
                ]
            ),
            
            // Step 3 - Fully detailed
            Step(
                title: "Competitive Analysis",
                description: "Learn how to analyze your competition and find your unique positioning in the market.\n\nYou'll discover what other agencies are doing, identify gaps in the market, and learn how to differentiate your services.\n\nThis analysis will help you understand how to stand out and win clients. Instead of copying what everyone else does, you'll find your own unique angle that makes clients choose you over the competition.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Find and list 5-10 direct competitors",
                    "Analyze their services, pricing, and positioning",
                    "Identify market gaps and opportunities",
                    "Write your unique value proposition"
                ],
                resources: [
                    Resource(
                        title: "How to Do a Competitive Analysis",
                        type: .video,
                        url: "https://www.youtube.com/watch?v=3FxJRbVLQ7A",
                        duration: "18 min"
                    ),
                    Resource(
                        title: "Competitive Analysis Template",
                        type: .template,
                        url: "https://www.smartsheet.com/competitive-analysis-templates",
                        duration: nil
                    ),
                    Resource(
                        title: "Finding Your Competitive Advantage",
                        type: .article,
                        url: "https://www.entrepreneur.com/starting-a-business/how-to-identify-your-competitive-advantage/299920",
                        duration: "9 min read"
                    ),
                    Resource(
                        title: "SWOT Analysis Explained",
                        type: .video,
                        url: "https://www.youtube.com/watch?v=JXXHqM6RzZQ",
                        duration: "8 min"
                    )
                ]
            ),
            
            // Steps 4-10 - Placeholder content
            Step(
                title: "Create Value Proposition",
                description: "Craft a compelling value proposition that clearly communicates what makes your agency unique and why clients should choose you.",
                duration: 15,
                phase: .foundation,
                subtasks: [
                    "Identify your unique strengths",
                    "Write your value statement",
                    "Test with potential clients"
                ],
                resources: []
            ),
            
            Step(
                title: "Choose Your Primary Service",
                description: "Select the core service you'll offer to your first clients. Focus on one service to master it quickly.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research popular services",
                    "Match services to your skills",
                    "Define your service package"
                ],
                resources: []
            ),
            
            Step(
                title: "Build Simple Online Presence",
                description: "Create a professional online presence with a simple website or portfolio that showcases your services.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Set up social media profiles",
                    "Create a simple landing page",
                    "Prepare your bio and pitch"
                ],
                resources: []
            ),
            
            Step(
                title: "Create Portfolio Examples",
                description: "Build 3 portfolio examples that demonstrate your skills, even if you haven't had real clients yet.",
                duration: 45,
                phase: .foundation,
                subtasks: [
                    "Choose portfolio format",
                    "Create 3 sample projects",
                    "Write case study descriptions"
                ],
                resources: []
            ),
            
            Step(
                title: "Write Outreach Script",
                description: "Develop a proven outreach script that you can use to contact potential clients and book discovery calls.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Study successful examples",
                    "Write your script",
                    "Practice delivery"
                ],
                resources: []
            ),
            
            Step(
                title: "Build Prospect List",
                description: "Create a list of 50-100 potential clients who match your ideal customer profile.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Define search criteria",
                    "Research businesses",
                    "Organize in spreadsheet"
                ],
                resources: []
            ),
            
            Step(
                title: "Set Up Business Tools",
                description: "Get organized with essential tools for managing your agency including email, scheduling, and project management.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Set up professional email",
                    "Choose scheduling tool",
                    "Set up project management"
                ],
                resources: []
            )
        ]
    }
    
    // MARK: - First Actions Steps (Placeholder)
    
    func getFirstActionsSteps() -> [Step] {
        return [
            Step(
                title: "Send First Outreach Messages",
                description: "Start reaching out to potential clients using your outreach script.",
                duration: 30,
                phase: .firstActions,
                subtasks: [
                    "Send 10 messages per day",
                    "Track responses",
                    "Refine your approach"
                ],
                resources: []
            ),
            Step(
                title: "Book Discovery Calls",
                description: "Convert interested prospects into discovery calls where you can learn about their needs.",
                duration: 20,
                phase: .firstActions,
                subtasks: [
                    "Respond to inquiries",
                    "Schedule calls",
                    "Prepare questions"
                ],
                resources: []
            )
        ]
    }
}

