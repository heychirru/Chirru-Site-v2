import { Github, Linkedin, Mail } from 'lucide-react'

export default function Footer({ profile }) {
  return (
    <footer className="footer">
      <div className="container footer-inner">
        <span>© {new Date().getFullYear()} {profile.name || 'Chirru'}</span>
        <div className="footer-links">
          {profile.githubUrl && <a href={profile.githubUrl} target="_blank" rel="noreferrer"><Github size={16} /></a>}
          {profile.linkedinUrl && <a href={profile.linkedinUrl} target="_blank" rel="noreferrer"><Linkedin size={16} /></a>}
          {profile.email && <a href={`mailto:${profile.email}`}><Mail size={16} /></a>}
        </div>
      </div>
    </footer>
  )
}
