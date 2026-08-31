import { Eye, EyeOff, Lock, Mail, Sparkles } from 'lucide-react'
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

  async function handleSubmit(event) {
    event.preventDefault()
    setBusy(true)
    setError('')

    try {
      const data = await auth.login(email, password)
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
            <Sparkles size={28} />
          </div>
          <div>
            <h2 className="login-title">
              chirru<span>.</span> admin
            </h2>
            <p className="login-subtitle">
              Enter your credentials to access the portfolio CMS
            </p>
          </div>
        </div>

        {error && <div className="alert alert-error">{error}</div>}

        <div className="form-group">
          <label className="form-label">
            <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
              <Mail size={13} /> Email Address
            </span>
          </label>
          <input
            className="form-input"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            type="email"
            placeholder="admin@chirru.dev"
            autoComplete="username"
            required
          />
        </div>

        <div className="form-group">
          <label className="form-label">
            <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
              <Lock size={13} /> Password
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
              className="btn btn-ghost btn-icon"
              style={{
                position: 'absolute',
                right: '6px',
                top: '50%',
                transform: 'translateY(-50%)',
                padding: '6px',
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
          style={{ width: '100%', padding: '13px', marginTop: '6px' }}
        >
          {busy ? (
            <>
              <div className="spinner" style={{ width: 16, height: 16 }} />
              <span>Authenticating…</span>
            </>
          ) : (
            <span>Sign In to Admin</span>
          )}
        </button>

        <div style={{ textAlign: 'center', marginTop: '8px' }}>
          <a
            href="http://localhost:5173"
            target="_blank"
            rel="noreferrer"
            style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}
          >
            ← Back to Public Portfolio
          </a>
        </div>
      </form>
    </div>
  )
}
