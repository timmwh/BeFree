# BeFree — MVP-Release-Notizen (Maintainer)

Persönliche Checkliste. **Produkt-Scope (MVP + langfristig)** steht in [`BeFree/befree_context.md`](../BeFree/befree_context.md) — dort sind Push, Widgets, Monetarisierung (Hard Paywall, optional erste X gratis als `{ }`-Idee) und eine stabilere Formulierung (wenig Implementations-/Frame-Details) bereits eingepflegt.

---

## `befree_context.md` — Stand

- [x] MVP-Scope mit Push, Widgets, Monetarisierung abgeglichen; volatile UI-/Tech-Details reduziert; §12 nur noch Figma-File-URL.
- [ ] Nach **finalem** Redesign einmal querlesen: passt Spine/Copy noch zu dem, was ihr shippt? (kein Pflicht-Edit, nur Sanity-Check.)

---

## Roadmap-Content

- [ ] Gesamten Roadmap-Content kuratieren (Qualität, Konsistenz).
- [ ] Beide Business-Modelle: authored Steps über Spine bis Launch; gelockte / „coming soon“-Bereiche klar und ehrlich.
- [ ] Pro Step: Video, „While watching“, Task, Expected output — einheitlich gut.
- [ ] Edge Cases: tote YouTube-Links, sehr lange Titel, fehlende Felder — Fallback oder Fix-Liste.

---

## Step Detail / Execution (`StepDetailView`)

- [ ] View optimieren (Performance, Lesbarkeit, States).
- [ ] **„Do“-Bereich:** motivierender, klarer zur **Execution** (Microcopy, Struktur, ggf. kleine UX-Experimente).
- [ ] Core Loop spürbar: wenig Reibung bis „Mark as Done“.

---

## Onboarding (bewusst zuletzt)

- [ ] Welcome, Fragebogen, Modell-Empfehlung (Regel + AI-Erklärung), Bestätigung, „See all models“.
- [ ] Copy und Erwartungen an **Paywall** / Gratis-Kontingent abstimmen (kein Widerspruch zur ersten Nutzererfahrung).

---

## Push & Widgets (MVP)

- [ ] **Push:** Permission-Flow, Copy, Timing (z. B. nächster Schritt / Streak), Einstellungen (an/aus), Ruhezeiten falls gewünscht.
- [ ] **Widgets:** welche Infos (nächster Step, Streak, Fortschritt); Deep-Link zurück in die App.
- [ ] Mit **Persistence** und „next step“-Logik abgleichen — Widget/Push zeigen konsistenten Zustand.

---

## Monetarisierung (MVP)

- [ ] **Paywall-Placement** final festlegen und in `befree_context.md` die `{ }`-Zeile zu „nach Onboarding vs. nach erstem Step“ ersetzen, sobald entschieden.
- [ ] **Erste X Nutzer:innen gratis** (falls ihr das nutzt): wie zählen (Remote Config / Server / …), was passiert bei X.
- [ ] StoreKit / Abo oder Einmalkauf — Produkte in App Store Connect, Sandbox-Tests, Restore-Käufe.
- [ ] **Privacy & Store:** Datenauskunft zu Käufen; Support- und ggf. AGB-Link.

---

## AI & Konfiguration

- [ ] Lokale `Config.swift` / Keys; nie Commits mit echten Secrets.
- [ ] Fehlerzustände Coach + Onboarding-Erklärung (Offline, API-Fehler, leere Antwort) — kurze, ehrliche UI.

---

## Qualität & Geräte

- [ ] Core Loop hart testen: Modellwechsel, Reset, Streak (Mitternacht, Zeitzone), Mark Done.
- [ ] Barrierefreiheit (Smoke): Dynamic Type, VoiceOver auf Hauptflows.
- [ ] TestFlight mit mehreren Tester:innen; beide Modelle und realistische erste Session/Woche.

---

## Compliance & Launch

- [ ] Privacy Policy + App Privacy-Deklaration (Onboarding, AI-Anbieter, Käufe).
- [ ] App Store Listing: Screenshots, Beschreibung, Altersfreigabe, Support-URL — AI-Claims an **bounded AI** im Produkt halten.

---

## Kurz: erledigt wenn

MVP = zuverlässiger **Execution Loop** + **Roadmap-Content** + **Onboarding** + **Push/Widgets** + **Paywall** + **Store-/Privacy-Minimum**, und **`befree_context.md`** bleibt die Single Source of Truth für Scope (nach großen Produkt-Entscheidungen dort nachziehen, nicht in diesem Notiz-File duplizieren).
