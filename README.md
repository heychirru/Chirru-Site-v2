# Chirru Portfolio v2

A comprehensive, production-ready personal portfolio platform consisting of a public-facing website, a secure admin dashboard, and a robust REST API backend.

## 🌟 Features

- **Public Portfolio**: Dynamic display of projects, skills, education, and work experience.
- **Admin Dashboard**: Secure, authenticated interface to manage portfolio content via CRUD operations.
- **Authentication & Authorization**: JWT-based secure login utilizing Spring Security.
- **Media Management**: Seamless integration with Cloudinary for uploading and handling images.
- **Responsive Design**: Mobile-first UI using Tailwind CSS and Framer Motion for smooth animations.
- **Database Migrations**: Version-controlled database schema management using Flyway.

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

**Backend**
- Java 21
- Spring Boot 3.x
- Spring Security + JWT
- Spring Data JPA + Hibernate
- Flyway (Database Migrations)

**Database & Infrastructure**
- PostgreSQL
- Cloudinary (Media Storage)
- Docker & Docker Compose
- GitHub Actions (CI/CD)
- Nginx (Reverse Proxy)

## 📁 Architecture & Structure

```text
Chirru-Site-v2/
├── backend/    # Spring Boot REST API serving both frontend and admin
├── frontend/   # Public-facing portfolio website (React)
└── admin/      # Secure admin dashboard for content management (React)
```

## 🚀 Getting Started

### Prerequisites
- Java 21
- Node.js (v18+)
- PostgreSQL (or Docker to run via compose)
- Cloudinary Account (for image uploads)

### 1. Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Configure your environment variables (create an `application-dev.properties` or `.env` equivalent):
   - Database credentials (`spring.datasource.url`, etc.)
   - JWT Secret (`jwt.secret`)
   - Cloudinary credentials
3. Run the application:
   ```bash
   ./mvnw spring-boot:run
   ```

### 2. Frontend (Public Portfolio) Setup

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

### 3. Admin Dashboard Setup

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
