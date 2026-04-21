# BeFree — Figma Make Prompt Pack

> **Wie verwenden:** Erst `BeFree-MVP-Brief.md` als ersten Block in die Figma-Make-Session einfügen. Danach pro Screen einen der unten stehenden Prompt-Blöcke 1:1 reinkopieren — in der angegebenen Reihenfolge. Pro Block die Generierung abwarten und kurz prüfen, dass nichts aus der "Not in MVP"-Liste auftaucht, bevor du den nächsten Block startest.

> **Reihenfolge:**
> 0. Session-Opener (Brief + Auftrag)
> 1. Tokens & ComponentsScreen
> 2. Match-Screen (4 AI-States)
> 3. Roadmap
> 4. Dashboard
> 5. StepDetail (Watch + Do + Success)
> 6. Coach Sheet
> 7. Onboarding (Welcome + Experience + Goal + See-all-models + Confirmation)
> 8. Settings

---

## 0. Session Opener (paste FIRST, before everything else)

```
Du arbeitest an BeFree, einer iOS-App, die das Starten eines Online-Business als tägliches Execution-System abbildet (kein Kurs, kein Chatbot).

Ich habe dir oben ein "BeFree — MVP Design Brief" eingefügt. Halte dich strikt daran. Insbesondere:

- Die Phasen des Spines sind FIX: Foundation, Setup, Position, Launch, Scale. Keine anderen Phasen-Namen.
- Es gibt im MVP NUR ZWEI Business-Modelle: AAA (AI Automation Agency) und TikTok Shop Affiliate. Kein SMMA, kein Dropshipping, kein SaaS, kein anderes Modell — auch nicht als Platzhalter.
- Die "Not in MVP"-Liste in §8 des Briefs ist hart. Wenn dich etwas in diese Richtung verleitet, ignoriere die Versuchung.
- Design-Prinzipien: minimal, calm, iOS-native, eine Sache pro Screen.
- Dark Mode, Inter Font, Blue als Primärfarbe.

Ich werde dir jetzt nacheinander pro Screen einen Auftrag geben. Bei jedem Auftrag: ÜBERARBEITE den bestehenden Screen im Projekt. Erfinde keine zusätzlichen Screens, keine zusätzlichen Cards, keine zusätzlichen Sektionen — außer ich verlange es explizit.

Bestätige kurz, dass du den Brief gelesen hast und nach diesen Regeln arbeitest. Dann warte auf den ersten Screen-Auftrag.
```

---

## 1. Tokens & ComponentsScreen

```
Erster Auftrag: Überarbeite den ComponentsScreen und richte die Design-Tokens neu aus. Alles andere baut darauf auf.

DESIGN TOKENS (als Figma Variables anlegen, falls noch nicht vorhanden):

Colors — Base
- background: #0a0a0f
- cardBackground: #13131a
- border: #252530
- divider: #252530 @ 30% opacity

Colors — Text
- textPrimary: #e8e8f0
- textSecondary: #8b8b9a
- textTertiary: #8b8b9a @ 60%

Colors — Primary
- primaryBlue: #3b82f6
- secondaryBlue: #60a5fa
- primaryBlueOpacity: #3b82f6 @ 20%

Colors — Status
- success: #05df72 / successBg: #00c950 @ 20%
- warning: #fdc700 / warningBg: #f0b100 @ 20%
- error: #ff6467 / errorBg: #fb2c36 @ 20%

Colors — Phase (5 Phasen, jeweils fill / bg / border)
Du wählst harmonische Töne, die zueinander und zum Dark-Theme passen. Vorschlag (du darfst abweichen, aber die 5 Phasen müssen optisch klar unterscheidbar sein):
- Foundation — Blue
- Setup — Cyan/Teal
- Position — Purple
- Launch — Orange/Amber
- Scale — Green

Typography — Inter
- heading1 32 / heading2 24 / heading3 20
- body 16 / bodyMedium 16 medium / bodySemiBold 16 semibold
- caption 14 / small 12

Spacing scale: 4 / 8 / 12 / 16 / 20 / 24 / 48
Corner radius: sm 12 / md 16 / lg 20 / xl 24 / pill 999

COMPONENTSSCREEN — zeige in dieser Reihenfolge:

1. PhaseChip — 5 Varianten (Foundation, Setup, Position, Launch, Scale) × 3 States (active, completed, locked). Pill-Form, Phase-Icon links, Phase-Name rechts.
2. PrimaryButton — Blue gradient, 3 States (enabled, loading mit Spinner, disabled). Volle Breite, Höhe 56, corner radius md.
3. StepCard — 2 States (pending: Titel + Dauer + Right-Arrow; completed: Strikethrough Titel + Checkmark). KEIN Subtask-Counter, KEINE Resource-Chips.
4. StreakBar — 7 Tage horizontal (M T W T F S S unter den Tageskreisen), Tageskreis-States: future (leerer Kreis), today (gefüllter Kreis mit Outline-Highlight), completed (gefüllter Kreis mit Checkmark). Container mit cardBackground und border.
5. NextStepCard — Header-Label "Next Step" mit Bolt-Icon, Card mit: Titel (heading3), Beschreibung (caption, 2-3 Zeilen, ellipsis), Dauer-Pill (clock-Icon + "X min"), PrimaryButton "Start" mit Arrow-Icon.
6. ProgressBar — horizontale Bar mit Gradient-Fill (primaryBlue → secondaryBlue), Höhe 8, corner radius sm. Wird in Roadmap verwendet.
7. AICoachEntry — Card mit Sparkle-Icon-Container (gradient), Label "Ask your coach", Subtext "Get help with this step", Right-Chevron.

Streiche aus dem ComponentsScreen alle bisherigen Komponenten, die im MVP nicht vorkommen: Subtask-TaskCard, ResourceCard, StatCard, BenefitCard (es sei denn, du brauchst BenefitCard für die Onboarding-Match-Card — dann lass sie drin).

Bestätige danach mit dem fertigen ComponentsScreen.
```

---

## 2. Match-Screen (4 AI-States)

```
Nächster Auftrag: Match-Screen im Onboarding-Flow überarbeiten.

KONTEXT: Auf diesem Screen sieht der User das ihm empfohlene Business-Modell. Es gibt im MVP NUR zwei mögliche Modelle: AAA (AI Automation Agency) oder TikTok Shop Affiliate. SMMA und alle anderen Modelle existieren nicht.

LAYOUT (gemeinsam für alle 4 States):

Top:
- Status bar
- Progress bar (75%)
- Back-Button

Header:
- Großes Sparkle-Icon-Quadrat (gradient blue), zentriert
- Heading 1: "Perfect Match Found"
- Untertitel (textSecondary): "Your personalized business model is ready"

Modell-Card:
- Kleines Modell-Icon links, daneben Modell-Kürzel (z. B. "TIKTOK SHOP" oder "AAA") in primaryBlue/uppercase/tracking
- Modell-Vollname als bodySemiBold (z. B. "TikTok Shop Affiliate" oder "AI Automation Agency")
- DARUNTER: AI-Erklärungs-Bereich (variiert nach State — siehe unten)
- Benefit-Liste (3 Items): jeweils Icon-Container links, Benefit-Text Mitte, kleines Checkmark-Circle rechts. Beispiele für TikTok Shop: "Zero startup capital required", "First commission possible within days", "Huge and growing platform demand". Für AAA: "Cutting-edge technology", "Premium pricing justified", "Huge market demand in 2026", "Low competition vs. traditional agencies".

Bottom:
- PrimaryButton: "Start with TikTok Shop" oder "Start with AAA"
- TextButton darunter: "See all models"

DIE 4 STATES — bitte als 4 separate Frames, alle anderen Elemente identisch, nur der AI-Erklärungs-Bereich variiert:

State A — AI Loading:
An Stelle der Erklärung:
- Microcopy darüber (textSecondary, klein): "Personalisiere deine Empfehlung…"
- Linear Progress Bar (indeterminate, primaryBlue Gradient), volle Card-Breite, ca. 4px hoch
- KEIN Skeleton, keine Punkte, keine spinnenden Symbole — nur die Progress-Bar.

State B — AI Success:
An Stelle der Erklärung:
- 2–4 Sätze AI-generierter, personalisierter Text in body, textPrimary @ 90%
- Beispieltext für TikTok Shop: "Da du Side-Income mit minimalem Aufwand suchst und gerade erst startest, passt TikTok Shop perfekt zu dir. Du brauchst kein Startkapital, kannst innerhalb weniger Tage deine erste Provision verdienen, und das Modell verzeiht Lernkurven besser als andere."
- Kein "Read more", keine Action — nur Text.

State C — AI Error: Network:
An Stelle der Erklärung:
- Kleiner roter Warning-Icon links, daneben Meldung in caption / error-Farbe: "Netzwerkfehler. Verbindung prüfen."
- Direkt darunter ein kleiner Secondary-Button "Erneut versuchen" (Outline-Style, nicht der große PrimaryButton)
- Der "Start with …"-PrimaryButton bleibt unten weiterhin aktiv — der User soll nicht blockiert sein.

State D — AI Error: Not Reachable:
An Stelle der Erklärung:
- Sparkle-Off- oder Cloud-Off-Icon links, daneben Meldung in caption / textSecondary: "KI ist gerade nicht erreichbar."
- KEIN Retry-Button.
- Der "Start with …"-PrimaryButton bleibt unten weiterhin aktiv.

WICHTIG:
- Erfinde KEIN drittes Modell. Wenn du Beispieldaten brauchst, nimm TikTok Shop Affiliate.
- Der statische Beschreibungstext (z. B. "Earn commissions by creating short videos…") darf auf dem Match-Screen nicht erscheinen — die AI-Erklärung ersetzt ihn vollständig.
- Header, Benefits, CTA, "See all models" sind in allen 4 States identisch.
```

---

## 3. Roadmap

```
Nächster Auftrag: Roadmap-Screen überarbeiten.

LAYOUT:

Top:
- Standard NavBar mit Back-Arrow links
- Heading 1: "Your Roadmap"
- Untertitel (textSecondary): "Follow these steps to build your business"

Overall Progress Card:
- Card-Container, padding lg
- Linke Seite: "Overall Progress" als heading3 textPrimary, darunter Progress-Bar, darunter "X% completed" als caption textSecondary
- Rechte Seite oben: "n/m" als heading2 in primaryBlue (z. B. "3/12")

Phase-Sektionen — GENAU 5 Stück, in dieser Reihenfolge:

1. Foundation (Phase-Farbe Foundation)
2. Setup (Phase-Farbe Setup)
3. Position (Phase-Farbe Position)
4. Launch (Phase-Farbe Launch)
5. Scale (Phase-Farbe Scale)

Für JEDE der ersten 4 Phasen (Foundation, Setup, Position, Launch):
- Card-Header (collapsible, Chevron up/down rechts)
- Linker Akzent-Bar in der Phase-Farbe
- Titel: Phase-Name als heading3
- Untertitel (textSecondary): kurzer Phase-Untertitel, z. B. "Build the groundwork for your business" / "Prepare your tools and accounts" / "Define your niche and offer" / "Take your first real-world actions"
- Rechts oben im Header: n/m-Pill in Phase-Farbe (z. B. "3/3")
- Im expanded State: Liste von StepCards untereinander. Jede StepCard: Bullet links (Phase-Farbe), Card mit Checkmark/Empty-Circle, Step-Titel, Dauer-Pill mit clock-Icon. Completed Steps: Titel mit strikethrough.

Für die Scale-Phase (Sonderfall):
- Card-Header genauso, ABER:
- KEIN n/m-Pill rechts oben
- Stattdessen ein kleines Status-Pill in Phase-Farbe: "Ongoing after Launch"
- Im expanded State: Statt einer Step-Liste ein einzelner Hinweis-Block mit Icon (z. B. infinity oder repeat) und kurzer Erklärung: "Scale begleitet dich nach Launch — dein Coach hilft dir hier weiter und neue Steps kommen mit deinem Fortschritt dazu."

WICHTIG:
- KEIN "Coming Soon"-Stub für Spine-Phasen. Foundation–Scale sind alle Teil des MVP, keine ist gesperrt.
- KEIN "Setup"-Sub-Pill INNERHALB der Foundation-Sektion. Setup ist eine eigene Phase weiter unten, keine Subkategorie.
- Step-Titel dürfen Platzhalter sein, aber realistisch. Beispiele für Foundation/AAA: "Understand the Business Model", "Choose Your Niche", "Analyze Your Target Audience". Für Foundation/TikTok Shop: "Understand TikTok Shop Affiliate", "Set Up Your TikTok Creator Account", "Find Your Product Niche". KEINE generischen Titel wie "Define Business Idea" oder "Competitive Analysis".
- KEINE Subtask-Counts in StepCards. KEINE Resource-Chips.
```

---

## 4. Dashboard

```
Nächster Auftrag: Dashboard-Screen überarbeiten — drastisch vereinfachen.

LAYOUT (von oben nach unten, NICHTS dazwischen oder darunter):

1. Top-Row:
   - Links: kleines BeFree-Logo + "BeFree" als bodySemiBold
   - Rechts: kleiner Streak-Counter Pill mit Flame-Icon und Zahl (z. B. "7"). Pill mit cardBackground und border.

2. Greeting:
   - Heading 1 (textPrimary): "Good morning" / "Good afternoon" / "Good evening" je nach Tageszeit
   - Untertitel (body, textSecondary): "Let's build your business today."

3. StreakBar (7 Tage, M T W T F S S — heutige Tageskreis hervorgehoben). Wie im ComponentsScreen definiert.

4. Next Step Section:
   - Section-Label "Next Step" mit Bolt-Icon in primaryBlue
   - NextStepCard: Step-Titel (heading3), Beschreibung (callout, max 3 Zeilen), Dauer-Pill (clock-Icon + "X min"), PrimaryButton "Start" mit Arrow-Icon.

5. ENDE. Nichts darunter.

EXPLIZIT WEGLASSEN (war im alten Design vorhanden, ist im MVP raus):
- KEINE Progress-Card mit "25%", "X of Y steps completed" o. Ä.
- KEIN "Roadmap →"-Shortcut auf dem Dashboard (die Roadmap ist über die Tab-Bar erreichbar)
- KEINE "Stats", "Recent Activity", "Today's Focus", "Quick Actions" oder ähnliches
- KEINE zusätzlichen Cards irgendeiner Art

Begründung: Das Dashboard hat eine einzige Aufgabe — den nächsten Step prominent zu zeigen. Alles andere zieht Aufmerksamkeit weg und widerspricht dem Action-Compression-Prinzip.

State "All steps completed" (alternative Variante des Screens):
- Greeting + StreakBar wie oben
- Statt Next Step Section: zentrierte Success-Card mit großem Checkmark-Circle, "Congratulations!" als heading3, "You've completed all available steps" als body textSecondary.
```

---

## 5. StepDetail (Watch + Do + Success)

```
Nächster Auftrag: StepDetail-Screen überarbeiten. Drei Varianten als separate Frames: Watch-Phase, Do-Phase, Success-Overlay.

GEMEINSAMER HEADER (in Watch und Do identisch):
- NavBar links: Back-Button. Im Watch-State Label "Back". Im Do-State Label "Watch" (verweist zurück auf Video).
- KEIN "Step X/Y"-Counter. KEIN "Step 4/10". Wirklich entfernen.
- PhaseChip in der jeweiligen Phase-Farbe (z. B. "Setup")
- Daneben kleines Phase-State-Badge: im Watch-State "Watch" mit Play-Icon, im Do-State "Do" mit Checklist-Icon. Badge in primaryBlue mit Hintergrund primaryBlueOpacity.
- Step-Titel als heading1 (z. B. "Create Your Value Proposition")

WATCH-PHASE Frame:

- Header (siehe oben, mit "Watch"-Badge)
- Embedded Video Card:
  - Schwarzer Container, aspect ratio 16:9, corner radius md
  - Großer Play-Button-Circle in der Mitte (primaryBlue gradient)
  - Unter dem Play-Button-Circle innerhalb der Card: Video-Titel (caption textPrimary) und Dauer (small textSecondary)
- "While Watching" Section:
  - Section-Label "While Watching" mit Eye-Icon in primaryBlue, uppercase, tracking
  - Card mit Liste numbered Bullets (1, 2, 3 …): Nummern-Circle in primaryBlueOpacity links, Bullet-Text rechts. Beispiele: "Pay attention to how he narrows down from broad industry to specific niche", "Note the 3 criteria he uses to evaluate if a niche is profitable", "Listen for the example of a bad vs. good value proposition"
- Bottom-Sticky PrimaryButton: "Continue" mit Arrow-Icon

DO-PHASE Frame:

- Header (siehe oben, mit "Do"-Badge)
- Card "Your Task":
  - Section-Label "Your Task" mit Clipboard-Icon in primaryBlue
  - Card mit Task-Beschreibung (body textPrimary, 4-6 Zeilen), z. B.: "Write a clear value proposition for your AAA business. Define what specific AI automation you offer, who it's for, and what measurable result it delivers. Use this format: 'I help [target client] [achieve outcome] using [method].'"
- Card "Expected Output":
  - Section-Label "Expected Output" mit Box/Doc-Icon in primaryBlue
  - Card mit Output-Beschreibung in italic body textSecondary, z. B.: "A one-sentence value proposition and a short description of your ideal client's biggest pain point that your automation solves."
- AICoachEntry-Card (wie im ComponentsScreen): Sparkle-Icon-Container, "Ask your coach" / "Stuck or have a question? Get instant guidance.", Right-Chevron
- Bottom-Sticky PrimaryButton: "Complete" mit Checkmark-Icon

SUCCESS-OVERLAY Frame (wird kurz nach "Complete" über dem ganzen Screen eingeblendet):

- Halbtransparenter background (background @ 85%)
- Zentriert großer abgerundeter Quadrat-Container (96x96, corner radius xl) in successBg, mit großem weißen Checkmark in success-Farbe in der Mitte. Soft-Glow in success-Farbe um den Container.
- Darunter Text "Step Complete" als bodySemiBold textPrimary
- Keine Buttons — Overlay verschwindet automatisch nach ~0.9s und kehrt zum Dashboard zurück.

EXPLIZIT VERBOTEN:
- KEIN Subtask-Checklist-Block
- KEIN Timer
- KEIN "Step X/Y"
- KEINE Resource-Link-Cards
- KEINE "Related steps"-Carousel
```

---

## 6. Coach Sheet

```
Nächster Auftrag: Coach-Sheet (Bottom Sheet) für den AI Coach.

LAYOUT:
- Bottom Sheet, presentation detent medium und large erlaubt
- Drag-Indicator oben (Pill, textSecondary @ 30%)
- Header-Row: Sparkle-Icon-Container links (klein, gradient), Titel "Coach" als bodySemiBold, kleiner Untertitel-Text mit Step-Bezug ("Helping with: [Step Title]", caption textSecondary). Close-Button rechts (X-Icon).
- Chat-Bereich (scrollbar):
  - Assistant-Message-Bubble: cardBackground, corner radius md, links ausgerichtet, max width ~80%
  - User-Message-Bubble: primaryBlue gradient background, weißer Text, corner radius md, rechts ausgerichtet, max width ~80%
  - Typing-Indicator (3 Dots animiert) als Variante einer Assistant-Bubble
- Input-Row sticky am unteren Rand:
  - TextField mit cardBackground, corner radius pill, placeholder "Frag deinen Coach…"
  - Send-Button rechts daneben (Circle, primaryBlue gradient, Arrow-Up oder Send-Icon weiß)

EMPTY STATE (erstes Öffnen, noch keine Nachrichten):
- Statt leerer Chat-Liste: drei suggested-Question-Chips untereinander, zentriert. Beispiele:
  - "What's the goal of this step?"
  - "I'm stuck — can you give me an example?"
  - "How long should this take me?"
- Tap auf einen Chip füllt das Input-Feld mit dieser Frage (oder sendet sie direkt).

ERROR STATES:
- "AI not configured" (kein API-Key): freundliche Inline-Meldung statt Chat: "Der Coach ist gerade nicht erreichbar." mit kleiner technischer Hilfszeile darunter ("Add API key in settings" o. Ä.). KEIN Retry.
- "Network error": rote Inline-Meldung in der letzten Position: "Netzwerkfehler beim Senden." mit kleinem "Erneut versuchen"-Link rechts daneben.
- "Rate limit / API error": neutrale Meldung: "Coach ist überlastet. Bitte später erneut versuchen."

WICHTIG:
- Nur EIN Coach-Sheet pro Step. Keine Chat-History über Steps hinweg im UI.
- Keine "Save chat", "Export", "Share" Buttons.
- Keine Tabs / Sections im Sheet.
```

---

## 7. Onboarding (Welcome + Experience + Goal + See-all-models + Confirmation)

```
Nächster Auftrag: Onboarding-Flow überarbeiten — fünf Frames in Reihenfolge.

GEMEINSAM für alle Onboarding-Screens (außer Welcome):
- Top: Status Bar
- Direkt darunter: Linear Progress Bar (primaryBlue Gradient auf Track in border-Farbe)
- Darunter: Back-Button-Row (Circle-Button mit Chevron-Left, links ausgerichtet)
- Content darunter, Bottom-Sticky PrimaryButton

PROGRESS-WERTE:
- Welcome: keine Progress Bar
- Experience: 25%
- Goal: 50%
- Match (egal welche AI-State-Variante): 75%
- See all models: 75%
- Confirmation: 100%

FRAME 1 — Welcome:
- Voller Screen Hintergrund (background)
- Zentriert vertikal:
  - Großes BeFree-Logo (Sparkle-Icon, 88px Square, gradient blue, corner radius xl)
  - Heading "BeFree" (onboardingLogoMark, semibold, 44pt)
  - Tagline darunter (onboardingTagline, semibold, 22pt): "Your daily next step to launch your online business."
- Bottom: PrimaryButton "Get started" mit Arrow-Icon

FRAME 2 — Experience Question:
- Frage (onboardingQuestionTitle, bold, 30pt): "Where are you starting from?"
- Untertitel (body textSecondary): "This helps us pick the right path for you."
- Liste mit 3 Answer-Cards (volle Breite, cardBackground, border, corner radius md, padding lg). Tap selektiert die Card (Border zu primaryBlue, kleines Check-Icon erscheint rechts).
  - Card 1: Icon (z. B. seedling/sparkle), Titel "Complete beginner", Subtext "I haven't started anything yet."
  - Card 2: Icon (z. B. progress arrow), Titel "Some experience", Subtext "I've tried a few things but nothing stuck."
  - Card 3: Icon (z. B. trophy), Titel "Experienced", Subtext "I've built something before and want to scale."
- Bottom: PrimaryButton "Continue" (disabled solange nichts ausgewählt)

FRAME 3 — Goal Question:
- Frage: "What are you aiming for?"
- Untertitel: "We'll match the right business model to your goal."
- 3 Answer-Cards (gleicher Stil wie Experience):
  - Card 1: "Side income" / "An extra few hundred a month."
  - Card 2: "Full business" / "Build something real, full-time eventually."
  - Card 3: "Replace my job" / "Quit and live off this."
- Bottom: PrimaryButton "Continue"

FRAME 4 — Match (verweise auf Auftrag #2 — separat als 4 States bereits gebaut)

FRAME 5 — See All Models (über "See all models"-Button auf Match erreichbar):
- Heading 1: "All models"
- Untertitel: "Pick the one you want to start with."
- Liste mit GENAU 2 Cards (NICHT MEHR, NICHT WENIGER):
  - AAA-Card: Icon, Modell-Kürzel "AAA" in primaryBlue uppercase, Vollname "AI Automation Agency" als bodySemiBold, statische Beschreibung (2-3 Zeilen body textSecondary). Tap → springt zur Confirmation mit AAA.
  - TikTok Shop-Card: Icon, "TIKTOK SHOP" uppercase, "TikTok Shop Affiliate", statische Beschreibung. Tap → Confirmation mit TikTok Shop.
- KEINE weitere Card. KEINE "Coming soon"-Cards. KEINE Filter / Sort.

FRAME 6 — Confirmation:
- Großer Success-Checkmark-Container (gradient blue, 96x96, corner radius xl) zentriert oben
- Heading (onboardingConfirmationTitle, semibold, 36pt): "You're all set"
- Untertitel (body textSecondary, mehrzeilig): "Your roadmap is ready. Tomorrow you'll find your first step on the dashboard."
- Bottom: PrimaryButton "Open dashboard"

WICHTIG:
- Onboarding-Profil (Antworten auf Experience + Goal) wird intern gespeichert, aber NICHT in einem späteren UI sichtbar gemacht. Im Onboarding selbst sind die Antworten natürlich sichtbar (selektierte Card).
- KEIN "Skip"-Button. KEIN "I'll decide later". Onboarding ist linear pflicht.
```

---

## 8. Settings

```
Nächster Auftrag: Settings-Screen überarbeiten — extrem reduziert.

LAYOUT:
- NavBar mit Heading "Settings"
- Section "Business model":
  - Section-Label (caption uppercase tracking, textSecondary): "BUSINESS MODEL"
  - Card mit aktuellem Modell: Icon links, Modell-Kürzel + Vollname mittig, Right-Chevron rechts. Tap → öffnet ein Sheet/Picker mit den 2 MVP-Modellen (AAA, TikTok Shop). Auswahl wechselt das aktive Modell.
- Section "Progress":
  - Section-Label: "PROGRESS"
  - Card mit Titel "Reset progress", Untertext (caption textSecondary) "Removes all completed steps and your streak.", Right-Chevron oder Reset-Icon. Tap → Confirmation-Alert ("Are you sure? This cannot be undone.") mit "Reset" (destructive) und "Cancel".
- Optional: kleiner Footer-Bereich mit App-Version (very subtle, textTertiary, klein)

EXPLIZIT NICHT IM SETTINGS (im MVP):
- KEIN "Your Profile" / "Experience" / "Goal" Block. Das Onboarding-Profil bleibt intern.
- KEIN Notifications-Toggle (kommt erst, wenn Notifications shippen)
- KEIN Theme-Switcher
- KEIN Account / Login / Logout (kein Account-System im MVP)
- KEIN "Help" / "FAQ" / "Contact" Block
- KEIN "Rate the app" / "Share" Block
- KEIN Subscription / Paywall

Diese Striktheit ist gewollt — Settings soll ein 30-Sekunden-Screen sein, kein Marketingplatz.
```

---

## 9. Nach allen Screens — finale Quality-Check-Prompt

```
Letzter Auftrag: Quality-Check über alle bisher generierten Screens.

Bitte gehe alle Screens durch und prüfe, ob NICHTS aus der "Not in MVP"-Liste in §8 des Briefs versehentlich aufgetaucht ist. Falls ja, entferne es ohne Rückfrage.

Zusätzlich:
- Stelle sicher, dass nirgendwo das Wort "SMMA", "Dropshipping", "SaaS", "Freelance" oder ein anderes Modell außer AAA und TikTok Shop auftaucht.
- Stelle sicher, dass nirgendwo "Iterate" als Phasen-Name vorkommt — nur "Scale" ist erlaubt.
- Stelle sicher, dass auf dem Dashboard wirklich nur ein einziger Inhalts-Block (Next Step) sichtbar ist (plus Greeting und Streak).
- Stelle sicher, dass die 5 Phasen-Farben aus dem ComponentsScreen konsistent in Roadmap, PhaseChips und Step-Bullets verwendet werden.

Liste am Ende kurz auf, was du angepasst hast, oder bestätige, dass alles bereits konform war.
```

---

## Anhang — wenn etwas schiefläuft

Wenn die Figma-Make-AI etwas generiert, das gegen den Brief verstößt (z. B. wieder einen "SMMA"-Screen oder eine Subtask-Checkliste), reicht meist ein kurzer Korrektur-Prompt:

```
Stop. Das verstößt gegen den Brief: [konkretes Problem benennen]. Bitte korrigiere genau das, lass den Rest des Screens unverändert.
```

Wenn ein Screen komplett am Brief vorbei generiert wurde:

```
Verwirf diesen Screen-Entwurf und starte ihn neu. Der Brief und der ursprüngliche Auftrag gelten unverändert. Lies §8 des Briefs nochmal vor dem Neuversuch.
```
