# mirrord-flashcards

A spaced-repetition flashcard app for learning **mirrord** deeply. Role-based profiles, streak tracking, GitHub/Google login via Supabase, and card-linked GitHub Discussion feedback.

## Features

- **88 curated cards** covering mirrord fundamentals, Kubernetes, networking, policy/governance, DevRel workflows, and business positioning
- **5 role-based profiles**: DevRel (all cards), HR / Non-Technical (basic only), Core Team (all minus operator), Product, Solutions Engineering
- **Spaced repetition** (SM-2 algorithm) with streak tracking
- **GitHub + Google login** via Supabase Auth (Google restricted to `@metalbear.com`)
- **Onboarding flow**: pick your role profile and daily cadence on first login
- **Cross-device sync**: progress, streaks, and custom cards stored in Supabase Postgres
- **GitHub Discussions integration**: open a discussion about any card directly from the app
- **In-card glossary tooltips** for terms like TCP, UDP, DNS, Kubernetes, TLS, CIDR
- **Dark/light mode** with OS preference detection
- **Custom card authoring** with import/export

## Setup

### 1. Supabase project

1. Create a project at [supabase.com](https://supabase.com)
2. Enable **GitHub** auth provider (create a GitHub OAuth App, add `public_repo` scope)
3. Enable **Google** auth provider (restrict to `@metalbear.com` domain)
4. Run the SQL schema from the [setup guide](.claude/plans/indexed-moseying-sutherland.md) in the Supabase SQL editor
5. Copy your **Project URL** and **anon key**

### 2. Configure the app

In `index.html`, replace the placeholder values:

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

### 3. Deploy

The app deploys as static files. GitHub Pages is included:

1. Push to `main`
2. In **Settings > Pages**, set source to **GitHub Actions**
3. The `.github/workflows/pages.yml` workflow handles deployment

### 4. Run locally

```bash
python3 -m http.server 8080
```

Open `http://localhost:8080`. Note: Supabase auth requires the OAuth redirect URL to match your deployment URL.

## Files

| File | Purpose |
|------|---------|
| `index.html` | Full app: UI, auth, spaced repetition, sync, Discussions |
| `cards.json` | 88 curated cards with metadata (tags, audiences, technicality) |
| `profiles.json` | 5 role-based profile definitions |
| `tokens.css` | Cloudforge design tokens (colors, type, spacing, dark mode) |
| `logo.png` | Mirror mascot brand mark |
| `HOSTING.md` | Hosting options and Supabase configuration notes |

## Profiles

| Profile | What you study | Technicality |
|---------|---------------|-------------|
| **DevRel** | All 88 cards | basic, intermediate, advanced |
| **HR / Non-Technical** | Value props, positioning, use cases | basic only |
| **Core Team** | Everything except operator-specific | basic, intermediate, advanced |
| **Product** | Use cases, positioning, governance | basic, intermediate |
| **Solutions Engineering** | Governance, policy, production, troubleshooting | basic, intermediate, advanced |

## CI/CD

- `.github/workflows/pages.yml` — deploy to GitHub Pages
- `.github/workflows/weekly-discussion-digest.yml` — weekly digest of card-linked Discussions
- `.github/workflows/conflict-marker-check.yml` — fail fast on unresolved merge markers
