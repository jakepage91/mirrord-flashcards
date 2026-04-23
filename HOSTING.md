# Hosting plan

This app is intentionally static (`index.html` + `cards.json`), so hosting is very simple.

## Recommended default: GitHub Pages

### Why
- Free and easy for internal/public docs-style projects.
- No server runtime required.
- Works well for mobile access via a normal URL.

### What to host
- `index.html`
- `cards.json`
- `README.md` (optional, for repo docs)

### Deployment steps
1. Push this repo to GitHub.
2. In **Settings → Pages**, set source to **GitHub Actions**.
3. Add the workflow in `.github/workflows/pages.yml` (included in this repo).
4. After workflow succeeds, share the Pages URL.

## Alternate options

### Netlify
- Drag/drop deploy or connect repo.
- Build command: none
- Publish directory: repository root

### Vercel (static)
- Import repo.
- Framework preset: Other.
- Build command: none
- Output directory: `.`

### S3 + CloudFront
- Upload static files to S3 bucket.
- Enable static website hosting + CloudFront for TLS/CDN.

## Operational guidance

- The app stores progress in browser `localStorage`, so progress is device/browser-local.
- If you need cross-device continuity, use **Export progress** and **Import progress**.
- If embedding in internal portals, ensure `cards.json` is served with `application/json`.

## Suggested rollout

1. Start with GitHub Pages for speed.
2. Share URL with team and gather card quality feedback.
3. Move to Netlify/Vercel/S3 only if you need custom domain, auth, or stricter enterprise controls.
