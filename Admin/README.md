# Chirru Admin

The administrative CMS for the Chirru portfolio. It is a Next.js static export deployed as Cloudflare Worker assets.

## Local development

1. Install the locked dependencies with `npm ci`.
2. Copy `.env.example` to `.env.local` and set the local API and portfolio URLs.
3. Start the app with `npm run dev` (http://localhost:3001).

## Production build and deploy

`npm run build:production` builds with public HTTPS defaults for `https://api.chirru.in/api/v2` and `https://chirru.in`. These values are supplied to Next.js as process environment variables, so local `.env.local` values cannot accidentally be embedded in the static export. To use different production hosts, set `NEXT_PUBLIC_API_URL` and `NEXT_PUBLIC_SITE_URL` in the environment before running the command. The build rejects non-HTTPS and localhost values.

`npm run deploy` runs the production build and then deploys `dist/` using `wrangler.jsonc`. Wrangler must already be authenticated for the Cloudflare account. The Worker must have the production hostname or route attached in Cloudflare because `workers_dev` is disabled in this configuration.

## Checks

- `npm run typecheck`
- `npm run lint`
- `npm audit --audit-level=high`
- `npm run build:production`

The admin is a static client application. Its API must allow the production admin origin through CORS and support the configured authentication cookie/token flow over HTTPS.
