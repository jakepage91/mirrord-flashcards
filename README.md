# mirrord-flashcards

A lightweight, phone-friendly spaced-repetition flashcard app for learning **mirrord** deeply through use cases, operations, policies, and feature behavior.

## What changed in this version

- Much deeper and more accurate flashcards, aligned to mirrord docs topics (incoming/outgoing traffic, filters, policies, sessions, profiles, copy target, targetless, troubleshooting, and chaos-style reliability prompts).
- Better emphasis on **what + why + step-by-step behavior** so answers are more useful for DevRel conversations.
- Built-in authoring workflow so you can add your own cards directly in the app.

## Why this project

This deck is designed for developer advocates and customer-facing engineers who need to explain mirrord clearly and accurately, even when not using it every day.

## Features

- Static app (`index.html`) — trivial hosting (GitHub Pages, Netlify, Vercel static, S3, etc.)
- Spaced repetition scheduling (SM-2 style)
- Due queue + optional “include new cards” mode
- Tag filtering + source filtering (core deck vs your custom cards)
- Local-first persistence in browser `localStorage`
- Import/export for progress and custom cards
- In-app "Add card" editor for continuously capturing new product knowledge

## Quick start

Open `index.html` directly, or serve locally:

```bash
python3 -m http.server 8080
```

Then open `http://localhost:8080`.

## Files

- `index.html` — app UI + scheduling + custom-card authoring
- `cards.json` — curated core deck

## Study guidance

For each card, answer in this order:
1. What feature/behavior is it?
2. Why would a team use it (or avoid it)?
3. How does it behave step-by-step at runtime?
4. What policy/safety constraints matter in production?

This style makes your answers stronger for demos, Q&A, and architecture conversations.


## Hosting plan

Recommended: **GitHub Pages** using the included workflow `.github/workflows/pages.yml`.

Why:
- zero backend, cheapest path
- easiest shareable URL for phone access
- automatic deploy on push

Fallback options: Netlify, Vercel static, or S3+CloudFront. See `HOSTING.md` for full rollout guidance.
