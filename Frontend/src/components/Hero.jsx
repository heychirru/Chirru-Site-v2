import { motion } from 'framer-motion'
import { ArrowUpRight, Github, Linkedin, Mail, FileText, Send, Code2, Globe, MapPin } from 'lucide-react'
import { portfolioApi } from '../api'

export default function Hero({ profile = {}, socialLinks = [], projectCount = 0, skillCount = 0 }) {
  function handleResumeClick() {
    portfolioApi.trackEvent('resume_download', { source: 'hero_cta' })
  }

  const github = socialLinks.find((s) => s.platform?.toLowerCase() === 'github')?.url || profile.githubUrl
  const linkedin = socialLinks.find((s) => s.platform?.toLowerCase() === 'linkedin')?.url || profile.linkedinUrl
  const email = profile.email

  // Clean headline if default is informal
  let headline = profile.headline || 'Full-Stack Software Developer & Backend Engineer'
  if (headline.toLowerCase().includes('wanna be')) {
    headline = 'Aspiring Java & Backend Software Engineer'
  }

  return (
    <section id="home" className="hero-section section">
      <div className="container hero-container-landscape">
        <motion.div
          className="hero-card hero-card-landscape"
          initial={{ opacity: 0, y: 24, scale: 0.98 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={{ duration: 0.5, ease: 'easeOut' }}
        >
          {/* Left Column: Identity, Bio & Actions */}
          <div className="hero-landscape-left">
            {/* Status Indicator */}
            <div className="status-pill hero-status-pill">
              <span className="status-indicator" />
              <span>Available for new opportunities</span>
            </div>

            {/* Profile Info Row */}
            <div className="hero-landscape-profile">
              <div className="avatar-wrapper hero-avatar-landscape">
                {profile.imageUrl ? (
                  <img src={profile.imageUrl} alt={profile.name || 'Chiranjit'} className="avatar-img" />
                ) : (
                  <div className="avatar-fallback">{profile.name?.slice(0, 1) || 'C'}</div>
                )}
              </div>
              <div className="hero-landscape-info">
                <h1 className="hero-profile-name">{profile.name || 'Chiranjit Das'}</h1>
                <p className="hero-profile-headline">{headline}</p>
                <div className="hero-location-badge">
                  <MapPin size={14} />
                  <span>{profile.location || 'India · Open to Remote'}</span>
                </div>
              </div>
            </div>

            {/* Actions & Socials */}
            <div className="hero-landscape-actions-wrap">
              <div className="hero-actions hero-landscape-actions">
                <a className="btn btn-primary" href="#projects">
                  Explore Projects <ArrowUpRight size={16} />
                </a>

                <a
                  className="btn btn-secondary"
                  href={portfolioApi.resumeDownloadUrl}
                  target="_blank"
                  rel="noreferrer"
                  onClick={handleResumeClick}
                >
                  <FileText size={15} /> Resume
                </a>

                <a className="btn btn-ghost" href="#contact">
                  <Send size={15} /> Contact
                </a>
              </div>

              <div className="hero-socials hero-landscape-socials">
                {github && (
                  <a href={github} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="GitHub">
                    <Github size={18} />
                  </a>
                )}
                {linkedin && (
                  <a href={linkedin} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="LinkedIn">
                    <Linkedin size={18} />
                  </a>
                )}
                {email && (
                  <a href={`mailto:${email}`} className="social-icon-btn" aria-label="Email">
                    <Mail size={18} />
                  </a>
                )}
                {socialLinks
                  .filter((s) => !['github', 'linkedin'].includes(s.platform?.toLowerCase()))
                  .map((s) => (
                    <a
                      key={s.id || s.url}
                      href={s.url}
                      target="_blank"
                      rel="noreferrer"
                      className="social-icon-btn"
                      aria-label={s.label || s.platform}
                      title={s.label || s.platform}
                    >
                      <Globe size={18} />
                    </a>
                  ))}
              </div>
            </div>
          </div>

          {/* Vertical Divider */}
          <div className="hero-landscape-divider" />

          {/* Right Column: Metrics & Focus Areas */}
          <div className="hero-landscape-right">
            {/* Quick Metrics */}
            <div className="hero-stats-grid">
              <div className="stat-box">
                <div className="stat-number">{projectCount > 0 ? `${projectCount}+` : '4+'}</div>
                <div className="stat-label">Projects Built</div>
              </div>
              <div className="stat-box">
                <div className="stat-number">{skillCount > 0 ? `${skillCount}+` : '12+'}</div>
                <div className="stat-label">Core Techs</div>
              </div>
            </div>

            {/* Focus Tags */}
            <div className="hero-focus-section">
              <div className="hero-focus-heading hero-landscape-focus-heading">
                <Code2 size={14} color="var(--primary-light)" />
                <span>Core Focus Areas</span>
              </div>
              <div className="hero-tags-box hero-landscape-tags">
                <span className="tag-badge">Backend Architecture</span>
                <span className="tag-badge">Spring Boot & Java</span>
                <span className="tag-badge">RESTful APIs</span>
                <span className="tag-badge">React & Next.js</span>
                <span className="tag-badge">PostgreSQL</span>
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  )
}
