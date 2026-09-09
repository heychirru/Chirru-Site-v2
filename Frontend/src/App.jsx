import { useState, useEffect } from 'react'
import { useQuery } from '@tanstack/react-query'
import { portfolioApi } from './api'
import Navbar from './components/Navbar'
import ResponsiveMenu from './components/ResponsiveMenu'
import Hero from './components/Hero'
import About from './components/About'
import Project from './components/Project'
import Internship from './components/Internship'
import Education from './components/Education'
import Contact from './components/Contact'
import Footer from './components/Footer'
import Toast from './components/Toast'

export default function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [toasts, setToasts] = useState([])

  // Theme state: default light (Neumorphic Soft-Tech) with persistence
  const [theme, setTheme] = useState(() => {
    return localStorage.getItem('chirru_theme') || 'light'
  })

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('chirru_theme', theme)
  }, [theme])

  function toggleTheme() {
    setTheme((prev) => (prev === 'dark' ? 'light' : 'dark'))
  }

  // Toast notification manager
  function showToast(message, type = 'info') {
    const id = Date.now().toString(36) + Math.random().toString(36).substring(2, 6)
    setToasts((prev) => [...prev, { id, message, type }])
    setTimeout(() => {
      setToasts((prev) => prev.filter((t) => t.id !== id))
    }, 4000)
  }

  function dismissToast(id) {
    setToasts((prev) => prev.filter((t) => t.id !== id))
  }

  // Escape key listener for closing drawers
  useEffect(() => {
    function handleKeyDown(e) {
      if (e.key === 'Escape') {
        setMenuOpen(false)
      }
    }

    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [])

  // Public portfolio queries
  const profileQuery = useQuery({ queryKey: ['profile'], queryFn: portfolioApi.profile })
  const projectsQuery = useQuery({ queryKey: ['projects'], queryFn: portfolioApi.projects })
  const skillsQuery = useQuery({ queryKey: ['skills'], queryFn: portfolioApi.skills })
  const experienceQuery = useQuery({ queryKey: ['experience'], queryFn: portfolioApi.experience })
  const educationQuery = useQuery({ queryKey: ['education'], queryFn: portfolioApi.education })
  const certificationsQuery = useQuery({ queryKey: ['certifications'], queryFn: portfolioApi.certifications })
  const socialLinksQuery = useQuery({ queryKey: ['socialLinks'], queryFn: portfolioApi.socialLinks })
  const seoQuery = useQuery({ queryKey: ['seo', 'home'], queryFn: () => portfolioApi.seo('home') })

  // Track initial page view analytics event
  useEffect(() => {
    portfolioApi.trackEvent('page_view', { path: '/' })
  }, [])

  // Apply SEO metadata dynamically
  useEffect(() => {
    const seo = seoQuery.data
    const profile = profileQuery.data
    if (seo?.title) {
      document.title = seo.title
    } else if (profile?.name) {
      document.title = `${profile.name} · Software Developer Portfolio`
    }

    if (seo?.description) {
      let metaDesc = document.querySelector('meta[name="description"]')
      if (!metaDesc) {
        metaDesc = document.createElement('meta')
        metaDesc.name = 'description'
        document.head.appendChild(metaDesc)
      }
      metaDesc.content = seo.description
    }
  }, [seoQuery.data, profileQuery.data])

  const profile = profileQuery.data || {}
  const projects = projectsQuery.data || []
  const skills = skillsQuery.data || []
  const experience = experienceQuery.data || []
  const education = educationQuery.data || []
  const certifications = certificationsQuery.data || []
  const socialLinks = socialLinksQuery.data || []

  return (
    <div className="portfolio-app">
      {/* Background Ambience Elements */}
      <div className="ambient-background">
        <div className="ambient-glow-1" />
        <div className="ambient-glow-2" />
        <div className="ambient-glow-3" />
        <div className="ambient-grid" />
      </div>

      {/* Navigation */}
      <Navbar
        onMenu={() => setMenuOpen(true)}
        theme={theme}
        onToggleTheme={toggleTheme}
      />

      <ResponsiveMenu
        open={menuOpen}
        onClose={() => setMenuOpen(false)}
        theme={theme}
        onToggleTheme={toggleTheme}
        socialLinks={socialLinks}
      />

      {/* Main Content Sections */}
      <main>
        <Hero
          profile={profile}
          socialLinks={socialLinks}
          projectCount={projects.length}
          skillCount={skills.length}
        />
        <About profile={profile} skills={skills} />
        <Project
          projects={projects}
          loading={projectsQuery.isLoading}
        />
        <Internship items={experience} />
        <Education items={education} certifications={certifications} />
        <Contact profile={profile} socialLinks={socialLinks} onShowToast={showToast} />
      </main>

      {/* Footer */}
      <Footer profile={profile} socialLinks={socialLinks} />

      <Toast toasts={toasts} onDismiss={dismissToast} />
    </div>
  )
}
