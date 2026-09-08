import { useState, useEffect } from 'react'
import { Menu, Sun, Moon, FileText } from 'lucide-react'
import { portfolioApi } from '../api'

const navLinks = [
  { label: 'About', href: '#about' },
  { label: 'Projects', href: '#projects' },
  { label: 'Experience', href: '#experience' },
  { label: 'Education', href: '#education' },
  { label: 'Contact', href: '#contact' },
]

export default function Navbar({ onMenu, theme, onToggleTheme }) {
  const [activeSection, setActiveSection] = useState('home')
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    function handleScroll() {
      setScrolled(window.scrollY > 30)

      const sections = ['home', 'about', 'projects', 'experience', 'education', 'contact']
      const scrollPos = window.scrollY + 200

      for (const section of sections) {
        const el = document.getElementById(section)
        if (el) {
          const top = el.offsetTop
          const height = el.offsetHeight
          if (scrollPos >= top && scrollPos < top + height) {
            setActiveSection(section)
            break
          }
        }
      }
    }

    window.addEventListener('scroll', handleScroll, { passive: true })
    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  function handleResumeClick() {
    portfolioApi.trackEvent('resume_download', {
      source: 'navbar_cta',
    })
  }

  return (
    <header className="navbar-wrapper">
      <nav className={`navbar ${scrolled ? 'scrolled' : ''}`} aria-label="Main Navigation">
        {/* Brand */}
        <a className="nav-brand" href="#home">
          chirru<span className="nav-brand-dot" />
        </a>

        {/* Desktop Links */}
        <ul className="nav-links">
          {navLinks.map((link) => (
            <li key={link.href}>
              <a
                href={link.href}
                className={`nav-link ${activeSection === link.href.slice(1) ? 'active' : ''}`}
              >
                {link.label}
              </a>
            </li>
          ))}
        </ul>

        {/* Actions (Theme, Resume, Mobile Menu) */}
        <div className="nav-actions">
          {/* Theme Toggle */}
          <button className="theme-toggle-btn" onClick={onToggleTheme} aria-label="Toggle dark/light theme">
            {theme === 'light' ? <Moon size={16} /> : <Sun size={16} />}
          </button>

          {/* Resume CTA */}
          <a
            href={portfolioApi.resumeDownloadUrl}
            target="_blank"
            rel="noreferrer"
            className="btn btn-primary btn-sm"
            onClick={handleResumeClick}
          >
            <FileText size={14} /> Resume
          </a>

          {/* Mobile Menu Button */}
          <button className="mobile-menu-btn" onClick={onMenu} aria-label="Open mobile menu">
            <Menu size={20} />
          </button>
        </div>
      </nav>
    </header>
  )
}
