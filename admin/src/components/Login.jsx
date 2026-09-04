import {
  AlertCircle,
  Eye,
  EyeOff,
  Lock,
  Mail,
  ShieldCheck,
  Sparkles
} from 'lucide-react'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { auth, authStore } from '../api'

export default function Login() {
  const navigate = useNavigate()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [error, setError] = useState('')
  const [busy, setBusy] = useState(false)

  const publicSiteUrl = import.meta.env.VITE_PUBLIC_SITE_URL || 'http://localhost:5174'

  async function handleSubmit(event) {
    event.preventDefault()
    setBusy(true)
    setError('')

    try {
      const data = await auth.login(email.trim(), password)
      authStore.set(data.accessToken)
      navigate('/', { replace: true })
    } catch (e) {
      setError(e.message || 'Invalid email or password. Please try again.')
    } finally {
      setBusy(false)
    }
  }

  return (
    <div className="login-page">
      <div className="login-glow" />

      <form className="login-card" onSubmit={handleSubmit}>
        <div className="login-brand">
          <div className="login-logo-box">
            <Sparkles size={26} />
          </div>
          <div>
            <div
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 5,
                background: '#e6f7f0',
                color: '#0b5c46',
                fontSize: '0.66rem',
                fontWeight: 700,
                padding: '3px 8px',
                borderRadius: '9999px',
                letterSpacing: '0.04em',
                textTransform: 'uppercase',
                marginBottom: '8px',
              }}
            >
              <ShieldCheck size={13} />
              <span>Executive Access</span>
            </div>
            <h2 className="login-title">
              chirru<span>.</span> admin
            </h2>
            <p className="login-subtitle">
              Enter your credentials to access the portfolio CMS
            </p>
          </div>
        </div>

        {error && (
          <div
            className="alert alert-error"
            style={{ display: 'flex', alignItems: 'center', gap: 8 }}
          >
            <AlertCircle size={16} style={{ flexShrink: 0 }} />
            <span>{error}</span>
          </div>
        )}

        <div className="form-group">
          <label className="form-label">
            <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5 }}>
              <Mail size={13} color="#0b5c46" />
              <span>Email Address</span>
            </span>
          </label>
          <input
            className="form-input"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            type="email"
            placeholder="EMAIL_ADDRESS"
            autoComplete="username"
            required
          />
        </div>

        <div className="form-group">
          <label className="form-label">
            <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5 }}>
              <Lock size={13} color="#0b5c46" />
              <span>Password</span>
            </span>
          </label>
          <div style={{ position: 'relative' }}>
            <input
              className="form-input"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              type={showPassword ? 'text' : 'password'}
              placeholder="••••••••••••"
              autoComplete="current-password"
              style={{ paddingRight: '42px' }}
              required
            />
            <button
              type="button"
              className="btn btn-secondary btn-icon"
              style={{
                position: 'absolute',
                right: '4px',
                top: '50%',
                transform: 'translateY(-50%)',
                padding: '5px',
                border: 'none',
                background: 'transparent',
                color: '#64748b',
              }}
              onClick={() => setShowPassword(!showPassword)}
              aria-label={showPassword ? 'Hide password' : 'Show password'}
            >
              {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
            </button>
          </div>
        </div>

        <button
          type="submit"
          className="btn btn-primary"
          disabled={busy}
          style={{ width: '100%', padding: '11px', marginTop: '4px', fontSize: '0.88rem' }}
        >
          {busy ? (
            <>
              <div className="spinner" />
              <span>Authenticating…</span>
            </>
          ) : (
            <span>Sign In to Admin</span>
          )}
        </button>
      </form>

      <div
        style={{
          marginTop: '20px',
          fontSize: '0.74rem',
          color: '#8392a5',
          textAlign: 'center',
          zIndex: 1,
        }}
      >
        © 2026 Chirru Admin· All rights reserved
      </div>
    </div>
  )
}
