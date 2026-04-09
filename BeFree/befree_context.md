BeFree – Product Vision & MVP Scope

BeFree is a guided execution app that helps beginners build and launch an online business through simple, actionable steps and a clean, motivating user experience. Unlike courses or content libraries, BeFree focuses entirely on daily progress, clarity, and one next step at a time.

BeFree is designed to feel like:
	•	Duolingo → clear progression and one action at a time
	•	Headway → short, digestible learning
	•	Apple Fitness → streaks, sessions, and completion flow
	•	Cal.ai / Umax → personalized business paths

BeFree exists to solve the biggest problem in the online business world:
Beginners don't need more information. They need structure, clarity, and consistent execution.

⸻

⭐ 1. Core Vision

The long-term vision of BeFree is to become a personal AI business coach that builds a complete business blueprint with the user, step by step.

In the full vision, BeFree will offer:
	•	Multiple business models (agencies, freelancing, digital products, etc.)
	•	Dynamic, AI-generated roadmaps that adapt to user skills and speed
	•	A business dashboard with analytics, habits, and weekly planning
	•	Deep AI coaching: niche validation, idea refinement, outreach coaching, scripts, content review
	•	A personal "creator operating system" for building and scaling any online business
	•	A full library of resources, scripts, templates, and guided walkthroughs
	•	Community accountability and challenges
	•	Monetization through a premium tier

The end goal:
👉 BeFree becomes the one app you need to go from beginner to a profitable business.

⸻

⭐ 2. What the MVP Must Achieve (Primary Goal)

The MVP is intentionally focused.
It delivers the core loop with genuine AI guidance — not a full AI coaching system, but enough to make the user feel supported and never stuck:

Open the app → See your next step → Complete it → Make progress → Ask your coach if you're stuck

The MVP should give beginners their first 10 foundational steps, tailored to their chosen business model, with a clean interface, clear guidance, a simple progression system, and an AI coach available at every step.

The user should feel:
	•	"I finally know what I need to do today."
	•	"This is simple."
	•	"I'm making real progress."
	•	"I'm being guided, not overwhelmed."
	•	"I can ask a question whenever I'm stuck."

⸻

⭐ 3. MVP Feature Scope

The MVP includes only the essential features needed for the Core Loop.

✅ Included in MVP

Business Models

The MVP launches with 4 beginner-friendly agency models:
	•	SMMA
	•	Growth Operating
	•	AI Automation Agency
	•	Freelance Brandscaling

All four share the same Foundation Roadmap structure, but with model-specific descriptions, subtasks, and guidance tailored to each model.

⸻

Foundation Roadmap (10 Steps — model-specific content)

A shared 10-step structure that every beginner needs, with content tailored to the chosen business model:
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

Step titles are universal. Descriptions, subtasks, and resources are tailored per business model.

⸻

Onboarding Flow
	•	Welcome
	•	Lightweight questionnaire
	•	"Perfect Match" recommended business model (UI only, based on questionnaire)
	•	"See all models" option
	•	Model selection confirmation

⸻

Dashboard
	•	Greeting + daily subheading
	•	Streak bar (7 days)
	•	"Next Step" card
	•	Start Button → leads to Step Detail with a Timer
	•	Progress bar

⸻

Step Detail Screen
	•	Title + Phase chip
	•	Model-specific description of the session
	•	Model-specific checklist of sub-tasks
	•	Resources (videos, templates, articles)
	•	Timer that starts when user begins the session
	•	AI Step Coach — "Ask your coach" button opens an in-session chat powered by OpenAI
	•	"Complete Step" button

The Step Detail page should feel like starting a workout session in Apple Fitness — clean, guided, focused. The AI coach is available as a tap-away assistant, never forced on the user.

⸻

AI Step Coach
	•	Accessible from the Step Detail screen via an "Ask your coach" button
	•	Opens a bottom sheet with a simple chat interface
	•	Context-aware: the coach knows the current step, its description, and the user's chosen business model
	•	Powered by OpenAI Chat Completions API (direct from the app, no backend required)
	•	Responses are concise, actionable, and encouraging
	•	API key stored locally in a gitignored Config.swift file

⸻

Roadmap Screen
	•	Overall progress
	•	Foundation section with all 10 steps (model-specific content)
	•	First Actions section with static placeholder tasks (AI-generated content in a future version)
	•	Steps can be marked complete
	•	Later phases Growth, Advanced shown but locked with a coming soon

⸻

Settings
	•	View and switch your selected business model at any time
	•	Option to reset progress (with confirmation)

⸻

Persistence

Local saving of:
	•	selected business model
	•	completed steps
	•	streak
	•	timer session tracking

(using UserDefaults)

⸻

❌ Not fully included in MVP

These features belong to the vision, not V1:
	•	AI-generated tasks (First Actions are static in MVP)
	•	AI modifying the roadmap
	•	Resource library (standalone tab)
	•	Calendar sync
	•	Advanced phases (Growth, Scale)
	•	Weekly analytics dashboard
	•	Community / challenges
	•	Monetization / premium tier

The MVP should stay small, sharp, and easy to ship.

⸻

⭐ 4. The Core Loop (What the MVP Optimizes For)

The MVP focuses entirely on the daily loop:
	1.	Open BeFree
	2.	See today's next step
	3.	Tap Start
	4.	Timer starts — user works through the session
	5.	User asks coach if they get stuck (optional)
	6.	User marks the step as complete
	7.	Dashboard + Roadmap update
	8.	Streak increases

Everything else is secondary.

⸻

⭐ 5. Design Principles

BeFree must feel:
	•	Calm
	•	Minimal
	•	Clear
	•	Helpful
	•	Motivating
	•	iOS-native
	•	Safe and premium

The app is designed to remove overwhelm, not add features.

⸻

⭐ 6. One-Sentence Summary

BeFree is the simplest way for beginners to build an online business — one clear step, one guided session, one daily win, and an AI coach that's always one tap away.

⭐ 7. Figma Reference

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
