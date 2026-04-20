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
                name: "AI Automation Agency",
                shortName: "AAA",
                description: "Build custom AI-powered automations and workflows that save businesses time and money.",
                icon: "sparkles",
                benefits: [
                    "Cutting-edge technology",
                    "Premium pricing justified",
                    "Huge market demand in 2026",
                    "Low competition vs. traditional agencies"
                ]
            ),
            BusinessModel(
                name: "TikTok Shop Affiliate",
                shortName: "TikTok Shop",
                description: "Earn commissions by creating short videos for products on TikTok Shop — no inventory, no startup capital, just content.",
                icon: "play.rectangle.fill",
                benefits: [
                    "Zero startup capital required",
                    "First commission possible within days",
                    "Huge and growing platform demand",
                    "No product or shipping to manage"
                ]
            )
        ]
    }

    // MARK: - Authored Steps
    //
    // All steps authored for the MVP across the 4 active phases
    // (Foundation / Setup / Position / Launch). The Scale phase has no
    // authored steps in the MVP — "Ongoing after Launch" on the roadmap.
    //
    // Order matters: the returned array defines the canonical step sequence
    // used by the "Step X/Y" header counter and the Dashboard "Next Step" card.

    func getAuthoredSteps(for modelShortName: String = "AAA") -> [Step] {
        switch modelShortName {
        case "TikTok Shop": return authoredSteps_TikTokShop()
        default:            return authoredSteps_AAA()
        }
    }
}

private enum PlaceholderVideoID {
    static let aaa = "5TxSqvPbnWw"
    static let tikTokShop = "oXDFPigXAqQ"
}

/// Stable IDs so completed steps persist across launches (per-model authored IDs differ; Launch-phase shared IDs are shared across models).
private enum StepID {
    // AAA
    static let aaaUnderstand   = UUID(uuidString: "53981516-17e3-4afa-bb93-56be4a78a00c")!
    static let aaaChooseNiche  = UUID(uuidString: "e002c70d-705e-4325-8e18-02c56d59963f")!
    static let aaaAudience     = UUID(uuidString: "7ecba634-fddc-41c3-8e32-683afa8c83e0")!
    static let aaaValidate     = UUID(uuidString: "c0dad3b4-3357-4ce7-8c7e-bf9b0bab4cbd")!
    static let aaaValueProp    = UUID(uuidString: "cb5c2014-8c26-4b0a-9c7c-ff7d345fa852")!
    static let aaaService      = UUID(uuidString: "b598aebf-64b2-4afe-b913-65bafd11dfcd")!
    static let aaaPresence     = UUID(uuidString: "97a4808b-5d33-42a0-9922-6bb97c822581")!
    static let aaaPortfolio    = UUID(uuidString: "aa2c6307-e463-4d71-9077-04091ea35b0a")!
    static let aaaOutreach     = UUID(uuidString: "cbe53c57-f6ab-4c92-a11e-21853cc56576")!
    static let aaaProspects    = UUID(uuidString: "b447e9d6-e9c2-4eb2-9123-930ce18ec4a2")!

    // TikTok Shop
    static let ttsUnderstand   = UUID(uuidString: "9a452ac2-6f42-4b0d-805a-6f31cb5b4982")!
    static let ttsAccount      = UUID(uuidString: "29fddd85-ef82-495a-aa2f-f2a0573f0e78")!
    static let ttsNiche        = UUID(uuidString: "1e582923-965c-446e-b189-708d1cbcd6cd")!
    static let ttsAnalyze      = UUID(uuidString: "252891e5-37be-48ab-87d0-03ca1a348310")!
    static let ttsTestVideo    = UUID(uuidString: "89b278ff-205d-446d-99d5-e6c8a4d300ab")!
    static let ttsAlgorithm    = UUID(uuidString: "576a37ed-bda1-4a29-8fe6-90981bec0871")!
    static let ttsCadence      = UUID(uuidString: "2eae6265-a6f8-4b39-981c-6ce40a89643c")!
    static let ttsOptimize     = UUID(uuidString: "256b97ae-5db8-4e92-b987-c7b204275a64")!
    static let ttsScaleContent = UUID(uuidString: "c953f0a3-ad0c-4c60-8c1f-f29f4bd18945")!
    static let ttsPipeline     = UUID(uuidString: "99302990-db3f-4b17-b4c6-78b50453b741")!

    // Shared Launch-phase steps (kept identical across models so progress is shared).
    static let launchSendOutreach = UUID(uuidString: "8a00ed0b-e330-47f6-8f67-fa71c30f58f2")!
    static let launchBookCall     = UUID(uuidString: "f5ca4243-edfe-4fcd-a6d8-1b5a73aa79ac")!
}

// MARK: - AAA Authored Steps (Foundation → Setup → Position → Launch)

private extension DataService {
    func authoredSteps_AAA() -> [Step] {
        return [
            // Foundation (2)
            Step(
                id: StepID.aaaUnderstand,
                title: "Understand the Business Model",
                description: "After watching the video, write a one-paragraph summary in your own words explaining what an AAA does, how it makes money, and why businesses pay for automation.",
                duration: 20,
                phase: .foundation,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "How an AAA differs from traditional agencies",
                    "The tools used: Make, n8n, Zapier + AI APIs",
                    "How pricing works: project-based vs. retainers"
                ],
                expectedOutput: "A written one-paragraph summary of the AAA business model in your own words."
            ),
            Step(
                id: StepID.aaaChooseNiche,
                title: "Choose Your Niche",
                description: "Research 5 industries where businesses have obvious manual, repetitive workflows. Score each by pain intensity and budget. Pick one niche and commit.",
                duration: 20,
                phase: .foundation,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "Which niches have the highest demand for automation",
                    "How to evaluate if a niche has budget",
                    "Why specialization beats being a generalist"
                ],
                expectedOutput: "One chosen niche with 3 reasons why it's the right fit for you."
            ),

            // Position (4)
            Step(
                id: StepID.aaaAudience,
                title: "Analyze Your Target Audience",
                description: "Define your ideal client: their business size, team structure, and tech stack. List their top 3 most painful manual workflows and what tools they currently use.",
                duration: 25,
                phase: .position,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "What a typical AAA client looks like",
                    "How to identify their most painful workflows",
                    "What makes them ready to hire an automation agency"
                ],
                expectedOutput: "A written ideal client profile with their 3 biggest pain points."
            ),
            Step(
                id: StepID.aaaValidate,
                title: "Validate the Market",
                description: "Find 10+ businesses in your niche that are already paying for automation tools (Zapier, Make, HubSpot). Search job boards for automation-related roles. Confirm the market has budget.",
                duration: 25,
                phase: .position,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "What signals indicate a business will pay for automation",
                    "Where to find proof of budget (job boards, tool usage)",
                    "How to confirm the problem is urgent enough"
                ],
                expectedOutput: "A list of 10 businesses in your niche already spending on automation tools."
            ),
            Step(
                id: StepID.aaaValueProp,
                title: "Create Your Value Proposition",
                description: "Draft your value proposition using this format: \"I help [niche] save [X hours/week] by automating [specific workflow].\" Test it with 3 people — does it immediately make sense?",
                duration: 20,
                phase: .position,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "Why outcomes beat features in a value proposition",
                    "How to quantify time savings and ROI",
                    "Examples of value propositions that close deals"
                ],
                expectedOutput: "One clear, jargon-free value proposition sentence you can use in outreach."
            ),
            Step(
                id: StepID.aaaService,
                title: "Choose Your Primary Service",
                description: "Pick one automation type you can build and deliver in under 2 weeks. Define exactly what the client gets and what results they can expect.",
                duration: 20,
                phase: .position,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "The best starter services for AAA beginners",
                    "How to match services to your current skill level",
                    "How to define a clear, deliverable service package"
                ],
                expectedOutput: "A defined service package: what's included, how it's delivered, and the starting price."
            ),

            // Setup (2)
            Step(
                id: StepID.aaaPresence,
                title: "Build a Simple Online Presence",
                description: "Update your LinkedIn headline to reflect your AAA specialization. Post 1 piece of content about automation. Set up a simple one-page site or Notion page with your offer.",
                duration: 30,
                phase: .setup,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "Why LinkedIn is the primary channel for B2B services",
                    "What to include in your first automation-focused post",
                    "How to build a simple landing page in under 1 hour"
                ],
                expectedOutput: "An optimized LinkedIn profile and a published piece of content about automation."
            ),
            Step(
                id: StepID.aaaPortfolio,
                title: "Create 3 Portfolio Examples",
                description: "Build 3 real automations using free tiers of Make/n8n/Zapier + OpenAI. Record a short screen demo of each. Add them to your portfolio page.",
                duration: 45,
                phase: .setup,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "What types of demo automations impress prospects most",
                    "How to build a working prototype in under 2 hours",
                    "How to record and present a demo video"
                ],
                expectedOutput: "3 working automation demos with screen recordings added to your portfolio."
            ),

            // Launch (4) — 2 authored + 2 shared first-real-world-actions
            Step(
                id: StepID.aaaOutreach,
                title: "Write Your Outreach Script",
                description: "Write your outreach message using this format: specific observation about the prospect + automation idea + low-stakes offer. Create a follow-up message for non-responders.",
                duration: 25,
                phase: .launch,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "Why specific observations outperform generic pitches",
                    "The Observation–Idea–Offer message structure",
                    "When and how to follow up without being pushy"
                ],
                expectedOutput: "A ready-to-send outreach script + a follow-up message for non-responders."
            ),
            Step(
                id: StepID.aaaProspects,
                title: "Build Your First Prospect List",
                description: "Research 50+ businesses showing signs of manual, automatable workflows. Note the specific automation opportunity for each. Organize in a tracker.",
                duration: 30,
                phase: .launch,
                videoId: PlaceholderVideoID.aaa,
                watchNotes: [
                    "Where to find prospects (LinkedIn, Google, job boards)",
                    "What signals indicate a business needs automation",
                    "How to organize prospects for daily outreach"
                ],
                expectedOutput: "A prospect tracker with 50+ qualified businesses and a specific automation idea for each."
            ),
            sharedLaunchSendOutreach(),
            sharedLaunchBookCall()
        ]
    }
}

// MARK: - TikTok Shop Authored Steps (Foundation → Setup → Position → Launch)

private extension DataService {
    func authoredSteps_TikTokShop() -> [Step] {
        return [
            // Foundation (2)
            Step(
                id: StepID.ttsUnderstand,
                title: "Understand TikTok Shop Affiliate",
                description: "Open TikTok and browse the TikTok Shop tab. Find 1 creator already doing TikTok Shop affiliate in a niche you like. Note what product they promote and how many views their videos get.",
                duration: 15,
                phase: .foundation,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "How the TikTok Shop commission model works",
                    "The difference between affiliate and seller accounts",
                    "Why this model requires zero startup capital"
                ],
                expectedOutput: "A clear understanding of how TikTok Shop affiliate commissions work, with 1 real creator example saved."
            ),
            Step(
                id: StepID.ttsNiche,
                title: "Find Your Product Niche",
                description: "Browse the TikTok Shop marketplace. Check commission rates (aim for 10-30%+). Pick 1 niche you can talk about naturally. Find 3 specific products with 1,000+ units sold.",
                duration: 20,
                phase: .foundation,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "Which product categories have the highest commission rates",
                    "How to spot products with proven demand",
                    "Why authenticity matters more than product variety"
                ],
                expectedOutput: "1 chosen niche + 3 specific high-commission products you could promote."
            ),

            // Position (2)
            Step(
                id: StepID.ttsAnalyze,
                title: "Analyze Top Performing Creators",
                description: "Search TikTok for your niche + \"TikTok Shop\". Find 5 active creators. Watch their top 3 videos each. Write down the hook formula that appears most frequently.",
                duration: 25,
                phase: .position,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "What makes the first 3 seconds of a video work (the hook)",
                    "How top creators show products without being salesy",
                    "The call-to-action patterns that drive clicks"
                ],
                expectedOutput: "5 reference creators saved + the hook formula you'll use for your own videos."
            ),
            Step(
                id: StepID.ttsAlgorithm,
                title: "Understand the TikTok Algorithm",
                description: "Review your first video's analytics: watch time %, replays, shares. Identify your weakest metric and plan your next video with the algorithm's signals in mind.",
                duration: 20,
                phase: .position,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "How TikTok's test-and-expand distribution works",
                    "Why the first 3 seconds determine everything",
                    "Which metrics matter most: watch time, replays, shares"
                ],
                expectedOutput: "A written analysis of your first video's performance + 1 specific improvement for the next video."
            ),

            // Setup (2)
            Step(
                id: StepID.ttsAccount,
                title: "Set Up Your TikTok Creator Account",
                description: "Switch your TikTok to Creator mode (or create a dedicated account). Write a clear niche bio. Apply for TikTok Shop Affiliate access via the Seller Center.",
                duration: 20,
                phase: .setup,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "The difference between a personal and creator account",
                    "What TikTok looks for in affiliate applications",
                    "How to write a bio that signals your niche clearly"
                ],
                expectedOutput: "An active TikTok creator account with a submitted affiliate application."
            ),
            Step(
                id: StepID.ttsCadence,
                title: "Build a Consistent Posting System",
                description: "Batch-record 5 videos in one session. Set a daily posting time. Create a simple content calendar for the next 14 days. Schedule your first 3 posts.",
                duration: 25,
                phase: .setup,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "How to batch-record content efficiently",
                    "The best posting times for TikTok in your region",
                    "How to use TikTok's built-in scheduler"
                ],
                expectedOutput: "5 pre-recorded videos + a 14-day content calendar with posting schedule."
            ),

            // Launch (6) — 4 authored + 2 shared first-real-world-actions
            Step(
                id: StepID.ttsTestVideo,
                title: "Create Your First Test Video",
                description: "Choose 1 product. Write a 3-sentence script: hook + 1 benefit + CTA. Film a 30-60 second vertical video with good lighting and clear audio. Add the product link and post it.",
                duration: 30,
                phase: .launch,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "The 3-step script formula: hook, benefit, CTA",
                    "How to film with just a phone (lighting, angles)",
                    "How to add product links before posting"
                ],
                expectedOutput: "Your first TikTok Shop affiliate video posted with a product link attached."
            ),
            Step(
                id: StepID.ttsOptimize,
                title: "Optimize Your Product Selection",
                description: "Open TikTok Shop analytics and sort products by click-through rate. Identify your top 2 products — what do they have in common? Find 3 new similar products. Remove products with zero clicks.",
                duration: 20,
                phase: .launch,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "How to read TikTok Shop analytics (clicks, CTR, GMV)",
                    "What makes certain products convert better than others",
                    "When to drop a product vs. try a different angle"
                ],
                expectedOutput: "An optimized product list: top performers kept, zero-click products removed, 3 new products added."
            ),
            Step(
                id: StepID.ttsScaleContent,
                title: "Scale With Proven Content",
                description: "Find your best-performing video. Make 3 variations: same product angle, different hook. Make 2 more: same hook format, different product. Post all 5 within the next 5 days.",
                duration: 25,
                phase: .launch,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "Why iterating on winners beats inventing new formats",
                    "How to create variations without being repetitive",
                    "The compounding effect of consistent, optimized posting"
                ],
                expectedOutput: "5 content variations recorded and scheduled based on your proven top-performing format."
            ),
            Step(
                id: StepID.ttsPipeline,
                title: "Build Your First Commission Pipeline",
                description: "Confirm you have at least 10 active affiliate products linked across your videos. Check your TikTok Shop dashboard for clicks, GMV, and commissions. Set your 30-day income goal.",
                duration: 30,
                phase: .launch,
                videoId: PlaceholderVideoID.tikTokShop,
                watchNotes: [
                    "How to read your affiliate dashboard (clicks, GMV, commission)",
                    "What realistic first-month income looks like",
                    "How to set targets and track daily progress"
                ],
                expectedOutput: "10+ active affiliate products, a working dashboard showing real data, and a clear 30-day income goal."
            ),
            sharedLaunchSendOutreach(),
            sharedLaunchBookCall()
        ]
    }
}

// MARK: - Shared Launch-phase Steps (first real-world actions)

private extension DataService {
    func sharedLaunchSendOutreach() -> Step {
        Step(
            id: StepID.launchSendOutreach,
            title: "Send Your First Outreach Messages",
            description: "Send 10 outreach messages using your script. Log each in your tracker and note any early replies.",
            duration: 30,
            phase: .launch,
            videoId: "",
            watchNotes: [],
            expectedOutput: "10 sent outreach messages logged in your tracker."
        )
    }

    func sharedLaunchBookCall() -> Step {
        Step(
            id: StepID.launchBookCall,
            title: "Book Your First Discovery Call",
            description: "Respond to interested prospects, send a calendar link, and prepare your 5 discovery call questions.",
            duration: 20,
            phase: .launch,
            videoId: "",
            watchNotes: [],
            expectedOutput: "A booked discovery call with a real prospect."
        )
    }
}
