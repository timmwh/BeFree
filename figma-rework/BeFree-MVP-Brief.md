# ARCHIVED — DO NOT USE AS SPEC

> **Status:** ARCHIVIERT. Dieses Dokument war der Brief für die initiale Figma-Make-Redesign-Session und hat seinen Zweck erfüllt. Die finalen Design- und Produktentscheidungen weichen an mehreren Stellen ab (u. a. Dashboard Greeting/Progress-Card, StepDetail Step-Counter, Match-Fehler-Handling, Profile-Screen mit Community-Identität, Tab-Bar-Labels).
>
> **Einzige Wahrheit für die Implementierung:**
>
> - Figma-File `lfZO2Z2U2xrX5G3QqeUpn2` ("BeFree-Main-Frames-V2") via MCP `user-Figma Desktop`.
> - Execution-Plan: [`.cursor/plans/figma_to_code_transfer_2f1dd452.plan.md`](../.cursor/plans/figma_to_code_transfer_2f1dd452.plan.md) — enthält alle finalen Produktentscheidungen im Abschnitt "Konfirmierte Produkt-Entscheidungen".
>
> Bitte diesen Brief nicht mehr konsultieren. Er wird nur zur historischen Referenz behalten, nicht gelöscht, damit die Entscheidungsentwicklung nachvollziehbar bleibt.

---

# BeFree — MVP Design Brief (Figma Make Edition — historisch)

---

## 0. One-line positioning

**BeFree is the execution interface for starting an online business.**
It takes your situation, recommends the right model, and turns internet and AI knowledge into the one next step you can actually do today.

BeFree is **Duolingo for online business** — a daily execution system. Not a course, not a content library, not a chatbot.

---

## 1. Core product principle

**AI tells users what to do. BeFree turns that into a structured, motivating, low-friction execution flow.**

Mechanism: **action compression.** BeFree takes the overwhelming complexity of "start an online business" and compresses it into the **smallest useful next action**. One step. One video. One task. Everything larger than that is deferred, hidden, or queued.

Every design decision must serve this compression.

---

## 2. Product Architecture (3 Layers)

### Layer 1 — Stable Spine (BeFree owns this)
A controlled, hardcoded roadmap with these phases:
- **Match** (in onboarding only — never appears in the in-app roadmap)
- **Foundation** — understand how the model works
- **Setup** — minimum tools, accounts, environment
- **Position** — niche, target customer, offer
- **Launch** — first real-world execution actions
- **Scale** — continuation after Launch (intentionally thin in MVP — see §3)

Every business model plugs into this same spine.

### Layer 2 — AI Personalization Layer (bounded)
**Only two AI touchpoints exist in MVP:**
1. **Recommendation explanation** on the Match screen — short, user-specific reasoning for *why* this model fits.
2. **AI Coach** inside each step — context-aware chat answering questions about the current step.

**Hard rules (non-negotiable):**
- AI **never** generates step titles, videos, phases, or roadmap order.
- AI **never** generates task variants, examples, or skip logic in MVP.
- Model recommendation itself is **rule-based** (deterministic) — only the *explanation copy* is AI-generated.

### Layer 3 — Execution UX (where BeFree wins)
- One next step, always visible
- One clear task per step
- Fast feedback loop (Mark Done → success animation → streak ticks)
- Low overwhelm — nothing extra on screen
- Visible progress and momentum

If BeFree nails only Layer 3, it still wins against "just use ChatGPT".

---

## 3. Roadmap Logic

Each business model is expressed as a set of **authored steps**, each step belonging to one phase in the spine. A step is always:
- One curated YouTube video (embedded in-app, plays inline — never opens YouTube app)
- **While watching** — required focus bullets: what to pay attention to in the video for this task
- One direct action task derived from the video
- One expected output: what the user will have produced by the end

**Scale phase note:** In MVP, Scale is intentionally thin. It is represented through step completion, coach reflection, and roadmap continuity — **not** through a dynamic feedback engine. In the Roadmap UI, Scale must be visible as part of the spine but should **not** show an `n/m` step counter (it has no fixed step list yet) — show it as ongoing/continuation instead.

---

## 4. MVP Scope

The MVP delivers one thing: the **core execution loop**.

> Open app → see the right next step → do the one task → mark done → come back tomorrow.

### Business Models (only 2)
- **AAA — AI Automation Agency**
- **TikTok Shop Affiliate**

There are **no other models** in MVP. SMMA, Dropshipping, SaaS, Freelance Brandscaling etc. are explicitly post-MVP and must not appear anywhere in the UI — not in onboarding, not in "see all models", not in placeholder screens.

### Onboarding (the Match phase, productized)
- **Welcome screen**
- **Experience question**
- **Goal question**
- **Match screen** with:
  - the recommended business model (rule-based selection)
  - **AI-generated personalized explanation** of *why* this model fits (the AI touchpoint)
  - "Start with [Model]" primary CTA
  - "See all models" secondary action
- **"See all models" picker** — shows only the 2 MVP models
- **Confirmation** screen

**Onboarding profile** (the answers to the experience/goal questions) is stored internally only. **Never shown in the UI** afterwards (no "Your Profile" section in Settings).

**Match recommendation rule:**
- Complete beginners or side-income seekers → **TikTok Shop Affiliate**
- Experienced users or those building a full business / replacing their job → **AAA**

### Match-Screen AI Explanation — 4 States to design
1. **Loading** — a progress bar at the position of the explanation text, with a short microcopy above (e.g. "Personalisiere deine Empfehlung…"). No skeleton, no streaming text, no fixed timer — just a progress bar that keeps the user engaged until the AI response is ready.
2. **Success** — the AI-generated text replaces the static model description. 2–4 sentences, personalized, concrete why-this-model.
3. **Error: network failure** — clear message ("Netzwerkfehler. Verbindung prüfen.") plus a small "Erneut versuchen" retry button, in place of the text. Match flow stays usable; "Start with [Model]" CTA remains active.
4. **Error: AI not reachable / no API key** — message like "KI ist gerade nicht erreichbar." No retry button. Silent fallback — the rest of the screen still works, the user can proceed with the rule-based recommendation.

The AI explanation **only appears on the Match screen**. The "See all models" picker continues to show the static, model-level descriptions.

### Dashboard (post-onboarding home)
- Greeting (good morning / afternoon / evening)
- 7-day streak bar
- **Next-Step card** — exactly one step shown: title, short description, duration in minutes, "Start" primary CTA
- **Nothing else.** No progress %, no stats row, no recent activity, no extra cards. The Next Step must dominate.

### Step Detail Screen (the most important screen)
Two-phase flow inside one screen: **Watch** → **Do**.

**Watch phase:**
- Phase chip (Foundation / Setup / Position / Launch / Scale) + step title
- Embedded YouTube video, full width, plays inline
- "While watching" — focus bullets (numbered or bulleted)
- "Continue" primary CTA → moves to Do phase

**Do phase:**
- Same phase chip + step title
- "Your Task" card — task description
- "Expected Output" card — "By the end of this step you will have: [X]"
- "Ask your coach" entry — opens the AI Coach bottom sheet
- "Complete" primary CTA → marks done, success animation, returns to Dashboard

**Strictly forbidden on this screen (post-MVP creep):**
- No subtask checklist
- No timer
- No "Step X of Y" counter
- No external resource links
- No related-content carousel

### Coach Sheet (AI Coach)
Bottom sheet chat. Reachable from the Do phase.
- Empty state: a couple of suggested first questions (so the input is never blank)
- Streaming or non-streaming text response — design must work either way
- Error state: "AI not configured" / "API error" message, the rest of the sheet stays usable

### Roadmap Screen
Phase-grouped view of all steps. Sections in this exact order:
1. **Foundation** — collapsible, shows `n/m` completion badge
2. **Setup** — collapsible, `n/m` completion
3. **Position** — collapsible, `n/m` completion
4. **Launch** — collapsible, `n/m` completion
5. **Scale** — visible as part of the spine, **no `n/m` counter**, instead an "Ongoing after Launch" or similar status text

Each phase has its own color (decided in Figma). Step rows show: completion checkmark, title, duration. Tapping a step opens its Step Detail.

**No "Coming Soon" placeholders for spine phases.** "Coming Soon" is only used elsewhere for future business models, not for spine phases.

### Settings
- Switch business model (AAA ↔ TikTok Shop)
- Reset progress (with confirmation)
- **Nothing else** in MVP. No profile, no notifications toggle (until notifications ship), no theme switcher.

### Persistence (internal only — not UI relevant)
- Selected business model
- Completed step IDs
- Streak + streak days
- Onboarding profile (experience + goal) — internal use for the AI explanation

---

## 5. Core Loop (what the MVP optimizes for)

1. Open BeFree
2. See today's next step
3. Watch the curated video in-app
4. Do the one task it describes
5. Mark as Done — success animation
6. Streak increases
7. Come back tomorrow

Everything else is secondary.

---

## 6. Design Principles

BeFree must feel:
- **Fast** — most steps land in 15–30 minutes
- **Minimal** — one thing at a time, always
- **Clear** — the next action is never ambiguous
- **Motivating** — progress feels real and visible
- **iOS-native** — smooth, premium, familiar
- **Calm** — removes overwhelm rather than adding features

---

## 7. What BeFree is and isn't

BeFree **is**:
- An execution system for starting an online business
- A clarity engine — turning "I want to start something" into "this is my next step"
- An action-compression product — smallest useful next action, every single day
- A structured interface for AI-driven business guidance

BeFree **is not**:
- A course or course marketplace
- A content library
- A generic AI chatbot
- A fully dynamic, AI-generated roadmap generator
- A "learn about business" app — it's a "do the business" app

---

## 8. Hard "Not in MVP" list (do NOT design these)

These belong to later versions and must **not** appear in the redesign:

- Fully dynamic AI-generated roadmaps
- AI-chosen task variants based on profile
- AI-driven skip logic
- AI-driven reordering of the roadmap
- AI client-finder / location-based prospect discovery
- AI-generated outreach scripts as standalone tools
- Community / cohorts / step chat
- Any business model **other than** AAA and TikTok Shop (no SMMA, no Dropshipping, no SaaS, no Freelance Brandscaling)
- Subtask checklists inside steps
- Step timers / "Step X of Y" counters
- External resource link cards inside steps
- Calendar sync
- Weekly analytics dashboard / stats screens
- Monetization / paywall UI
- Push notifications UI / widget UI
- Any "Your Profile" / experience-and-goal display in Settings

If the AI generation is tempted to add any of the above, treat it as a bug.

---

## 9. Final Spine — naming locked

The five post-Match phases — finalized for this redesign — are:

`Foundation` → `Setup` → `Position` → `Launch` → `Scale`

(The previous internal naming `Iterate` has been renamed to `Scale`. The semantic stays the same: in MVP, Scale is the thin "ongoing" phase after Launch — not a heavyweight new section.)

These five names are the **only** phase names allowed in the UI.
