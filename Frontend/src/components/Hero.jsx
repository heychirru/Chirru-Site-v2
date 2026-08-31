import { motion } from 'framer-motion'
import { ArrowUpRight, Github, Linkedin, Mail } from 'lucide-react'

export default function Hero({ profile }) {
  return (
    <section id="home" className="hero section">
      <div className="container hero-grid">
        <div>
          <motion.p initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} className="eyebrow">SOFTWARE DEVELOPER</motion.p>
          <motion.h1 initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.08 }}>
            Building useful software with Java, React and thoughtful engineering.
          </motion.h1>
          <motion.p initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.16 }} className="lead">
            {profile.headline || 'Full-stack developer focused on clean products, reliable backend systems and delightful interfaces.'}
          </motion.p>
          <div className="actions">
            <a className="button" href="#projects">View projects <ArrowUpRight size={17} /></a>
            {profile.resumeUrl && <a className="button ghost" href={profile.resumeUrl} target="_blank" rel="noreferrer">Resume</a>}
          </div>
          <div className="socials">
            {profile.githubUrl && <a href={profile.githubUrl} target="_blank" rel="noreferrer" aria-label="GitHub"><Github /></a>}
            {profile.linkedinUrl && <a href={profile.linkedinUrl} target="_blank" rel="noreferrer" aria-label="LinkedIn"><Linkedin /></a>}
            {profile.email && <a href={`mailto:${profile.email}`} aria-label="Email"><Mail /></a>}
          </div>
        </div>
        <div className="hero-card">
          <div className="hero-orb" />
          <span className="hero-label">CHIRRU</span>
          <strong>Software Developer</strong>
          <span>{profile.location || 'India'}</span>
        </div>
      </div>
    </section>
  )
}
