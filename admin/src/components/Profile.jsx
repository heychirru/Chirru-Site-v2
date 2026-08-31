import { useQuery, useQueryClient } from '@tanstack/react-query'
import {
  Check,
  Globe,
  Mail,
  MapPin,
  Phone,
  Save,
  Sparkles,
  UserRound,
} from 'lucide-react'
import { useEffect, useState } from 'react'
import { adminApi } from '../api'

export default function Profile() {
  const qc = useQueryClient()
  const q = useQuery({ queryKey: ['profile'], queryFn: adminApi.profile })

  const [form, setForm] = useState({
    name: '',
    headline: '',
    email: '',
    phone: '',
    location: '',
    githubUrl: '',
    linkedinUrl: '',
    resumeUrl: '',
    imageUrl: '',
    bio: '',
  })

  const [saving, setSaving] = useState(false)
  const [status, setStatus] = useState({ type: '', message: '' })

  useEffect(() => {
    if (q.data) {
      setForm((prev) => ({
        ...prev,
        ...q.data,
      }))
    }
  }, [q.data])

  if (q.isLoading) {
    return (
      <div className="loading-state">
        <div className="spinner" />
        <span>Loading profile data…</span>
      </div>
    )
  }

  const handleChange = (field, value) => {
    setForm((prev) => ({ ...prev, [field]: value }))
    if (status.message) setStatus({ type: '', message: '' })
  }

  async function handleSubmit(e) {
    e.preventDefault()
    setSaving(true)
    setStatus({ type: '', message: '' })

    try {
      await adminApi.saveProfile(form)
      setStatus({ type: 'success', message: 'Profile updated successfully!' })
      await qc.invalidateQueries({ queryKey: ['profile'] })
    } catch (err) {
      setStatus({
        type: 'error',
        message: err.message || 'Failed to save profile changes.',
      })
    } finally {
      setSaving(false)
    }
  }

  return (
    <>
      <div className="page-header">
        <div className="page-header-text">
          <h1>
            <UserRound size={26} color="var(--primary)" />
            <span>Profile & Personal Info</span>
          </h1>
          <p>Update your personal information, hero bio, avatar, and portfolio links.</p>
        </div>
      </div>

      <form onSubmit={handleSubmit}>
        {status.message && (
          <div
            className={`alert ${
              status.type === 'error' ? 'alert-error' : 'alert-success'
            }`}
            style={{ marginBottom: '20px' }}
          >
            {status.type === 'success' ? <Check size={16} /> : null}
            <span>{status.message}</span>
          </div>
        )}

        <div className="grid-split">
          <div className="panel">
            <div className="panel-header">
              <h3 className="panel-title">
                <Sparkles size={18} color="var(--primary)" />
                <span>Basic Details</span>
              </h3>
            </div>

            <div className="form">
              <div className="form-row">
                <div className="form-group">
                  <label className="form-label">Full Name</label>
                  <input
                    className="form-input"
                    value={form.name || ''}
                    onChange={(e) => handleChange('name', e.target.value)}
                    placeholder="Chirag"
                    required
                  />
                </div>
                <div className="form-group">
                  <label className="form-label">Headline / Title</label>
                  <input
                    className="form-input"
                    value={form.headline || ''}
                    onChange={(e) => handleChange('headline', e.target.value)}
                    placeholder="Full Stack Developer & AI Engineer"
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label className="form-label">
                    <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
                      <Mail size={13} /> Email Address
                    </span>
                  </label>
                  <input
                    className="form-input"
                    type="email"
                    value={form.email || ''}
                    onChange={(e) => handleChange('email', e.target.value)}
                    placeholder="chirag@example.com"
                  />
                </div>
                <div className="form-group">
                  <label className="form-label">
                    <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
                      <Phone size={13} /> Phone
                    </span>
                  </label>
                  <input
                    className="form-input"
                    value={form.phone || ''}
                    onChange={(e) => handleChange('phone', e.target.value)}
                    placeholder="+1 (555) 000-0000"
                  />
                </div>
              </div>

              <div className="form-group">
                <label className="form-label">
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
                    <MapPin size={13} /> Location
                  </span>
                </label>
                <input
                  className="form-input"
                  value={form.location || ''}
                  onChange={(e) => handleChange('location', e.target.value)}
                  placeholder="San Francisco, CA / Remote"
                />
              </div>

              <div className="form-group">
                <label className="form-label">
                  About Bio
                  <small style={{ color: 'var(--text-muted)' }}>
                    {(form.bio || '').length} characters
                  </small>
                </label>
                <textarea
                  className="form-textarea"
                  value={form.bio || ''}
                  onChange={(e) => handleChange('bio', e.target.value)}
                  rows={6}
                  placeholder="Write a captivating narrative about your journey, philosophy, and expertise..."
                />
              </div>
            </div>
          </div>

          <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
            <div className="panel">
              <div className="panel-header">
                <h3 className="panel-title">
                  <Globe size={18} color="var(--accent-purple)" />
                  <span>Online Links & Media</span>
                </h3>
              </div>

              <div className="form">
                <div className="form-group">
                  <label className="form-label">GitHub Profile URL</label>
                  <input
                    className="form-input"
                    type="url"
                    value={form.githubUrl || ''}
                    onChange={(e) => handleChange('githubUrl', e.target.value)}
                    placeholder="https://github.com/..."
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">LinkedIn Profile URL</label>
                  <input
                    className="form-input"
                    type="url"
                    value={form.linkedinUrl || ''}
                    onChange={(e) => handleChange('linkedinUrl', e.target.value)}
                    placeholder="https://linkedin.com/in/..."
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Resume / CV Link</label>
                  <input
                    className="form-input"
                    type="url"
                    value={form.resumeUrl || ''}
                    onChange={(e) => handleChange('resumeUrl', e.target.value)}
                    placeholder="https://.../resume.pdf"
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Avatar Image URL</label>
                  <input
                    className="form-input"
                    type="url"
                    value={form.imageUrl || ''}
                    onChange={(e) => handleChange('imageUrl', e.target.value)}
                    placeholder="https://.../avatar.jpg"
                  />
                </div>

                {form.imageUrl && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginTop: 4 }}>
                    <img
                      src={form.imageUrl}
                      alt="Avatar preview"
                      style={{
                        width: 50,
                        height: 50,
                        borderRadius: '50%',
                        objectFit: 'cover',
                        border: '2px solid var(--border-highlight)',
                      }}
                      onError={(e) => {
                        e.currentTarget.style.display = 'none'
                      }}
                    />
                    <small style={{ color: 'var(--text-muted)' }}>Avatar Preview</small>
                  </div>
                )}
              </div>
            </div>

            <button
              type="submit"
              className="btn btn-primary"
              disabled={saving}
              style={{ width: '100%', padding: '14px' }}
            >
              {saving ? (
                <>
                  <div className="spinner" style={{ width: 16, height: 16 }} />
                  <span>Saving Profile…</span>
                </>
              ) : (
                <>
                  <Save size={18} />
                  <span>Save Profile Changes</span>
                </>
              )}
            </button>
          </div>
        </div>
      </form>
    </>
  )
}
