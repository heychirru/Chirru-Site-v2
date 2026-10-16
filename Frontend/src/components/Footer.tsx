'use client'

import { ArrowUp, Github, Mail } from 'lucide-react'
import type { Profile, SocialLink } from '@/types/portfolio'

interface FooterProps {
  profile?: Profile
  socialLinks?: SocialLink[]
}

export default function Footer({ profile = {}, socialLinks = [] }: FooterProps) {
  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  const github = socialLinks.find((s) => s.platform?.toLowerCase() === 'github')?.url || profile.githubUrl

  return (
    <footer className="footer">
      <div className="container footer-inner">
        <div>
          <div className="footer-brand">
            chirru<span>.</span>
          </div>
          <p className="footer-copy" style={{ marginTop: 4 }}>
            © {new Date().getFullYear()} {profile.name || 'Chirru'}. All rights reserved.
          </p>
        </div>

        {/* Social Links */}
        <div className="footer-socials">
          {github && (
            <a href={github} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="GitHub" style={{ width: 36, height: 36 }}>
              <Github size={16} />
            </a>
          )}
          {profile.email && (
            <a href={`mailto:${profile.email}`} className="social-icon-btn" aria-label="Email" style={{ width: 36, height: 36 }}>
              <Mail size={16} />
            </a>
          )}

          <button className="back-to-top-btn" onClick={scrollToTop} aria-label="Back to top">
            <ArrowUp size={14} /> Back to top
          </button>
        </div>
      </div>
    </footer>
  )
}
