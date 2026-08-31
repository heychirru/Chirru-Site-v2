import { Mail, Send } from 'lucide-react'
import { useState } from 'react'
import { portfolioApi } from '../api'

export default function Contact() {
  const [form, setForm] = useState({ name: '', email: '', subject: '', message: '' })
  const [status, setStatus] = useState('')
  const [busy, setBusy] = useState(false)

  function change(event) {
    setForm((current) => ({ ...current, [event.target.name]: event.target.value }))
  }

  async function submit(event) {
    event.preventDefault()
    setBusy(true)
    setStatus('')
    try {
      await portfolioApi.contact(form)
      setForm({ name: '', email: '', subject: '', message: '' })
      setStatus('Thanks — your message has been sent.')
    } catch (error) {
      setStatus(error.message || 'Could not send your message.')
    } finally {
      setBusy(false)
    }
  }

  return (
    <section id="contact" className="section">
      <div className="container contact-grid">
        <div>
          <p className="eyebrow">CONTACT</p>
          <h2>Let’s build something useful.</h2>
          <p className="lead">Have an opportunity, project idea, or just want to say hello? Send a message.</p>
          <div className="contact-note"><Mail size={18} /> Messages are delivered to the private admin inbox.</div>
        </div>
        <form className="card form" onSubmit={submit}>
          <input name="name" value={form.name} onChange={change} placeholder="Name" required />
          <input name="email" value={form.email} onChange={change} type="email" placeholder="Email" required />
          <input name="subject" value={form.subject} onChange={change} placeholder="Subject" />
          <textarea name="message" value={form.message} onChange={change} rows="6" placeholder="Message" required />
          <button className="button" disabled={busy}>{busy ? 'Sending…' : <>Send message <Send size={16} /></>}</button>
          {status && <small className="form-status">{status}</small>}
        </form>
      </div>
    </section>
  )
}
