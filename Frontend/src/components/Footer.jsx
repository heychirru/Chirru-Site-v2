import { ArrowUp, Github, Linkedin, Mail, Globe } from 'lucide-react'

export default function Footer({ profile = {}, socialLinks = [] }) {
  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  const github = socialLinks.find((s) => s.platform?.toLowerCase() === 'github')?.url || profile.githubUrl
  const linkedin = socialLinks.find((s) => s.platform?.toLowerCase() === 'linkedin')?.url || profile.linkedinUrl

  return (
    <footer className="footer">
      <div className="container footer-inner">
        <div>
          <div className="footer-brand">
            chirru<span>.</span>
          </div>
          <p className="footer-copy" style={{ marginTop: 4 }}>
            © {new Date().getFullYear()} {profile.name || 'Chirru'}. Built with React & Spring Boot.
          </p>
        </div>

        {/* Social Links */}
        <div className="footer-socials">
          {github && (
            <a href={github} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="GitHub" style={{ width: 36, height: 36 }}>
              <Github size={16} />
            </a>
          )}
          {linkedin && (
            <a href={linkedin} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="LinkedIn" style={{ width: 36, height: 36 }}>
              <Linkedin size={16} />
            </a>
          )}
          {profile.email && (
            <a href={`mailto:${profile.email}`} className="social-icon-btn" aria-label="Email" style={{ width: 36, height: 36 }}>
              <Mail size={16} />
            </a>
          )}

          <button className="back-to-top-btn" onClick={scrollToTop} aria-label="Scroll to top of page">
            <ArrowUp size={14} /> Back to top
          </button>
        </div>
      </div>
    </footer>
  )
}
