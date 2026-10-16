# Chirru Site v2 🚀

[![Next.js](https://img.shields.io/badge/Next.js-15%2F16-black?style=flat&logo=next.js)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-19-blue?style=flat&logo=react)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?style=flat&logo=typescript)](https://www.typescriptlang.org/)
[![Cloudflare Workers](https://img.shields.io/badge/Cloudflare-Workers-F38020?style=flat&logo=cloudflare)](https://workers.cloudflare.com/)
[![TailwindCSS](https://img.shields.io/badge/Tailwind-CSS-38B2AC?style=flat&logo=tailwind-css)](https://tailwindcss.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

The official web ecosystem and portfolio platform for **Chiranjit Das** ([chirru.in](https://www.chirru.in/)).

This repository is structured as a multi-app workspace containing both the public-facing portfolio website and the administrative content management system (CMS), designed for edge performance and deployed onto Cloudflare Workers.

---

## 📑 Table of Contents

- [Architecture Overview](#-architecture-overview)
- [Repository Structure](#-repository-structure)
- [Applications](#-applications)
  - [1. Frontend Portfolio (`/frontend`)](#1-frontend-portfolio-frontend)
  - [2. Admin Dashboard & CMS (`/admin`)](#2-admin-dashboard--cms-admin)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation & Environment Setup](#installation--environment-setup)
- [Development Workflow](#-development-workflow)
- [Build & Deployment](#-build--deployment)
  - [Frontend Deployment (OpenNext + Cloudflare Workers)](#frontend-deployment-opennext--cloudflare-workers)
  - [Admin Deployment (Static Export + Cloudflare Worker Assets)](#admin-deployment-static-export--cloudflare-worker-assets)
  - [Continuous Integration & Deployment (CI/CD)](#continuous-integration--deployment-cicd)
- [Author & Connect](#-author--connect)

---

## 🏛️ Architecture Overview

```text
                           ┌─────────────────────────────────────────┐
                           │            External Users / Web         │
                           └────────────────────┬────────────────────┘
                                                │
                                                ▼
       ┌─────────────────────────────────────────────────────────────────────────────────┐
       │                               Cloudflare Edge                                   │
       │                                                                                 │
       │   ┌───────────────────────────────────┐     ┌───────────────────────────────┐   │
       │   │         Frontend Worker           │     │         Admin Worker          │   │
       │   │  (Next.js via @opennextjs/cf)     │     │  (Static SPA Worker Assets)   │   │
       │   │       www.chirru.in               │     │             │   │
       │   └─────────────────┬─────────────────┘     └───────────────┬───────────────┘   │
       └─────────────────────┼───────────────────────────────────────┼───────────────────┘
                             │                                       │
                             ▼                                       ▼
                       ┌───────────────────────────────────────────────────┐
                       │               REST API Backend                    │
                       │           (Profile, Projects, CMS, Auth)          │
                       └───────────────────────────────────────────────────┘
```

---

## 📂 Repository Structure

```text
Chirru-Site-v2/
├── .github/
│   └── workflows/
│       ├── ci-frontend.yml        # CI pipeline for frontend (lint, typecheck, build)
│       ├── deploy-frontend.yml    # Auto-deployment of frontend to Cloudflare Workers
│       └── deploy-admin.yml       # Auto-deployment of admin CMS to Cloudflare Workers
│
├── frontend/                      # Public portfolio web application
│   ├── src/
│   │   ├── app/                   # Next.js App Router (pages, layout, metadata)
│   │   ├── components/            # Reusable UI components & animations
│   │   ├── lib/                   # API clients & server utilities
│   │   └── types/                 # TypeScript interfaces (models & API responses)
│   ├── open-next.config.ts        # OpenNext Cloudflare adapter configuration
│   ├── wrangler.jsonc             # Cloudflare Workers configuration for frontend
│   └── package.json
│
├── admin/                         # Administrative dashboard & CMS
│   ├── src/
│   │   ├── features/              # Feature modules (projects, media, skills, etc.)
│   │   ├── components/            # Shared admin UI components
│   │   └── lib/                   # API & state management helpers
│   ├── app/                       # Next.js entrypoint for static export
│   ├── wrangler.jsonc             # Cloudflare Workers configuration for admin assets
│   └── package.json
│
└── README.md                      # Project root documentation
```

---

## 💻 Applications

### 1. Frontend Portfolio (`/frontend`)

The primary public-facing personal website showcasing background, projects, work experience, education, and articles.

- **Routing Structure:**
  - `/` — Hero section, featured projects, experience highlights, and skills summary
  - `/about` — Bio, career history, philosophy, and background
  - `/projects` — Full project catalog with filtering and search
  - `/projects/[slug]` — Deep-dive case studies for specific projects
  - `/experience` — Detailed career timeline and impact
  - `/contact` — Direct contact inquiry form
  - `/robots.txt` & `/sitemap.xml` — Dynamically generated SEO assets
- **Key Capabilities:**
  - Dynamic Server-Side Rendering (SSR) and Client Components with React 19.
  - Interactive UI with fluid animations powered by **Framer Motion** and **Lucide Icons**.
  - Strict type safety with **TypeScript** and validation using **Zod**.
  - Optimized for Cloudflare Workers edge runtime via `@opennextjs/cloudflare`.

### 2. Admin Dashboard & CMS (`/admin`)

A dedicated administrative portal for managing all content, media, credentials, and settings across the portfolio.

- **Integrated Feature Modules:**
  - 📊 **Dashboard & Analytics** — Real-time visitor counts, traffic statistics, and analytics events.
  - 💼 **Projects & Case Studies** — CRUD management for project details, tech stack tags, and links.
  - 📜 **Experience & Education** — Career milestones, role descriptions, and academic credentials.
  - 🛠️ **Skills & Tags** — Technical competencies, categories, and taxonomy management.
  - 📁 **Media Library** — Asset management and upload workflows.
  - 📬 **Messages** — Inbound contact form submissions and inquiry tracking.
  - 📄 **Resumes** — Resume versioning and downloadable document management.
  - 🛡️ **Audit Logs & Settings** — Administrative activity tracking, security, and profile metadata.
- **Key Capabilities:**
  - Fast client-side data synchronization using **TanStack React Query**.
  - Validated forms with **React Hook Form** and **Zod**.
  - Exported as a high-performance static client application deployed directly to Cloudflare Worker assets.

---

## 🛠️ Tech Stack

| Category | Frontend | Admin CMS |
| :--- | :--- | :--- |
| **Framework** | Next.js (App Router) | Next.js (Static Export) |
| **Runtime / UI** | React 19 | React 19 |
| **Language** | TypeScript | TypeScript |
| **Styling** | TailwindCSS & Custom CSS | TailwindCSS & Custom CSS |
| **Animation / Icons** | Framer Motion, Lucide React | Framer Motion, Lucide React |
| **Data Fetching** | Native Fetch / Server API | TanStack React Query |
| **Form Handling** | Controlled Forms & Zod | React Hook Form & Zod |
| **Linter** | Oxlint | Oxlint |
| **Hosting & Edge** | Cloudflare Workers (`@opennextjs/cloudflare`) | Cloudflare Workers (Static Assets) |

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed locally:
- [Node.js](https://nodejs.org/) (version `20.x` or higher recommended)
- [npm](https://www.npmjs.com/) (version `10.x` or higher)
- [Cloudflare Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/) (optional for local deployment)

---

### Installation & Environment Setup

#### 1. Configure Frontend

Navigate to the `frontend` directory and install dependencies:

```bash
cd frontend
npm install
```

Create a local environment file:

```bash
cp .env.example .env.local
```

Populate the required environment variables in `frontend/.env.local`:

```env
# URL of your REST API backend
NEXT_PUBLIC_API_URL= Backend API url here
```

#### 2. Configure Admin CMS

In another terminal, navigate to the `admin` directory and install dependencies:

```bash
cd admin
npm install
```

Create a local environment file:

```bash
cp .env.example .env.local
```

Populate the required environment variables in `admin/.env.local`:

```env
# REST API backend URL
NEXT_PUBLIC_API_URL= Backend api url here

# Public portfolio origin (for CORS & preview redirects)
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

---

## 💻 Development Workflow

### Starting Dev Servers

- **Frontend Development Server (Port 3000):**
  ```bash
  cd frontend
  npm run dev
  ```
  Accessible at [http://localhost:3000](http://localhost:3000).

- **Admin CMS Development Server (Port 3001):**
  ```bash
  cd admin
  npm run dev
  ```
  Accessible at [http://localhost:3001](http://localhost:3001).

### Quality Assurance & Linting

Both applications use **TypeScript** for compile-time type verification and **Oxlint** for ultra-fast static analysis:

```bash
# In frontend/ or admin/:
npm run typecheck    # Run TypeScript compiler checks without emitting files
npm run lint         # Run Oxlint checks
```

---

## 📦 Build & Deployment

### Frontend Deployment (OpenNext + Cloudflare Workers)

The frontend is converted into an edge-compatible Cloudflare Worker using `@opennextjs/cloudflare`.

```bash
cd frontend

# 1. Build Next.js & OpenNext Cloudflare bundle
npm run build:cf

# 2. Deploy to Cloudflare Workers
npx wrangler deploy
```

### Admin Deployment (Static Export + Cloudflare Worker Assets)

The admin dashboard is exported into pure static assets (`dist/`) and served globally via Cloudflare:

```bash
cd admin

# 1. Export static build
npm run build

# 2. Deploy to Cloudflare Worker assets
npx wrangler deploy
```

### Continuous Integration & Deployment (CI/CD)

Automated deployments are handled via GitHub Actions in `.github/workflows/`:

- **Frontend CI (`ci-frontend.yml`)**: Executes TypeScript checks, Oxlint, and verification builds on pull requests and pushes to `next-js`.
- **Frontend Deploy (`deploy-frontend.yml`)**: Builds via OpenNext and deploys to Cloudflare Workers when commits land on `main` affecting `frontend/**`.
- **Admin Deploy (`deploy-admin.yml`)**: Runs type checks, linter, builds static exports, and publishes to Cloudflare Workers when commits land on `main` affecting `admin/**`.

---

## 👤 Author & Connect

**Chiranjit Das**

- 🌐 Website: [https://www.chirru.in/](https://www.chirru.in/)
- 🐙 GitHub: [@heychirru](https://github.com/heychirru)
- 💼 LinkedIn: [Chiranjit Das](https://www.linkedin.com/in/heychirru/)

---

## 📄 License

This project is licensed under the **MIT License** for all software code and architecture — see the [LICENSE](./LICENSE) file for details.

> [!NOTE]
> All personal content, bio, project write-ups, resume data, personal photographs, brand identity, and trademarks (including "Chiranjit Das" and "Chirru") are proprietary and copyrighted by Chiranjit Das. All rights reserved.
