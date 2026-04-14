BeFree – Product Vision & MVP Scope

BeFree is Duolingo for online business.

The knowledge to build a profitable online business is free — it's on YouTube, in blog posts, in Reddit threads. The problem isn't access to knowledge. The problem is that nobody tells you which video to watch first, what to do immediately after, and how to keep going the next day.

BeFree solves this. It takes the best free content on the internet, structures it into a daily execution system, and makes sure you actually do the work instead of just watching more videos.

BeFree is designed to feel like:
	•	Duolingo → one action per day, fast feedback loop, streak-driven consistency
	•	Cal AI → minimal input, maximum output, fast to the value
	•	Apple Fitness → clear sessions, completion flow, motivating progress
	•	Quittr / Umax → focused on one outcome, nothing unnecessary

BeFree exists to solve one problem:
Beginners don't fail because they lack information. They fail because they never start, never stay consistent, and never know what to do next.

⸻

⭐ 1. Core Vision

The long-term vision of BeFree is to become the operating system for building an online business — a platform that combines the world's best free educational content with AI-powered execution tools that do the hard work for you.

In the full vision, BeFree will offer:
	•	Curated video + task roadmaps for every major online business model
	•	AI that does work for the user: finding nearby prospects, generating outreach scripts, validating niches
	•	Dynamic roadmaps that adapt to user speed and real-world results
	•	Community accountability tied to the roadmap — connect with people at the same step
	•	Results-based milestones: "users who complete this step typically land their first client within 3 weeks"
	•	Analytics: time invested, steps completed, estimated business readiness
	•	Monetization through a subscription tier

The end goal:
👉 BeFree becomes the one app you need to go from complete beginner to running a profitable online business — without paying for a single course.

⸻

⭐ 2. What the MVP Must Achieve (Primary Goal)

The MVP delivers one thing: the core execution loop.

Open app → Watch the right video → Do the one task → Mark done → Come back tomorrow

The user should never have to ask "what should I do next?" The answer is always one tap away.

The MVP covers the first 10 foundational steps of building an agency-style online business, with content tailored to the user's chosen model. Each step is one video + one action. Nothing more.

The user should feel:
	•	"I don't need to research anything — someone already found the best video."
	•	"I know exactly what to do right now."
	•	"I'm making real progress, not just learning."
	•	"I'm not paying for knowledge — I'm paying for structure and execution."

⸻

⭐ 3. MVP Feature Scope

✅ Included in MVP

Business Models

The MVP launches with 2 business models:
	•	AAA (AI Automation Agency) — the highest-growth B2B model in 2026, appeals to tech-forward users who want to build a premium service business
	•	TikTok Shop Affiliate — the fastest-growing consumer income model in 2026, zero startup capital, first commission possible within days

These two models were selected based on deep market research (April 2026): both are in their demand peak, both have strong YouTube educator communities, and they serve two distinct user personas — making the onboarding "AI-powered perfect match" feel genuinely personalized.

Recommendation logic:
	•	Complete beginners or side-income seekers → TikTok Shop Affiliate (lower barrier, faster first results)
	•	Experienced users or those building a full business / replacing their job → AAA (higher income ceiling, B2B focus)

Both models have completely different video content, tasks, and outputs across all 10 Foundation steps.

⸻

Foundation Roadmap (10 Steps — Video + Task format)

Each step follows a strict format:
	•	One curated YouTube video (embedded in-app via WKWebView — no external app switching, no downloads)
	•	One direct action task derived from the video
	•	One expected output: what the user will have produced by the end

Example — Step 2 (SMMA): Choose Your Niche
	•	VIDEO: "How to Pick a Profitable SMMA Niche in 2025" — 14 min
	•	TASK: Open Google Maps. Search "restaurant [your city]". Find 10 businesses with no or weak social media. Write their names down.
	•	OUTPUT: A list of 10 real potential clients in your area.

The 10 Foundation steps for both models:
	1.	Understand the Business Model
	2.	Choose Your Niche
	3.	Analyze Your Target Audience
	4.	Validate the Market
	5.	Create Your Value Proposition
	6.	Choose Your Primary Service
	7.	Build a Simple Online Presence
	8.	Create 3 Portfolio Examples
	9.	Write Your Outreach Script
	10.	Build Your First Prospect List

Step titles are universal. Videos, tasks, and outputs are specific to each model.

⸻

Results Timeline

Shown on the Roadmap screen as milestone markers at key steps:
	•	After Step 3: "You understand your market better than 90% of beginners who never research their audience."
	•	After Step 5: "You have a niche, a target client profile, and a clear value proposition."
	•	After Step 10: "You have everything you need to land your first client. Most users send their first outreach within 48 hours of completing this step."

These milestones set expectations, create motivation, and make the roadmap feel purposeful rather than arbitrary.

⸻

Onboarding Flow
	•	Welcome screen
	•	2-question questionnaire (experience level + primary goal)
	•	AI-powered "Perfect Match" model recommendation
	•	"See both models" option
	•	Model selection confirmation

⸻

Dashboard
	•	Greeting
	•	Streak bar (7 days)
	•	"Next Step" card with one-tap Start

The dashboard is intentionally minimal. The next action is always the most prominent element on screen.

⸻

Step Detail Screen
	•	Phase chip + Step title
	•	Embedded YouTube video (WKWebView, full-width, plays in-app)
	•	One-sentence task description
	•	Expected output ("By the end of this step you will have: [X]")
	•	"Ask your coach" button (AI coach, context-aware)
	•	"Mark as Done" button — no confirmation, instant completion with a success animation

No timer. No subtask checklist. No multiple resources. One video, one task, one button.

⸻

AI Step Coach
	•	Accessible via "Ask your coach" on the Step Detail screen
	•	Opens a bottom sheet chat interface
	•	Context-aware: knows the current step, the video content, and the user's business model
	•	Powered by OpenAI Chat Completions API (direct from app, no backend required)
	•	Responses are concise, actionable, and encouraging

⸻

Roadmap Screen
	•	Foundation section: all 10 steps with completion state
	•	Results Timeline milestones at key steps
	•	Later phases (Growth, Scale) shown but locked — coming soon

⸻

Notifications + Widgets
	•	Daily push notification at a configurable time: "Your next step is waiting. 15 minutes today."
	•	Home screen and lock screen widget: current step name + streak counter
	•	These are non-optional for the consistency loop — they are the Duolingo mechanic applied to business

⸻

Settings
	•	View and switch business model (SMMA ↔ AAA)
	•	Reset progress (with confirmation)

⸻

Monetization
	•	7-day free trial (full access, no credit card friction at start)
	•	€9.99 / month after trial (auto-renewal)
	•	€59.99 / year option prominently displayed (~50% savings — maximizes LTV)
	•	All Foundation steps accessible during trial; paywall activates after day 7

⸻

Persistence

Local saving via UserDefaults:
	•	Selected business model
	•	Completed steps
	•	Streak + streak days
	•	Notification preference

⸻

❌ Not in MVP

These belong to later versions:
	•	AI client-finder (location-based prospect discovery)
	•	AI-generated outreach scripts and niche reports
	•	Community / cohorts per step
	•	AI modifying the roadmap dynamically
	•	More business models (Growth OS, Brandscaling, etc.)
	•	Calendar sync
	•	Weekly analytics dashboard
	•	Advanced phases (Growth, Scale) with content

⸻

⭐ 4. The Core Loop (What the MVP Optimizes For)

	1.	Open BeFree
	2.	See today's next step
	3.	Watch the curated video in-app
	4.	Do the one task it describes
	5.	Mark as Done — success animation
	6.	Streak increases
	7.	Notification tomorrow: "Come back. 15 minutes. Your next step is ready."

Everything else is secondary.

⸻

⭐ 5. Design Principles

BeFree must feel:
	•	Fast — complete a step in 15–30 minutes, no longer
	•	Minimal — one thing at a time, always
	•	Clear — the next action is never ambiguous
	•	Motivating — progress feels real and visible
	•	iOS-native — smooth, premium, familiar
	•	Calm — removes overwhelm rather than adding features

⸻

⭐ 6. Post-MVP Roadmap

V1.1 — Community Layer
	•	Step-based community: users at the same step can message and support each other
	•	Cohort groups: weekly batches of users starting together
	•	This is the feature that turns retention from "I have a streak" to "people are counting on me"

V1.2 — AI Client-Finder
	•	Location permission → AI surfaces nearby businesses matching your niche profile
	•	One tap to add a business to your prospect list
	•	Removes the most friction-heavy step in the Foundation roadmap

V1.3 — More Business Models
	•	Growth Operating, Freelance Brandscaling, Dropshipping, SaaS
	•	Each follows the same Video + Task format — content is the cost, not the engineering

V1.4 — AI Execution Tools
	•	AI generates your outreach script based on your niche and value proposition
	•	AI validates your niche: "here's what the data says about demand in your area"
	•	AI writes your value proposition draft after Step 5

V2.0 — Dynamic AI Roadmap
	•	Roadmap adapts based on user speed, feedback, and real results
	•	If a user completes 3 steps in a day, AI unlocks bonus steps
	•	If a user hasn't opened the app in 5 days, AI adjusts the plan and sends a re-engagement sequence

⸻

⭐ 7. One-Sentence Summary

BeFree is Duolingo for online business — it takes the best free content on the internet and turns it into a daily execution system so you actually build your business instead of just learning about it.

⸻

⭐ 8. Figma Reference

This project uses the following Figma file as reference for all screens and components:

**File URL:**  
https://www.figma.com/design/OY0TNQAcozeiRogwr7IB5x/BeFree-Main-Frames?node-id=0-1&t=WXKPLdaMX55M2rj5-1

### Frame URLs

**Onboarding / PerfectMatch**  
https://www.figma.com/design/OY0TNQAcozeiRogwr7IB5x/BeFree-Main-Frames?node-id=11-2013&t=WXKPLdaMX55M2rj5-1

**Dashboard / Main**  
https://www.figma.com/design/OY0TNQAcozeiRogwr7IB5x/BeFree-Main-Frames?node-id=11-2111&t=WXKPLdaMX55M2rj5-1

**StepDetail / Base**  
https://www.figma.com/design/OY0TNQAcozeiRogwr7IB5x/BeFree-Main-Frames?node-id=14-3720&t=WXKPLdaMX55M2rj5-1

**Roadmap / Main**  
https://www.figma.com/design/OY0TNQAcozeiRogwr7IB5x/BeFree-Main-Frames?node-id=11-2823&t=WXKPLdaMX55M2rj5-1

**ComponentsScreen**  
https://www.figma.com/design/OY0TNQAcozeiRogwr7IB5x/BeFree-Main-Frames?node-id=25-4520&t=WXKPLdaMX55M2rj5-1
