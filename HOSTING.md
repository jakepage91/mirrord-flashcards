# Hosting plan

This app is static (`index.html` + `cards.json`), so host it as static files.

## Recommended default: GitHub Pages

### Why
- Free and fast for this type of app
- Easy URL sharing (including phone usage)
- Works directly with repository workflows

### Deployment
1. Push repo.
2. Enable GitHub Pages with GitHub Actions.
3. Use `.github/workflows/pages.yml`.

## GitHub OAuth + Discussions notes

Because the app is static, it uses **GitHub OAuth Device Flow** in-browser:
- Requires OAuth app with Device Flow enabled.
- Uses Client ID (no client secret in frontend).
- Stores user token in browser localStorage.

If your security posture requires not storing tokens in the browser, move this flow behind a backend service.

## Weekly review flow

The workflow `.github/workflows/weekly-discussion-digest.yml` runs weekly and scans Discussions for titles containing `[card:`.

Output:
- `weekly-discussion-digest.md` artifact with recent card-linked discussion status.

This is the first step toward automatic actioning (open tasks, update cards, close stale discussions).

## Alternate static hosts

- Netlify (publish root)
- Vercel static (output `.`)
- S3 + CloudFront


## Content model note

When hosting, ensure `profiles.json` is served alongside `index.html` and `cards.json`, since role-based packs depend on it.
