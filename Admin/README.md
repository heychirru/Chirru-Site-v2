# Chirru Admin

The administrative CMS for the Chirru portfolio. It is a Next.js static export deployed as Cloudflare Worker assets.

## Local development

1. Install the locked dependencies with `npm ci`.
2. Copy `.env.example` to `.env.local` and set the local API and portfolio URLs.
3. Start the app with `npm run dev` (http://localhost:3001).



## Checks

- `npm run typecheck`
- `npm run lint`
- `npm audit --audit-level=high`
- `npm run build`

The admin is a static client application. Its API must allow the production admin origin through CORS and support the configured authentication cookie/token flow over HTTPS.
