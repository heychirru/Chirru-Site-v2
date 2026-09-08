import { useState } from 'react'
import { motion } from 'framer-motion'
import { Mail, Send, Copy, Check, ShieldCheck, Github, Linkedin, Globe, Loader2 } from 'lucide-react'
import { portfolioApi } from '../api'

export default function Contact({ profile = {}, socialLinks = [], onShowToast }) {
  const [form, setForm] = useState({ name: '', email: '', subject: '', message: '' })
  const [status, setStatus] = useState({ type: '', text: '' })
  const [busy, setBusy] = useState(false)
  const [copied, setCopied] = useState(false)

  const email = profile.email || 'contact@example.com'

  function handleChange(e) {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }))
  }

  function handleCopyEmail() {
    if (!profile.email) return
    navigator.clipboard.writeText(profile.email)
    setCopied(true)
    onShowToast?.('Email address copied to clipboard!', 'success')
    setTimeout(() => setCopied(false), 2500)
  }

  async function handleSubmit(e) {
    e.preventDefault()
    setBusy(true)
    setStatus({ type: '', text: '' })

    try {
      await portfolioApi.contact(form)
      setForm({ name: '', email: '', subject: '', message: '' })
      setStatus({
        type: 'success',
        text: 'Thank you! Your message has been safely delivered to my inbox.',
      })
      onShowToast?.('Message sent successfully!', 'success')
    } catch (err) {
      setStatus({
        type: 'error',
        text: err.message || 'Could not send message. Please try again or reach out directly.',
      })
      onShowToast?.(err.message || 'Failed to send message', 'error')
    } finally {
      setBusy(false)
    }
  }

  return (
    <section id="contact" className="section">
      <div className="container">
        {/* Section Header */}
        <div className="section-header">
          <span className="eyebrow">
            <Mail size={14} /> Get In Touch
          </span>
          <h2 className="section-title">
            Let’s Build Something <span className="gradient-text">Exceptional</span>
          </h2>
          <p className="section-subtitle">
            Have a project in mind, career opportunity, or want to discuss modern software architecture? Send a message directly.
          </p>
        </div>

        <div className="contact-grid">
          {/* Left: Contact Info Card */}
          <motion.div
            className="contact-info-card"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.4 }}
          >
            <div className="contact-direct-card">
              <h3 style={{ fontFamily: 'var(--font-sans)', fontSize: '1.25rem', fontWeight: 700 }}>
                Direct Reach
              </h3>
              <p style={{ color: 'var(--text-secondary)', fontSize: '0.92rem' }}>
                Feel free to email directly or copy the address for later:
              </p>

              {profile.email && (
                <div className="contact-email-row">
                  <span className="contact-email-text">{profile.email}</span>
                  <button
                    className="copy-email-btn"
                    onClick={handleCopyEmail}
                    type="button"
                    aria-label="Copy email to clipboard"
                  >
                    {copied ? <Check size={14} color="var(--accent-emerald)" /> : <Copy size={14} />}
                    <span>{copied ? 'Copied' : 'Copy'}</span>
                  </button>
                </div>
              )}

              <div style={{ display: 'flex', alignItems: 'center', gap: 8, color: 'var(--text-muted)', fontSize: '0.84rem', marginTop: 6 }}>
                <ShieldCheck size={16} color="var(--accent-emerald)" /> Messages are directly routed to the private portfolio inbox.
              </div>
            </div>

            {/* Social Links on Contact */}
            <div className="contact-direct-card">
              <h4 style={{ fontFamily: 'var(--font-sans)', fontSize: '1.05rem', fontWeight: 700 }}>
                Professional Networks
              </h4>
              <div className="hero-socials" style={{ marginTop: 4 }}>
                {profile.githubUrl && (
                  <a href={profile.githubUrl} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="GitHub">
                    <Github size={18} />
                  </a>
                )}
                {profile.linkedinUrl && (
                  <a href={profile.linkedinUrl} target="_blank" rel="noreferrer" className="social-icon-btn" aria-label="LinkedIn">
                    <Linkedin size={18} />
                  </a>
                )}
                {socialLinks.map((s) => (
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
          </motion.div>

          {/* Right: Contact Form */}
          <motion.div
            className="contact-form-card"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.4, delay: 0.1 }}
          >
            <form className="contact-form" onSubmit={handleSubmit}>
              <div className="form-group">
                <label className="form-label" htmlFor="contact-name">
                  Your Name *
                </label>
                <input
                  id="contact-name"
                  name="name"
                  type="text"
                  required
                  className="form-input"
                  placeholder="e.g. Alex Morgan"
                  value={form.name}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label className="form-label" htmlFor="contact-email">
                  Email Address *
                </label>
                <input
                  id="contact-email"
                  name="email"
                  type="email"
                  required
                  className="form-input"
                  placeholder="name@company.com"
                  value={form.email}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label className="form-label" htmlFor="contact-subject">
                  Subject
                </label>
                <input
                  id="contact-subject"
                  name="subject"
                  type="text"
                  className="form-input"
                  placeholder="Project inquiry / Opportunity"
                  value={form.subject}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label className="form-label" htmlFor="contact-message">
                  Message *
                </label>
                <textarea
                  id="contact-message"
                  name="message"
                  required
                  rows={5}
                  className="form-textarea"
                  placeholder="Write your message here..."
                  value={form.message}
                  onChange={handleChange}
                />
              </div>

              {status.text && (
                <div className={`form-alert ${status.type}`}>
                  {status.text}
                </div>
              )}

              <button type="submit" className="btn btn-filled" disabled={busy} style={{ width: '100%' }}>
                {busy ? (
                  <>
                    <Loader2 size={18} className="animate-spin" /> Sending message...
                  </>
                ) : (
                  <>
                    Send Message <Send size={16} />
                  </>
                )}
              </button>
            </form>
          </motion.div>
        </div>
      </div>
    </section>
  )
}
