# Chirru Portfolio v2

A comprehensive, production-ready personal portfolio platform consisting of a public-facing website, a secure admin dashboard, and a robust REST API backend.

## 🌟 Features

- **Public Portfolio**: Dynamic display of projects, skills, education, and work experience.
- **Admin Dashboard**: Secure, authenticated interface to manage portfolio content via CRUD operations.
- **Responsive Design**: Mobile-first UI using Tailwind CSS and Framer Motion for smooth animations.

## 🛠️ Technology Stack

**Frontend (Public Portfolio)**
- Next.js (React)
- Tailwind CSS + Framer Motion
- Zod

**Frontend (Admin Dashboard)**
- Next.js (React)
- React Router DOM
- TanStack Query (React Query)
- React Hook Form + Zod
- Tailwind CSS + Framer Motion


## 📁 Architecture & Structure

```text
Chirru-Site-v2/
├── frontend/   # Public-facing portfolio website (React)
└── admin/      # Secure admin dashboard for content management (React)
```

## 🚀 Getting Started

### 1. Frontend (Public Portfolio) Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   npm run dev
   ```

### 2. Admin Dashboard Setup

1. Navigate to the admin directory:
   ```bash
   cd admin
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   npm run dev
   ```

## 🐳 Docker Deployment

To run the entire application stack using Docker Compose:

```bash
docker-compose up --build
```
*(Make sure your environment variables are correctly configured in your docker-compose or .env files)*

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
