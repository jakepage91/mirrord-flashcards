# mirrord-flashcards

A phone-friendly spaced-repetition flashcard app for learning **mirrord** deeply, with simplified audience profiles and optional GitHub-authenticated feedback discussions.

## What’s new in this iteration

- Profile model simplified to **two profiles only**:
  - **Tech Beginners**
  - **HR / Non-Technical**
- Smart card metadata continues to drive filtering:
  - `tags`
  - `technicality` (`basic` / `intermediate` / `advanced`)
  - `audiences`
  - `tracks`
- Added **in-card quick explainer tooltips** for protocol/fundamental terms (e.g., UDP, TCP, OCI, DNS, TLS) when they appear in a card.

## Core capabilities

- Static app (`index.html`) with no runtime backend required for study.
- Spaced repetition scheduling and local progress persistence.
- Curated core deck (`cards.json`) plus custom card authoring.
- Profile filtering via `profiles.json`.
- Optional GitHub Device Flow login + create a Discussion tied to the current card.

## Weekly triage support

A scheduled workflow runs weekly and generates a digest of discussions that match `[card:` in the title:

- `.github/workflows/weekly-discussion-digest.yml`
- `scripts/weekly_discussion_digest.sh`

It uploads a markdown artifact listing card-linked discussion threads for review.

## Quick start

```bash
python3 -m http.server 8080
```

Open `http://localhost:8080`.

## Files

- `index.html` — app UI + profile filtering + tooltip explainers + scheduling + GitHub feedback integration
- `cards.json` — curated core deck with smart metadata
- `profiles.json` — two audience profile definitions
- `HOSTING.md` — hosting and rollout options
- `.github/workflows/pages.yml` — deploy static app to GitHub Pages
- `.github/workflows/weekly-discussion-digest.yml` — weekly discussion digest
- `scripts/weekly_discussion_digest.sh` — digest generator
