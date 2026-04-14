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

    // MARK: - Foundation Steps (model-specific)

    func getFoundationSteps(for modelShortName: String = "AAA") -> [Step] {
        let steps: [Step]
        switch modelShortName {
        case "TikTok Shop": steps = foundationSteps_TikTokShop()
        default:            steps = foundationSteps_AAA()
        }
        // Keep only the first (video) resource per step
        return steps.map { step in
            Step(
                id: step.id,
                title: step.title,
                description: step.description,
                duration: step.duration,
                phase: step.phase,
                subtasks: step.subtasks,
                resources: Array(step.resources.prefix(1)),
                isCompleted: step.isCompleted
            )
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

// MARK: - TikTok Shop Foundation Steps

private extension DataService {
    func foundationSteps_TikTokShop() -> [Step] {
        return [
            Step(
                title: "Understand TikTok Shop Affiliate",
                description: "TikTok Shop Affiliate is one of the fastest-growing ways to make money online in 2026. You earn commissions by posting short videos about products — no inventory, no shipping, no customer service.\n\nHere's how it works: you apply to the TikTok Affiliate program, browse thousands of products in the TikTok Shop marketplace, add a product link to your video, and earn a commission every time someone buys through your link.\n\nYou're not selling anything yourself. You're matching the right product to the right audience — and getting paid for every sale.",
                duration: 15,
                phase: .foundation,
                subtasks: [
                    "Watch the intro video fully — understand the commission model",
                    "Open TikTok and browse the TikTok Shop tab to see what's selling",
                    "Find 1 creator already doing TikTok Shop affiliate in a niche you like",
                    "Write down: what product are they promoting, and how many views are their videos getting?"
                ],
                resources: [
                    Resource(title: "TikTok Shop Affiliate for Beginners 2026 — Complete Overview", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+shop+affiliate+beginners+2025", duration: "15 min")
                ]
            ),
            Step(
                title: "Set Up Your TikTok Creator Account",
                description: "Before you can promote products, you need a TikTok account set up specifically for content creation — not just scrolling.\n\nThis means switching to a Creator or Business account, completing your profile with a clear niche focus, and applying for the TikTok Shop Affiliate program.\n\nThe application takes 1–3 days to approve. Do this today so you're not waiting when you're ready to post.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Switch your TikTok account to Creator mode (or create a new dedicated account)",
                    "Write a clear bio: what niche you cover and what value you give viewers",
                    "Apply for TikTok Shop Affiliate access via the TikTok Shop Seller Center",
                    "While waiting for approval, post 1 intro video to start your account"
                ],
                resources: [
                    Resource(title: "How to Apply for TikTok Shop Affiliate and Get Approved Fast", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+shop+affiliate+setup+account+2025", duration: "12 min")
                ]
            ),
            Step(
                title: "Find Your Product Niche",
                description: "The biggest mistake beginners make is promoting random products. Successful TikTok Shop affiliates focus on one product category — and become the go-to person for it.\n\nYour niche should be something you're genuinely interested in or already know about. The best niches are specific enough to build an audience, but broad enough to have many products: skincare, kitchen gadgets, gym accessories, phone accessories, pet products.\n\nBrowse the TikTok Shop marketplace and find the category where products have high commission rates AND your videos can feel authentic.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Open TikTok Shop marketplace and browse the top 5 product categories",
                    "Check commission rates — aim for 10–30%+ commission per sale",
                    "Pick 1 niche you can talk about naturally on camera",
                    "Find 3 specific products in that niche with 1,000+ units sold"
                ],
                resources: [
                    Resource(title: "Best TikTok Shop Niches With High Commissions in 2025", type: .video, url: "https://www.youtube.com/results?search_query=best+tiktok+shop+affiliate+niches+high+commission+2025", duration: "14 min")
                ]
            ),
            Step(
                title: "Analyze Top Performing Creators",
                description: "You don't need to invent anything. The formula for TikTok Shop success is already in thousands of existing videos — you just need to reverse-engineer it.\n\nFind 5 creators in your niche who are actively promoting products. Watch their top-performing videos (the ones with the most views and purchases) and break down: How do they start the video (the hook)? How do they show the product? What do they say to make people click the link?\n\nThis analysis is your content playbook before you ever post a single video.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Search TikTok for your niche + \"TikTok Shop\" and find 5 active creators",
                    "Watch the top 3 videos from each creator — note their hook, pacing, and CTA",
                    "Write down the hook formula that appears most frequently",
                    "Save 5 videos as references you'll use when recording your own"
                ],
                resources: [
                    Resource(title: "How to Reverse-Engineer Viral TikTok Shop Videos", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+shop+viral+video+formula+reverse+engineer", duration: "16 min")
                ]
            ),
            Step(
                title: "Create Your First Test Video",
                description: "Your first video doesn't need to be perfect — it needs to exist. The only way to learn what works is to post and see what the algorithm does with it.\n\nUsing the hook formula you identified in step 4, record a 30–60 second video about one product from your niche. Show the product, explain one specific benefit, and end with a clear call to action: \"Link is in my bio\" or \"Click the product tag.\"\n\nPost it. Then watch the data.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Choose 1 product from your niche that you've seen perform well",
                    "Write a 3-sentence script: hook + 1 benefit + CTA",
                    "Film a 30–60 second vertical video — good lighting, clear audio",
                    "Add the product link and post it with 3–5 relevant hashtags"
                ],
                resources: [
                    Resource(title: "How to Film Your First TikTok Shop Affiliate Video (No Experience Needed)", type: .video, url: "https://www.youtube.com/results?search_query=first+tiktok+shop+affiliate+video+beginner", duration: "13 min")
                ]
            ),
            Step(
                title: "Understand the TikTok Algorithm",
                description: "TikTok's algorithm is different from every other platform. It doesn't show your content to your followers first — it shows it to a small test group and measures watch time, replays, and shares. If those metrics are good, it pushes the video to more people.\n\nThis means: a brand new account with zero followers can go viral on day 1. But it also means the first 3 seconds of your video are everything — if viewers swipe away immediately, the algorithm buries the video.\n\nUnderstanding this changes how you write hooks and structure your content.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Watch the algorithm video fully — take notes on the key ranking signals",
                    "Review your first video's analytics: watch time %, replays, shares",
                    "Identify your weakest metric and research how to improve it",
                    "Plan your next video with the algorithm's signals in mind"
                ],
                resources: [
                    Resource(title: "How the TikTok Algorithm Actually Works in 2025", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+algorithm+explained+2025+how+it+works", duration: "15 min")
                ]
            ),
            Step(
                title: "Build a Consistent Posting System",
                description: "One video won't build a business. Consistency is the only strategy that works on TikTok — and consistency requires a system, not willpower.\n\nThe goal: 1 video per day for the next 14 days. That sounds like a lot, but each video only needs to be 30–60 seconds. With a content template and a batch recording session, you can film 7 videos in 2 hours.\n\nSet up your posting schedule now, before motivation runs out.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Batch-record 5 videos in one session using your hook template",
                    "Set a daily posting time (7am–9am or 7pm–9pm perform best)",
                    "Create a simple content calendar: product per day for 14 days",
                    "Schedule your first 3 posts in advance using TikTok's scheduler"
                ],
                resources: [
                    Resource(title: "TikTok Content System for Affiliate Creators — Post Every Day Without Burnout", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+content+system+posting+schedule+affiliate", duration: "18 min")
                ]
            ),
            Step(
                title: "Optimize Your Product Selection",
                description: "After 7–14 days of posting, your analytics will tell you which products are getting clicks and which aren't. This data is your product strategy.\n\nThe goal of this step is to double down on what's working and cut what isn't. Some products just convert better than others — often because the price point is right, the product solves an obvious problem, or the product is visually satisfying on camera.\n\nSwap out your worst performers and add more products that match the profile of your best performer.",
                duration: 20,
                phase: .foundation,
                subtasks: [
                    "Open TikTok Shop analytics and sort products by click-through rate",
                    "Identify your top 2 performing products — what do they have in common?",
                    "Find 3 new products that match the same profile (price, category, problem-solved)",
                    "Remove products with zero clicks from your active promotions"
                ],
                resources: [
                    Resource(title: "How to Use TikTok Shop Analytics to Pick Better Products", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+shop+analytics+product+selection+affiliate", duration: "14 min")
                ]
            ),
            Step(
                title: "Scale With Proven Content",
                description: "Once you have a video that's performing — getting views, clicks, and sales — your job is to create more versions of that exact format.\n\nThis is called content scaling: you take the hook, the product angle, and the structure that worked, and apply it to similar products or from slightly different angles. You're not starting from scratch every time — you're iterating on a proven formula.\n\nThis is how TikTok Shop affiliates go from €0 to €1,000/month — not by finding new tricks, but by repeating what already works.",
                duration: 25,
                phase: .foundation,
                subtasks: [
                    "Identify your best-performing video from the last 2 weeks",
                    "Make 3 variations: same product angle, different hook",
                    "Make 2 variations: same hook format, different product in your niche",
                    "Post all 5 within the next 5 days and compare performance"
                ],
                resources: [
                    Resource(title: "TikTok Shop Scaling Strategy — From First Sale to Consistent Income", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+shop+affiliate+scaling+strategy+consistent+income", duration: "20 min")
                ]
            ),
            Step(
                title: "Build Your First Commission Pipeline",
                description: "You now have the system in place. This final step is about making it official: you have a real affiliate business running, not just a hobby account.\n\nA commission pipeline means you have multiple products actively getting clicks every day, your posting is consistent, and you can see a clear path from views → clicks → purchases → commissions.\n\nBy the end of today, your TikTok Shop dashboard should show active products, click data, and your first sales. If it doesn't yet — it will within the next 7 days if you've followed the system.",
                duration: 30,
                phase: .foundation,
                subtasks: [
                    "Confirm you have at least 10 active affiliate products linked across your videos",
                    "Check your TikTok Shop dashboard: clicks, GMV, and commission earned",
                    "Set your 30-day income goal and calculate how many sales/day you need",
                    "Commit to posting daily for 30 more days — the results compound after day 14"
                ],
                resources: [
                    Resource(title: "My First Month TikTok Shop Affiliate Income Report — What Actually Happened", type: .video, url: "https://www.youtube.com/results?search_query=tiktok+shop+affiliate+income+report+first+month", duration: "17 min")
                ]
            )
        ]
    }
}
