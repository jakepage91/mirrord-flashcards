# mirrord-flashcards

A spaced-repetition flashcard app for learning **mirrord** deeply. Role-based profiles, streak tracking, GitHub/Google login via Supabase, and card-linked GitHub Discussion feedback.

## Features

- **88 curated cards** covering mirrord fundamentals, Kubernetes, networking, policy/governance, DevRel workflows, and business positioning
- **5 role-based profiles**: DevRel (all cards), HR / Non-Technical (basic only), Core Team (all minus operator), Product, Solutions Engineering
- **Spaced repetition** (SM-2 algorithm) with streak tracking
- **GitHub + Google login** via Supabase Auth (Google restricted to `@metalbear.co`)
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
3. Enable **Google** auth provider (restrict to `@metalbear.co` domain)
4. Run the SQL schema from the [setup guide](.claude/plans/indexed-moseying-sutherland.md) in the Supabase SQL editor
5. Copy your **Project URL** and **anon key**

### 2. Add repository secrets

Go to **Settings > Secrets and variables > Actions** in your GitHub repo and add:

| Secret | Value |
|--------|-------|
| `SUPABASE_URL` | Your Supabase project URL (e.g. `https://abcdefgh.supabase.co`) |
| `SUPABASE_ANON_KEY` | Your Supabase anon/public key (the `eyJ...` string from Settings > API) |

The deploy workflow injects these into `index.html` at build time — no secrets in source code.

### 3. Deploy

1. Push to `main`
2. In **Settings > Pages**, set source to **GitHub Actions**
3. The `.github/workflows/pages.yml` workflow injects Supabase config and deploys

### 4. Run locally

```bash
cp .env.example .env
# Edit .env with your Supabase values, then:
python3 -m http.server 8080
```

Note: for local dev you'll need to manually replace the placeholders in `index.html`, or use the deployed version. Supabase auth requires the OAuth redirect URL to match your deployment URL (add `http://localhost:8080` in Supabase > Authentication > URL Configuration > Redirect URLs).

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
