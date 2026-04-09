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
                description: "Help businesses grow their revenue through social media management, paid ads, and organic content strategies.",
                icon: "chart.line.uptrend.xyaxis",
                benefits: [
                    "Low startup cost (€0–€100)",
                    "High demand from local businesses",
                    "Scalable service model",
                    "Learn valuable marketing skills"
                ]
            ),
            BusinessModel(
                name: "Growth Operating",
                shortName: "Growth OS",
                description: "Build and manage revenue operations, systems, and growth infrastructure for scaling companies.",
                icon: "arrow.up.right.circle.fill",
                benefits: [
                    "High-ticket retainer model",
                    "Recurring predictable income",
                    "Work with funded startups",
                    "Leverage ops & strategy skills"
                ]
            ),
            BusinessModel(
                name: "AI Automation Agency",
                shortName: "AAA",
                description: "Build custom AI-powered automations and workflows that save businesses time and money.",
                icon: "sparkles",
                benefits: [
                    "Cutting-edge technology",
                    "Premium pricing justified",
                    "Huge market demand in 2025",
                    "Low competition vs. traditional agencies"
                ]
            ),
            BusinessModel(
                name: "Freelance Brandscaling",
                shortName: "Brandscaling",
                description: "Help personal brands and creators scale their online presence, content, and monetization.",
                icon: "person.crop.circle.badge.plus",
                benefits: [
                    "Work with exciting creators",
                    "Creative and strategic work",
                    "Build your own audience too",
                    "Flexible, remote-first model"
                ]
            )
        ]
    }

    // MARK: - Foundation Steps (model-specific)

    func getFoundationSteps(for modelShortName: String = "SMMA") -> [Step] {
        switch modelShortName {
        case "Growth OS":    return foundationSteps_GrowthOS()
        case "AAA":          return foundationSteps_AAA()
        case "Brandscaling": return foundationSteps_Brandscaling()
        default:             return foundationSteps_SMMA()
        }
    }

    // MARK: - First Actions Steps (static placeholders — AI-generated in a future version)

    func getFirstActionsSteps() -> [Step] {
        return [
            Step(
                title: "Send Your First Outreach Messages",
                description: "It's time to put your script and prospect list to work. Send your first batch of outreach messages today.\n\nConsistency is everything here. Even 5–10 messages per day will compound into real conversations within two weeks.",
                duration: 30,
                phase: .firstActions,
                subtasks: [
                    "Send 10 outreach messages using your script",
                    "Log each message in your prospect tracker",
                    "Note any early replies or positive signals",
                    "Refine your script based on initial feedback"
                ],
                resources: []
            ),
            Step(
                title: "Book Your First Discovery Call",
                description: "When a prospect replies with interest, your goal is one thing: get them on a call. Discovery calls are where deals are made.\n\nIn this step, you'll prepare for and book your first discovery call — and learn what to say when you're on it.",
                duration: 20,
                phase: .firstActions,
                subtasks: [
                    "Respond promptly to interested prospects",
                    "Send a calendar link or propose a time",
                    "Prepare your 5 discovery call questions",
                    "Show up and have an honest conversation"
                ],
                resources: []
            )
        ]
    }
}

// MARK: - SMMA Foundation Steps

private extension DataService {
    func foundationSteps_SMMA() -> [Step] {
        return [
            Step(
                title: "Understand the Business Model",
                description: "Before you take any action, you need to deeply understand how a Social Media Marketing Agency works.\n\nYou'll learn the full end-to-end flow: how SMMA owners find clients, how they deliver social media management and paid ads, how they charge retainers, and what separates beginners from successful agency owners.\n\nBy the end of this step, you'll have a clear mental map of the SMMA business — no more confusion about where to start.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Watch a full breakdown of how SMMA works",
                    "Understand the difference between organic and paid social services",
                    "Learn how retainer pricing works for social media clients",
                    "Write a one-paragraph summary in your own words"
                ],
                resources: [
                    Resource(title: "The Honest Truth About Starting an SMMA in 2025", type: .video, url: "https://www.youtube.com/watch?v=grMGtl9SGZU", duration: "18 min"),
                    Resource(title: "How Agency Business Models Actually Work", type: .article, url: "https://www.hubspot.com/agency", duration: "10 min read"),
                    Resource(title: "SMMA Business Model Overview Template", type: .template, url: "https://www.notion.so/templates/smma-overview", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Niche",
                description: "The biggest mistake SMMA beginners make is trying to serve every type of business. Your niche is the specific industry you'll focus on — and this decision will define your entire agency.\n\nA strong niche makes your pitch more convincing (\"I specialize in social media for gyms\"), your results more repeatable, and your portfolio more credible.\n\nTop SMMA niches include: restaurants, gyms & fitness, real estate, dental/medical, e-commerce, and local service businesses.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research 5+ potential niches for SMMA (gyms, restaurants, real estate, etc.)",
                    "Score each niche: ad spend potential, local availability, competition",
                    "Pick your top 1 niche and commit",
                    "Write down 3 reasons this niche is right for you"
                ],
                resources: [
                    Resource(title: "Best SMMA Niches That Actually Pay in 2025", type: .video, url: "https://www.youtube.com/watch?v=mFiXhWo1r4s", duration: "14 min"),
                    Resource(title: "How to Choose a Profitable SMMA Niche", type: .article, url: "https://www.entrepreneur.com/starting-a-business", duration: "8 min read"),
                    Resource(title: "Niche Scoring Worksheet", type: .template, url: "https://www.notion.so/templates/niche-scoring", duration: nil)
                ]
            ),
            Step(
                title: "Analyze Your Target Audience",
                description: "Knowing your niche isn't enough — you need to deeply understand the business owners inside it.\n\nWho is your ideal SMMA client? A gym owner frustrated by slow membership growth? A restaurant owner who tried Facebook ads but got nothing? The more specifically you understand them, the easier every conversation becomes.\n\nIn this step, you'll build a detailed client profile that will guide your pitch, your service design, and your marketing.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Define your ideal client: business size, location, revenue range",
                    "List their top 3 social media pain points",
                    "Identify which platforms they currently use (or avoid)",
                    "Document what a successful month looks like for them"
                ],
                resources: [
                    Resource(title: "How to Define Your Ideal SMMA Client", type: .video, url: "https://www.youtube.com/watch?v=jpXGYHjL5ck", duration: "15 min"),
                    Resource(title: "Customer Avatar Worksheet", type: .article, url: "https://www.digitalmarketer.com/customer-avatar-worksheet/", duration: "10 min read"),
                    Resource(title: "SMMA Client Profile Template", type: .template, url: "https://www.notion.so/templates/smma-client-profile", duration: nil)
                ]
            ),
            Step(
                title: "Validate the Market",
                description: "Before you invest serious time building, you need proof that businesses in your niche are already paying for social media services.\n\nLook for businesses running Facebook/Instagram ads (they're already spending). Check who has a weak social media presence despite being a good business. These are your warmest prospects.\n\nValidation eliminates the risk of building a service nobody wants.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Find 10+ businesses in your niche currently running social ads (use Meta Ad Library)",
                    "Identify 10+ businesses with poor social media presence",
                    "Research what SMMA agencies in your area are charging",
                    "Confirm your niche has the budget to pay €500–€2,000/month"
                ],
                resources: [
                    Resource(title: "How to Find SMMA Clients Who Are Already Paying", type: .video, url: "https://www.youtube.com/watch?v=3FxJRbVLQ7A", duration: "16 min"),
                    Resource(title: "Meta Ad Library (free tool for competitor research)", type: .article, url: "https://www.facebook.com/ads/library", duration: "5 min read"),
                    Resource(title: "SMMA Market Validation Checklist", type: .template, url: "https://www.notion.so/templates/smma-validation", duration: nil)
                ]
            ),
            Step(
                title: "Create Your Value Proposition",
                description: "Your value proposition is the clearest possible answer to: why should a business owner choose your SMMA over the hundreds of others?\n\nThe best SMMA value propositions are specific and outcome-focused: \"I help gyms in Berlin get 20+ new member inquiries per month through Instagram ads — or you don't pay.\"\n\nIn this step, you'll craft your value proposition using a proven framework and make it specific to your niche.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "List the specific outcomes you can deliver for your niche",
                    "Draft: \"I help [niche] get [result] through [service] in [timeframe]\"",
                    "Research what results other SMMA owners promise",
                    "Refine to one clear, jargon-free sentence with a specific outcome"
                ],
                resources: [
                    Resource(title: "How to Write an SMMA Value Proposition That Closes Clients", type: .video, url: "https://www.youtube.com/watch?v=jJrImqFSZHE", duration: "11 min"),
                    Resource(title: "Value Proposition Canvas Explained", type: .article, url: "https://www.strategyzer.com/library/the-value-proposition-canvas", duration: "8 min read"),
                    Resource(title: "SMMA Value Proposition Builder", type: .template, url: "https://www.notion.so/templates/smma-value-prop", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Primary Service",
                description: "Successful SMMA owners don't offer five services. They start with one, master it, and then expand.\n\nYour primary service should be something you can learn quickly, deliver consistently, and charge well for. Top SMMA starter services: Facebook/Instagram ad management, organic content creation, Instagram profile management, or short-form video editing.\n\nPick one. Package it. Price it. Don't change it for 90 days.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research the top 5 services SMMA agencies sell",
                    "Match services to your current skills (video editing, copywriting, design)",
                    "Define exactly what's included in your core service package",
                    "Set a starting monthly retainer price (e.g. €800/month)"
                ],
                resources: [
                    Resource(title: "Best SMMA Services to Sell as a Beginner", type: .video, url: "https://www.youtube.com/watch?v=LRVnIQ4HhD4", duration: "13 min"),
                    Resource(title: "How to Price Your SMMA Services", type: .article, url: "https://www.hubspot.com/agency-pricing", duration: "8 min read"),
                    Resource(title: "SMMA Service Package Template", type: .template, url: "https://www.notion.so/templates/smma-package", duration: nil)
                ]
            ),
            Step(
                title: "Build a Simple Online Presence",
                description: "You don't need a fancy website. But when a restaurant owner Googles you, you need to look real and credible.\n\nFor SMMA, your LinkedIn and Instagram profiles do most of the heavy lifting. LinkedIn is where B2B clients check you out. Instagram proves you understand social media. A simple one-page website or bio link rounds it out.\n\nLook like you know what you're doing — because you will.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Optimize your LinkedIn with your niche focus and social media expertise",
                    "Set up or clean up an Instagram showcasing marketing knowledge",
                    "Create a simple one-page site or Linktree with your offer",
                    "Post 1 piece of content demonstrating social media expertise"
                ],
                resources: [
                    Resource(title: "How to Build an SMMA Online Presence That Gets Clients", type: .video, url: "https://www.youtube.com/watch?v=7COrNlHBp4E", duration: "17 min"),
                    Resource(title: "LinkedIn Profile Optimization for Agency Owners", type: .article, url: "https://www.linkedin.com/business/sales/blog/profile-best-practices", duration: "7 min read"),
                    Resource(title: "SMMA Agency One-Page Website Template", type: .template, url: "https://www.notion.so/templates/smma-website", duration: nil)
                ]
            ),
            Step(
                title: "Create 3 Portfolio Examples",
                description: "You can't wait for clients to build a portfolio — you create it before you have clients.\n\nFor SMMA, portfolio examples mean: mock ad campaigns, sample Instagram feed redesigns, or before/after content transformations for a real local business (done for free or as a case study). They prove you can do the actual work.\n\nThree solid examples are worth more than ten mediocre ones.",
                duration: 45,
                phase: .foundation,
                subtasks: [
                    "Create 1 mock Facebook/Instagram ad campaign for a business in your niche",
                    "Redesign a real local business's Instagram profile (unpaid, for practice)",
                    "Write a 1-page case study: what you'd change and why",
                    "Add all 3 to your website/portfolio page"
                ],
                resources: [
                    Resource(title: "How to Build an SMMA Portfolio With Zero Clients", type: .video, url: "https://www.youtube.com/watch?v=LzqTBjsJrUE", duration: "14 min"),
                    Resource(title: "SMMA Portfolio Best Practices", type: .article, url: "https://www.smashingmagazine.com/portfolio-guide", duration: "9 min read"),
                    Resource(title: "SMMA Portfolio Case Study Template", type: .template, url: "https://www.notion.so/templates/smma-case-study", duration: nil)
                ]
            ),
            Step(
                title: "Write Your Outreach Script",
                description: "Most SMMA beginners fail at outreach because they send generic \"I can help your business grow\" messages. A good outreach script is specific, relevant, and low-friction.\n\nThe best performing SMMA outreach mentions a specific observation about the prospect's current social media (\"I noticed your Instagram posts aren't using Reels yet\") and ties it to a clear result. It ends with a low-commitment ask.\n\nThis script will be your main sales tool for the first 90 days.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Study 3–5 examples of SMMA cold outreach that gets replies",
                    "Write your DM/email script using the Observation–Insight–Offer format",
                    "Create a follow-up message for non-responders (send on day 3)",
                    "Get feedback from 3 people before using it on real prospects"
                ],
                resources: [
                    Resource(title: "SMMA Cold Outreach Scripts That Actually Work", type: .video, url: "https://www.youtube.com/watch?v=0NaRBOV_7LQ", duration: "19 min"),
                    Resource(title: "The Cold DM Masterclass for Agency Owners", type: .article, url: "https://lemlist.com/blog/cold-email-masterclass", duration: "12 min read"),
                    Resource(title: "SMMA Outreach Script Templates (DM + Email)", type: .template, url: "https://www.notion.so/templates/smma-outreach-scripts", duration: nil)
                ]
            ),
            Step(
                title: "Build Your First Prospect List",
                description: "Your prospect list is the fuel for your SMMA. Without a list of qualified local businesses, there's no one to pitch.\n\nFor SMMA, the best prospects are local businesses with money to spend on marketing but a poor or non-existent social media presence. Google Maps, Instagram search, and the Meta Ad Library are your three best research tools.\n\nBuild a list of 50–100. Work it daily. Your first client is in there.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Define your search criteria: niche, city, weak social presence",
                    "Find 50–100 local businesses using Google Maps + Instagram",
                    "Note the specific social media weakness for each prospect",
                    "Organize in a spreadsheet with business name, contact, and notes"
                ],
                resources: [
                    Resource(title: "How to Build an SMMA Prospect List from Scratch", type: .video, url: "https://www.youtube.com/watch?v=1UWE8_1XPCE", duration: "16 min"),
                    Resource(title: "Lead Research Guide for SMMA Owners", type: .article, url: "https://www.salesforce.com/resources/articles/lead-qualification", duration: "8 min read"),
                    Resource(title: "SMMA Prospect Tracker Template", type: .template, url: "https://www.notion.so/templates/smma-prospect-tracker", duration: nil)
                ]
            )
        ]
    }
}

// MARK: - Growth OS Foundation Steps

private extension DataService {
    func foundationSteps_GrowthOS() -> [Step] {
        return [
            Step(
                title: "Understand the Business Model",
                description: "Before you take any action, you need to deeply understand how Growth Operating works as a service business.\n\nA Growth Operator embeds into a scaling company (usually post-revenue, pre-scale) and builds the revenue systems, operations, and growth infrastructure that allows them to grow without chaos. Think: revenue ops, sales systems, retention frameworks, and team processes.\n\nThis is a high-ticket, strategy-heavy model. You're not a freelancer — you're an operator.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Watch a breakdown of what Growth Operating means in practice",
                    "Understand the difference between a Growth Operator and a consultant",
                    "Learn how retainer + performance pricing works in this model",
                    "Write a one-paragraph summary of what you'll be doing for clients"
                ],
                resources: [
                    Resource(title: "What Is a Growth Operator? (Full Breakdown)", type: .video, url: "https://www.youtube.com/watch?v=grMGtl9SGZU", duration: "18 min"),
                    Resource(title: "Revenue Operations Explained for Beginners", type: .article, url: "https://www.hubspot.com/revenue-operations", duration: "10 min read"),
                    Resource(title: "Growth OS Business Model Overview", type: .template, url: "https://www.notion.so/templates/growth-os-overview", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Niche",
                description: "Growth Operators who specialize win more deals than generalists. Your niche defines the type of company you'll embed into.\n\nThe best Growth OS niches are companies that are already making money but struggling to scale: SaaS companies with $10k–$100k MRR, e-commerce brands doing $500k–$5M/year, service businesses trying to systemize, or funded startups post-Series A.\n\nPick a company stage and sector you can speak to confidently.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research 5+ company types that hire growth operators (SaaS, e-commerce, services)",
                    "Score each by: deal size, access, competition, your background",
                    "Pick the company stage + sector you'll specialize in",
                    "Write down why you can credibly serve this type of company"
                ],
                resources: [
                    Resource(title: "Best Niches for Growth Operators in 2025", type: .video, url: "https://www.youtube.com/watch?v=mFiXhWo1r4s", duration: "14 min"),
                    Resource(title: "How to Pick a B2B Consulting Niche", type: .article, url: "https://www.entrepreneur.com/starting-a-business", duration: "8 min read"),
                    Resource(title: "Growth OS Niche Scoring Worksheet", type: .template, url: "https://www.notion.so/templates/growth-niche-scoring", duration: nil)
                ]
            ),
            Step(
                title: "Analyze Your Target Audience",
                description: "Your target client is a founder or executive at a scaling company who is overwhelmed by growth-related chaos — they're making money but can't systematize, retain customers, or hit consistent growth numbers.\n\nUnderstanding their specific frustrations (leaky sales pipeline, poor retention, no KPIs, team chaos) allows you to position your offer as the exact solution they've been looking for.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Define your ideal client: company stage, revenue range, team size",
                    "List their 3 biggest operational and growth bottlenecks",
                    "Identify where they spend time online (LinkedIn, Slack communities, podcasts)",
                    "Understand what they've already tried before hiring someone like you"
                ],
                resources: [
                    Resource(title: "How to Profile B2B Decision Makers", type: .video, url: "https://www.youtube.com/watch?v=jpXGYHjL5ck", duration: "15 min"),
                    Resource(title: "Ideal Client Profile Framework for Operators", type: .article, url: "https://www.digitalmarketer.com/customer-avatar-worksheet/", duration: "10 min read"),
                    Resource(title: "Growth OS Client Profile Template", type: .template, url: "https://www.notion.so/templates/growth-client-profile", duration: nil)
                ]
            ),
            Step(
                title: "Validate the Market",
                description: "Before investing time in your offer, confirm that companies in your niche are actively hiring for growth and operations roles — and that they're willing to pay a premium for an external operator.\n\nLook at job boards (LinkedIn, Wellfound) for \"Head of Growth\", \"Revenue Operations\", \"Chief of Staff\" roles at companies matching your niche. These are companies who will pay you as a fractional operator instead.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Search LinkedIn for \"Head of Growth\" or \"RevOps\" jobs in your target company type",
                    "Find 10+ companies actively trying to solve growth/operations problems",
                    "Research what fractional operators in your niche charge (typical: $5k–$20k/month)",
                    "Confirm the market has budget and a clear hiring signal"
                ],
                resources: [
                    Resource(title: "How to Validate a B2B Consulting Offer", type: .video, url: "https://www.youtube.com/watch?v=3FxJRbVLQ7A", duration: "16 min"),
                    Resource(title: "Fractional Operator Market Research Guide", type: .article, url: "https://www.shopify.com/blog/market-research", duration: "9 min read"),
                    Resource(title: "Growth OS Market Validation Checklist", type: .template, url: "https://www.notion.so/templates/growth-validation", duration: nil)
                ]
            ),
            Step(
                title: "Create Your Value Proposition",
                description: "Your value proposition as a Growth Operator needs to be specific about the outcome you deliver and the type of company you serve.\n\nThe best ones sound like this: \"I help SaaS companies between $20k–$100k MRR build the revenue systems that let them scale to Series A without burning out their team.\"\n\nVague value props like \"I help companies grow\" don't land. Specificity wins deals.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "List the specific growth/ops outcomes you can drive (pipeline, retention, processes)",
                    "Draft: \"I help [company type at stage] achieve [specific outcome] by [method]\"",
                    "Test your value prop with 3 founders or operators for feedback",
                    "Refine to one clear sentence with a specific, believable result"
                ],
                resources: [
                    Resource(title: "How Operators Write Value Propositions That Win Clients", type: .video, url: "https://www.youtube.com/watch?v=jJrImqFSZHE", duration: "11 min"),
                    Resource(title: "B2B Value Proposition Frameworks", type: .article, url: "https://www.strategyzer.com/library/the-value-proposition-canvas", duration: "8 min read"),
                    Resource(title: "Growth OS Value Proposition Builder", type: .template, url: "https://www.notion.so/templates/growth-value-prop", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Primary Service",
                description: "Growth Operators who try to do everything get hired for nothing. Pick one core system you'll build for your first clients.\n\nTop Growth OS starter services: Revenue operations setup (CRM, pipeline, reporting), Sales system buildout, Customer retention and churn reduction framework, or Go-to-market playbook.\n\nThe more specific your service, the easier it is to sell and deliver.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research 5 core growth/ops services companies need most",
                    "Match each service to your skills and experience",
                    "Define a clear deliverable: what does the client receive at the end?",
                    "Set a starting engagement price (e.g. €5,000 for a 30-day sprint)"
                ],
                resources: [
                    Resource(title: "What Services Growth Operators Sell (and What Pays Most)", type: .video, url: "https://www.youtube.com/watch?v=LRVnIQ4HhD4", duration: "13 min"),
                    Resource(title: "How to Package Fractional Services", type: .article, url: "https://www.hubspot.com/agency-pricing", duration: "8 min read"),
                    Resource(title: "Growth OS Service Package Template", type: .template, url: "https://www.notion.so/templates/growth-package", duration: nil)
                ]
            ),
            Step(
                title: "Build a Simple Online Presence",
                description: "Founders hiring Growth Operators will check your LinkedIn — almost exclusively. Your LinkedIn profile is your agency website.\n\nIt should clearly state: who you help, what outcome you drive, and what you've done before (even in past roles). A strong LinkedIn presence + 1–2 posts per week about growth/ops topics is enough to start getting inbound.\n\nDon't build a fancy site until LinkedIn is perfect.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Rewrite your LinkedIn headline to reflect your Growth OS positioning",
                    "Write a LinkedIn About section using your value proposition",
                    "Post 1 piece of content about a growth/ops insight or framework",
                    "Connect with 20+ founders and operators in your target niche"
                ],
                resources: [
                    Resource(title: "LinkedIn for Operators: Build a Profile That Gets Inbound", type: .video, url: "https://www.youtube.com/watch?v=7COrNlHBp4E", duration: "17 min"),
                    Resource(title: "LinkedIn Profile Optimization Checklist", type: .article, url: "https://www.linkedin.com/business/sales/blog/profile-best-practices", duration: "7 min read"),
                    Resource(title: "Operator LinkedIn Profile Template", type: .template, url: "https://www.notion.so/templates/operator-linkedin", duration: nil)
                ]
            ),
            Step(
                title: "Create 3 Portfolio Examples",
                description: "You can't wait for clients to build a portfolio. Document what you've already done — or create hypothetical case studies for companies you'd want to work with.\n\nFor Growth OS, portfolio examples are: a before/after CRM setup, a sales pipeline you built (in a past job, side project, or for a friend's business), or a written growth strategy for a specific company type.\n\nOperators buy outcomes. Show them you can think in systems.",
                duration: 45,
                phase: .foundation,
                subtasks: [
                    "Document a real system you've built (at a job, side project, or for someone else)",
                    "Create a mock \"Growth Audit\" for a company type in your niche",
                    "Write a 1-page case study with the problem, approach, and expected result",
                    "Publish the case study to your LinkedIn or a simple portfolio page"
                ],
                resources: [
                    Resource(title: "How to Build a Consulting Portfolio Without Client Work", type: .video, url: "https://www.youtube.com/watch?v=LzqTBjsJrUE", duration: "14 min"),
                    Resource(title: "B2B Portfolio Best Practices for Operators", type: .article, url: "https://www.smashingmagazine.com/portfolio-guide", duration: "9 min read"),
                    Resource(title: "Growth OS Portfolio Case Study Template", type: .template, url: "https://www.notion.so/templates/growth-case-study", duration: nil)
                ]
            ),
            Step(
                title: "Write Your Outreach Script",
                description: "Outreach for Growth Operators works best on LinkedIn with a personalized, insight-led approach. Founders respond to messages that show you've done your homework.\n\nThe best performing approach: reference something specific about their company (a funding round, a LinkedIn post, a public metric), tie it to a growth/ops challenge they're likely facing, and offer a brief call to explore if you can help.\n\nNo pitch decks. No feature lists. Just relevance.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Study 3–5 LinkedIn outreach examples that get founder replies",
                    "Write your message using the Trigger–Insight–Offer format",
                    "Create a follow-up for non-responders that adds value (share a relevant resource)",
                    "Test it with a warm contact in your network before going cold"
                ],
                resources: [
                    Resource(title: "LinkedIn Outreach for B2B Operators (What Actually Works)", type: .video, url: "https://www.youtube.com/watch?v=0NaRBOV_7LQ", duration: "19 min"),
                    Resource(title: "How to Write Cold LinkedIn Messages That Get Replies", type: .article, url: "https://lemlist.com/blog/cold-email-masterclass", duration: "12 min read"),
                    Resource(title: "Growth OS Outreach Script Templates", type: .template, url: "https://www.notion.so/templates/growth-outreach", duration: nil)
                ]
            ),
            Step(
                title: "Build Your First Prospect List",
                description: "Your prospect list as a Growth Operator is a curated list of scaling companies that fit your niche exactly — not a spray-and-pray list, but a targeted 50.\n\nUse LinkedIn Sales Navigator, Crunchbase (for funded companies), Product Hunt, and job boards. Look for companies with fresh funding, hiring growth roles, or publicly discussing scaling challenges.\n\nQuality beats quantity here. 50 perfect prospects beats 500 random ones.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Define exact criteria: company stage, size, sector, growth signals",
                    "Research 50 companies using LinkedIn, Crunchbase, or Wellfound",
                    "Find the right decision-maker contact at each company",
                    "Organize in a CRM or spreadsheet with growth signal notes"
                ],
                resources: [
                    Resource(title: "How to Build a B2B Prospect List That Converts", type: .video, url: "https://www.youtube.com/watch?v=1UWE8_1XPCE", duration: "16 min"),
                    Resource(title: "Lead Research Guide for B2B Operators", type: .article, url: "https://www.salesforce.com/resources/articles/lead-qualification", duration: "8 min read"),
                    Resource(title: "Growth OS Prospect Tracker Template", type: .template, url: "https://www.notion.so/templates/growth-prospect-tracker", duration: nil)
                ]
            )
        ]
    }
}

// MARK: - AAA Foundation Steps

private extension DataService {
    func foundationSteps_AAA() -> [Step] {
        return [
            Step(
                title: "Understand the Business Model",
                description: "Before you take any action, you need to deeply understand how an AI Automation Agency works and what separates the few who succeed from the many who don't.\n\nAn AAA builds custom AI workflows, automations, and tools for businesses — replacing repetitive manual work with intelligent systems. You don't need to be a developer. You use no-code tools (Make, n8n, Zapier) and AI APIs (OpenAI, Claude) to build solutions that save clients hours every week.\n\nYou're not selling AI hype. You're selling time savings with a clear ROI.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Watch a full breakdown of the AI Automation Agency model",
                    "Understand the difference between no-code automation and custom AI development",
                    "Learn how AAA owners price projects and retainers",
                    "Write a one-paragraph summary of what you'll build for clients"
                ],
                resources: [
                    Resource(title: "AI Automation Agency — Complete Business Model Explained", type: .video, url: "https://www.youtube.com/watch?v=grMGtl9SGZU", duration: "18 min"),
                    Resource(title: "How AAA Agencies Work and Make Money", type: .article, url: "https://www.hubspot.com/agency", duration: "10 min read"),
                    Resource(title: "AAA Business Model Overview Template", type: .template, url: "https://www.notion.so/templates/aaa-overview", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Niche",
                description: "The most successful AI Automation Agencies specialize in one industry or business type — because automations for a law firm look completely different from automations for an e-commerce brand.\n\nTop AAA niches: e-commerce (order processing, customer service bots), real estate (lead follow-up, CRM automation), agencies (client reporting, proposal generation), healthcare (appointment scheduling), or professional services (document generation, onboarding flows).\n\nSpecialization lets you build reusable automations and sell faster.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research 5+ industries where AI automation creates clear time savings",
                    "Score each by: pain intensity, budget availability, automation complexity",
                    "Pick 1 niche where you can build repeatable automation solutions",
                    "Write down the 3 most common manual tasks in that niche you could automate"
                ],
                resources: [
                    Resource(title: "Best Niches for AI Automation Agencies in 2025", type: .video, url: "https://www.youtube.com/watch?v=mFiXhWo1r4s", duration: "14 min"),
                    Resource(title: "How to Choose a Niche for Your AAA", type: .article, url: "https://www.entrepreneur.com/starting-a-business", duration: "8 min read"),
                    Resource(title: "AAA Niche Scoring Worksheet", type: .template, url: "https://www.notion.so/templates/aaa-niche-scoring", duration: nil)
                ]
            ),
            Step(
                title: "Analyze Your Target Audience",
                description: "Your ideal AAA client is a business owner or operations manager drowning in manual, repetitive work — and frustrated that their team spends hours on tasks that should be automatic.\n\nThey don't care about \"AI\" in the abstract. They care about not spending 3 hours a day copying data between tools, writing the same emails, or manually generating reports. Your job is to understand those specific frustrations.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Define your ideal client: business size, team structure, tech stack",
                    "List their top 3 most painful manual workflows",
                    "Identify which tools they already use (CRM, email, spreadsheets)",
                    "Understand what a 10-hour/week time savings would mean for their business"
                ],
                resources: [
                    Resource(title: "How to Profile Your Ideal AAA Client", type: .video, url: "https://www.youtube.com/watch?v=jpXGYHjL5ck", duration: "15 min"),
                    Resource(title: "Understanding Automation Pain Points in Business", type: .article, url: "https://www.digitalmarketer.com/customer-avatar-worksheet/", duration: "10 min read"),
                    Resource(title: "AAA Client Profile Template", type: .template, url: "https://www.notion.so/templates/aaa-client-profile", duration: nil)
                ]
            ),
            Step(
                title: "Validate the Market",
                description: "Before you build anything, confirm that businesses in your niche are actively paying for automation and AI tools — and that the problem is urgent enough for them to hire an agency.\n\nLook for job postings for \"automation specialist\", \"operations manager\", or \"AI tools\" in your niche. Check what tools companies in your niche are already paying for (Zapier, Monday, HubSpot) — these are signals they value automation.\n\nIf they're already paying for automation tools, they'll pay for someone to build them better automations.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Find 10+ businesses in your niche paying for automation tools (Zapier, Make, HubSpot)",
                    "Search job boards for automation-related roles in your niche",
                    "Research what AAA agencies charge in your space (typical: €2,000–€10,000/project)",
                    "Confirm the automation problem is painful enough that businesses will pay to solve it"
                ],
                resources: [
                    Resource(title: "How to Validate Your AAA Offer Before Building Anything", type: .video, url: "https://www.youtube.com/watch?v=3FxJRbVLQ7A", duration: "16 min"),
                    Resource(title: "Market Validation for AI Service Businesses", type: .article, url: "https://www.shopify.com/blog/market-research", duration: "9 min read"),
                    Resource(title: "AAA Market Validation Checklist", type: .template, url: "https://www.notion.so/templates/aaa-validation", duration: nil)
                ]
            ),
            Step(
                title: "Create Your Value Proposition",
                description: "Your AAA value proposition must be rooted in time savings and ROI — not technology. Nobody buys \"AI automations\". They buy \"save 15 hours a week on your reporting\" or \"never manually follow up with a lead again.\"\n\nThe best AAA value propositions are quantified: \"I build AI systems for e-commerce brands that reduce customer service response time by 80% and save 20+ hours/week.\"\n\nLead with the outcome. Mention AI second.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "List 5 specific time-saving outcomes your automations deliver",
                    "Quantify them: hours saved, errors reduced, response time improved",
                    "Draft: \"I help [niche] save [X hours/week] by automating [specific workflow]\"",
                    "Test with 3 business owners: does it immediately make sense to them?"
                ],
                resources: [
                    Resource(title: "Writing AAA Value Propositions That Close Deals", type: .video, url: "https://www.youtube.com/watch?v=jJrImqFSZHE", duration: "11 min"),
                    Resource(title: "ROI-Based Positioning for AI Service Businesses", type: .article, url: "https://www.strategyzer.com/library/the-value-proposition-canvas", duration: "8 min read"),
                    Resource(title: "AAA Value Proposition Builder", type: .template, url: "https://www.notion.so/templates/aaa-value-prop", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Primary Service",
                description: "Successful AAA owners start with one type of automation they can build fast, price well, and repeat across clients in their niche.\n\nTop AAA starter services: AI-powered lead follow-up systems, automated client onboarding flows, CRM data entry automation, AI content repurposing pipelines, or custom chatbots for customer service.\n\nPick the one that matches your technical comfort level and solves the biggest pain in your niche.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Research the top 5 automation solutions businesses in your niche pay for",
                    "Assess your current tool skills: Make, n8n, Zapier, OpenAI API",
                    "Pick 1 automation type you can build and deliver in under 2 weeks",
                    "Define the deliverable: what does the client get, and what results can they expect?"
                ],
                resources: [
                    Resource(title: "Best AI Automation Services to Sell as a Beginner", type: .video, url: "https://www.youtube.com/watch?v=LRVnIQ4HhD4", duration: "13 min"),
                    Resource(title: "How to Package and Price AI Automation Services", type: .article, url: "https://www.hubspot.com/agency-pricing", duration: "8 min read"),
                    Resource(title: "AAA Service Package Template", type: .template, url: "https://www.notion.so/templates/aaa-package", duration: nil)
                ]
            ),
            Step(
                title: "Build a Simple Online Presence",
                description: "For an AAA, your online presence needs to do one thing: prove you understand AI and automation, and show that you can apply it practically.\n\nLinkedIn is your primary channel (most business buyers are there). Post breakdowns of automations you've built or interesting AI workflows. YouTube shorts or Twitter/X threads work well too. You don't need a polished agency site — a simple page describing what you build is enough to start.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Update LinkedIn to reflect your AAA specialization and niche",
                    "Post 1 piece of content: a breakdown of an automation you built or would build",
                    "Set up a simple one-page site or Notion page describing your service",
                    "Join 2–3 online communities where your target clients hang out"
                ],
                resources: [
                    Resource(title: "How to Build an AAA Online Presence That Attracts Clients", type: .video, url: "https://www.youtube.com/watch?v=7COrNlHBp4E", duration: "17 min"),
                    Resource(title: "LinkedIn Content Strategy for AI Agencies", type: .article, url: "https://www.linkedin.com/business/sales/blog/profile-best-practices", duration: "7 min read"),
                    Resource(title: "AAA Simple Website Template", type: .template, url: "https://www.notion.so/templates/aaa-website", duration: nil)
                ]
            ),
            Step(
                title: "Create 3 Portfolio Examples",
                description: "For an AAA, portfolio examples are working demos — not case studies on paper, but actual automation flows you've built and can demonstrate.\n\nBuild 3 real automations using free tiers of Make, n8n, or Zapier + OpenAI. They don't need to be for paying clients. Build one for yourself, one for a friend's business, and one as a mock for your niche.\n\nA 3-minute demo video of a working automation is worth more than any written case study.",
                duration: 45,
                phase: .foundation,
                subtasks: [
                    "Build a working automation #1: an AI lead follow-up or email sequence",
                    "Build a working automation #2: a data processing or reporting automation",
                    "Build a working automation #3: something specific to your chosen niche",
                    "Record a short screen demo of each and add to your portfolio page"
                ],
                resources: [
                    Resource(title: "How to Build an AAA Portfolio With Zero Clients", type: .video, url: "https://www.youtube.com/watch?v=LzqTBjsJrUE", duration: "14 min"),
                    Resource(title: "Beginner Automation Projects to Build Your Portfolio", type: .article, url: "https://www.smashingmagazine.com/portfolio-guide", duration: "9 min read"),
                    Resource(title: "AAA Demo Script + Portfolio Template", type: .template, url: "https://www.notion.so/templates/aaa-portfolio", duration: nil)
                ]
            ),
            Step(
                title: "Write Your Outreach Script",
                description: "AAA outreach works best when you lead with a specific automation idea tailored to the prospect's business — not a generic \"I can automate your business\" message.\n\nThe most effective approach: find a specific manual process the business is obviously doing (posting manually, responding to every review, sending individual follow-ups) and offer a short demo of how you'd automate it. Lead with value, not a sales pitch.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Study 3–5 outreach examples that get replies in the automation/AI space",
                    "Write your message: specific observation + automation idea + low-stakes offer",
                    "Create a follow-up offering to share a 2-minute demo relevant to their business",
                    "Test with 5 warm contacts before using on cold prospects"
                ],
                resources: [
                    Resource(title: "AAA Cold Outreach That Actually Gets Replies", type: .video, url: "https://www.youtube.com/watch?v=0NaRBOV_7LQ", duration: "19 min"),
                    Resource(title: "Value-Led Outreach for AI Service Businesses", type: .article, url: "https://lemlist.com/blog/cold-email-masterclass", duration: "12 min read"),
                    Resource(title: "AAA Outreach Script Templates", type: .template, url: "https://www.notion.so/templates/aaa-outreach", duration: nil)
                ]
            ),
            Step(
                title: "Build Your First Prospect List",
                description: "For an AAA, your prospect list is businesses with obvious manual processes — companies that are doing by hand what you can automate for them.\n\nLook for telltale signs: businesses that respond to every Google review manually, e-commerce brands with no chatbot, agencies that manually compile client reports, or service businesses sending one-by-one follow-up emails.\n\nThese are businesses that will immediately understand your value prop.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Define your search criteria: niche + visible manual process + tech-adjacent",
                    "Research 50+ businesses showing signs of manual, automatable workflows",
                    "Note the specific automation opportunity for each prospect",
                    "Organize in a tracker with prospect name, automation idea, and contact info"
                ],
                resources: [
                    Resource(title: "How to Find Automation Prospects for Your AAA", type: .video, url: "https://www.youtube.com/watch?v=1UWE8_1XPCE", duration: "16 min"),
                    Resource(title: "Lead Research for AI Automation Agencies", type: .article, url: "https://www.salesforce.com/resources/articles/lead-qualification", duration: "8 min read"),
                    Resource(title: "AAA Prospect Tracker Template", type: .template, url: "https://www.notion.so/templates/aaa-prospect-tracker", duration: nil)
                ]
            )
        ]
    }
}

// MARK: - Brandscaling Foundation Steps

private extension DataService {
    func foundationSteps_Brandscaling() -> [Step] {
        return [
            Step(
                title: "Understand the Business Model",
                description: "Before you take any action, you need to deeply understand how Freelance Brandscaling works and what you're actually selling.\n\nA Brandscaler helps personal brands and creators grow their audience, content output, and monetization — typically through a combination of content strategy, ghostwriting, video editing, brand positioning, and funnel building. You embed into a creator's business and help them scale what's already working.\n\nYou're not an agency. You're a high-value creative partner.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Watch a breakdown of what Freelance Brandscaling actually means",
                    "Understand the difference between a social media manager and a Brandscaler",
                    "Learn how top brandscalers price their services (project, retainer, or rev-share)",
                    "Write a one-paragraph description of the value you'll deliver"
                ],
                resources: [
                    Resource(title: "What Is Freelance Brandscaling? (Full Model Explained)", type: .video, url: "https://www.youtube.com/watch?v=grMGtl9SGZU", duration: "18 min"),
                    Resource(title: "How Creator Economy Service Businesses Work", type: .article, url: "https://www.hubspot.com/creator-economy", duration: "10 min read"),
                    Resource(title: "Brandscaling Business Model Overview", type: .template, url: "https://www.notion.so/templates/brandscaling-overview", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Niche",
                description: "The creator economy is enormous. Successful brandscalers specialize in a specific type of creator or personal brand — not \"all content creators.\"\n\nTop Brandscaling niches: business coaches, fitness influencers, finance creators, SaaS founders building in public, speakers and authors, career/productivity creators, or niche B2B thought leaders.\n\nPick a creator type whose content world you already understand. If you consume their content, you understand their audience.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "List 5+ types of creators/personal brands you could serve well",
                    "Score each by: your interest, their revenue potential, content complexity",
                    "Pick 1 creator niche you can speak their language in",
                    "Write down what makes you uniquely qualified to help this type of creator"
                ],
                resources: [
                    Resource(title: "Best Creator Niches for Brandscalers in 2025", type: .video, url: "https://www.youtube.com/watch?v=mFiXhWo1r4s", duration: "14 min"),
                    Resource(title: "How to Find Your Brandscaling Niche", type: .article, url: "https://www.entrepreneur.com/starting-a-business", duration: "8 min read"),
                    Resource(title: "Brandscaling Niche Scoring Worksheet", type: .template, url: "https://www.notion.so/templates/brandscaling-niche", duration: nil)
                ]
            ),
            Step(
                title: "Analyze Your Target Audience",
                description: "Your target client is a creator or personal brand who has momentum but not systems — they're posting, growing, and making some money, but they're overwhelmed and leaving revenue on the table.\n\nThey want more output without more hours. They want someone who \"gets\" their brand and can run with it. They're often 10k–500k followers: established enough to pay, small enough to still need help.\n\nUnderstand what they fear, what they want, and what they've already tried.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Define your ideal creator client: platform, niche, follower range, revenue level",
                    "List their top 3 content and business bottlenecks",
                    "Identify which platforms they're most active on and what they outsource",
                    "Understand their relationship with contractors they've hired before"
                ],
                resources: [
                    Resource(title: "How to Profile Your Ideal Creator Client", type: .video, url: "https://www.youtube.com/watch?v=jpXGYHjL5ck", duration: "15 min"),
                    Resource(title: "Creator Economy Client Profiling Guide", type: .article, url: "https://www.digitalmarketer.com/customer-avatar-worksheet/", duration: "10 min read"),
                    Resource(title: "Brandscaling Client Profile Template", type: .template, url: "https://www.notion.so/templates/brandscaling-client-profile", duration: nil)
                ]
            ),
            Step(
                title: "Validate the Market",
                description: "Before building your service, confirm that creators in your niche are actively hiring for content help — and that they're paying real money for it.\n\nLook at Twitter/X and LinkedIn for creators posting \"hiring: video editor / ghostwriter / content manager.\" Check platforms like Contra, Toptal, and LinkedIn jobs for creator-side roles. These are the exact people who will hire you.\n\nIf creators in your niche are already posting jobs, the market is validated.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Find 10+ creators in your niche actively posting content jobs (Twitter, LinkedIn)",
                    "Research what brandscalers and creator assistants are charging",
                    "Check which services creators most commonly outsource in your niche",
                    "Confirm creators in your niche have revenue to invest in help (courses, sponsorships, etc.)"
                ],
                resources: [
                    Resource(title: "How to Validate a Creator Services Business", type: .video, url: "https://www.youtube.com/watch?v=3FxJRbVLQ7A", duration: "16 min"),
                    Resource(title: "Creator Economy Market Sizing Guide", type: .article, url: "https://www.shopify.com/blog/market-research", duration: "9 min read"),
                    Resource(title: "Brandscaling Market Validation Checklist", type: .template, url: "https://www.notion.so/templates/brandscaling-validation", duration: nil)
                ]
            ),
            Step(
                title: "Create Your Value Proposition",
                description: "Your value proposition as a Brandscaler must be specific about what you do for creators and what outcome you drive.\n\nVague: \"I help creators with their content.\" Strong: \"I help business coaches on LinkedIn go from 3 posts/week to 14 pieces of content weekly without them spending more than 1 hour on it.\"\n\nCreators buy outcomes (more content, more growth, more revenue) and trust (you get my voice, you won't dilute my brand). Address both.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "List 5 specific outcomes you can drive for creators (output, growth, revenue)",
                    "Define your trust differentiator: what makes you someone who \"gets\" their brand?",
                    "Draft: \"I help [creator type] [achieve outcome] without [pain they want to avoid]\"",
                    "Test with 3 creators or content professionals for gut-check feedback"
                ],
                resources: [
                    Resource(title: "How to Write a Value Proposition Creators Actually Buy", type: .video, url: "https://www.youtube.com/watch?v=jJrImqFSZHE", duration: "11 min"),
                    Resource(title: "Positioning for Creator Economy Service Businesses", type: .article, url: "https://www.strategyzer.com/library/the-value-proposition-canvas", duration: "8 min read"),
                    Resource(title: "Brandscaling Value Proposition Builder", type: .template, url: "https://www.notion.so/templates/brandscaling-value-prop", duration: nil)
                ]
            ),
            Step(
                title: "Choose Your Primary Service",
                description: "Great brandscalers specialize before they generalize. Pick one service that lets you make a big impact quickly and that matches your existing creative skills.\n\nTop Brandscaling starter services: LinkedIn or Twitter ghostwriting, short-form video editing (Reels/TikTok/Shorts), newsletter writing, podcast repurposing (long-form to clips + posts), or brand strategy and visual identity.\n\nPick what you're already good at. Skill + niche = fast traction.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "List your creative skills: writing, video editing, design, strategy",
                    "Match each skill to the top services creators in your niche outsource",
                    "Define your core service package: what's included and what's the output?",
                    "Set a starting price (e.g. €1,500/month for 12 LinkedIn posts + strategy)"
                ],
                resources: [
                    Resource(title: "Best Creator Services to Freelance in 2025", type: .video, url: "https://www.youtube.com/watch?v=LRVnIQ4HhD4", duration: "13 min"),
                    Resource(title: "How to Package Creator Services for Retainer Clients", type: .article, url: "https://www.hubspot.com/agency-pricing", duration: "8 min read"),
                    Resource(title: "Brandscaling Service Package Template", type: .template, url: "https://www.notion.so/templates/brandscaling-package", duration: nil)
                ]
            ),
            Step(
                title: "Build a Simple Online Presence",
                description: "For a Brandscaler, your online presence is your proof of concept. If you're helping creators build their brand — your own online presence should demonstrate that you know how.\n\nYou don't need to be famous. But a clean Twitter/X or LinkedIn profile showing your understanding of content, a few sharp posts about the creator economy, and a simple portfolio page is all you need to land your first paying client.\n\nYour personal brand is your agency website.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Polish your Twitter/X or LinkedIn to reflect your Brandscaling specialization",
                    "Post 3 pieces of content demonstrating creator economy insight",
                    "Create a simple portfolio page: your service, your niche, 3 sample pieces",
                    "Follow and engage with 20+ creators in your target niche"
                ],
                resources: [
                    Resource(title: "How to Build Your Personal Brand as a Brandscaler", type: .video, url: "https://www.youtube.com/watch?v=7COrNlHBp4E", duration: "17 min"),
                    Resource(title: "Content Strategy for Service Freelancers", type: .article, url: "https://www.linkedin.com/business/sales/blog/profile-best-practices", duration: "7 min read"),
                    Resource(title: "Brandscaling Portfolio Page Template", type: .template, url: "https://www.notion.so/templates/brandscaling-portfolio-page", duration: nil)
                ]
            ),
            Step(
                title: "Create 3 Portfolio Examples",
                description: "Creators hire brandscalers based on taste and voice match — not credentials. Your portfolio examples need to show you can write, edit, or strategize in a way that feels native to the type of creator you serve.\n\nCreate 3 spec pieces in the exact format you'd produce for a real client: a LinkedIn post series, a short-form video edit, a newsletter issue, or a content calendar. Make them for a real creator you admire (unpaid) or a mock version.\n\nIf it looks like real content from a real creator, it works as a portfolio.",
                duration: 45,
                phase: .foundation,
                subtasks: [
                    "Create 1 spec piece: write or produce content as if for a creator in your niche",
                    "Create 1 before/after: show how you'd improve an existing creator's content",
                    "Create 1 strategy doc: a 4-week content plan for a creator in your niche",
                    "Publish all 3 on your portfolio page with brief explanations"
                ],
                resources: [
                    Resource(title: "How to Build a Brandscaling Portfolio With No Clients", type: .video, url: "https://www.youtube.com/watch?v=LzqTBjsJrUE", duration: "14 min"),
                    Resource(title: "Creator Content Portfolio Best Practices", type: .article, url: "https://www.smashingmagazine.com/portfolio-guide", duration: "9 min read"),
                    Resource(title: "Brandscaling Portfolio Case Study Template", type: .template, url: "https://www.notion.so/templates/brandscaling-case-study", duration: nil)
                ]
            ),
            Step(
                title: "Write Your Outreach Script",
                description: "The best way to land creator clients is to get on their radar by engaging genuinely before you ever pitch them — and when you do pitch, make it feel like a natural next step.\n\nFor Brandscaling, effective outreach means: engage with their content authentically for 1–2 weeks, then DM with a specific observation about their brand + a clear, low-stakes offer (\"I put together a content idea for your [platform] — can I share it?\").\n\nCreators are bombarded with pitches. Being a genuine fan first makes you different.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Study 3–5 outreach examples that work for landing creator clients",
                    "Write a warm DM script: genuine observation + specific idea + soft offer",
                    "Create a cold outreach version for creators you haven't engaged with yet",
                    "Write a follow-up that delivers value (share a content idea for free)"
                ],
                resources: [
                    Resource(title: "How to Pitch Creators and Personal Brands (What Works)", type: .video, url: "https://www.youtube.com/watch?v=0NaRBOV_7LQ", duration: "19 min"),
                    Resource(title: "DM Outreach Strategy for the Creator Economy", type: .article, url: "https://lemlist.com/blog/cold-email-masterclass", duration: "12 min read"),
                    Resource(title: "Brandscaling Outreach Script Templates", type: .template, url: "https://www.notion.so/templates/brandscaling-outreach", duration: nil)
                ]
            ),
            Step(
                title: "Build Your First Prospect List",
                description: "Your prospect list as a Brandscaler is a curated list of creators in your niche who are at the right stage — growing but not yet at the level where they have a full team.\n\nLook for creators with 5k–200k followers who are clearly doing the work themselves (posting inconsistently, repurposing nothing, missing obvious content opportunities). These creators know they need help — they just haven't found the right person yet.\n\nYou're looking for momentum + chaos. That's your entry point.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Define your target creator: platform, follower range, niche, content gaps",
                    "Find 50+ creators matching your criteria on Twitter, LinkedIn, YouTube, or Instagram",
                    "Note the specific content gap or opportunity for each creator",
                    "Organize in a tracker: creator, platform, follower count, content weakness, contact"
                ],
                resources: [
                    Resource(title: "How to Build a Creator Prospect List for Brandscaling", type: .video, url: "https://www.youtube.com/watch?v=1UWE8_1XPCE", duration: "16 min"),
                    Resource(title: "Lead Research for Creator Economy Freelancers", type: .article, url: "https://www.salesforce.com/resources/articles/lead-qualification", duration: "8 min read"),
                    Resource(title: "Brandscaling Prospect Tracker Template", type: .template, url: "https://www.notion.so/templates/brandscaling-prospect-tracker", duration: nil)
                ]
            )
        ]
    }
}
