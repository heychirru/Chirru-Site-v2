import { Menu } from 'lucide-react'
import { useEffect, useState } from 'react'
import { Navigate, Route, Routes, useNavigate } from 'react-router-dom'
import { auth, authStore } from './api'
import Certifications from './components/Certifications'
import Dashboard from './components/Dashboard'
import Education from './components/Education'
import Experience from './components/Experience'
import Login from './components/Login'
import MediaManager from './components/MediaManager'
import Messages from './components/Messages'
import Profile from './components/Profile'
import Projects from './components/Projects'
import Sidebar from './components/Sidebar'
import Skills from './components/Skills'

function ProtectedLayout() {
  const navigate = useNavigate()
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false)
  const [isMobileOpen, setIsMobileOpen] = useState(false)

  useEffect(() => {
    const handleResize = () => {
      if (window.innerWidth > 1024) {
        setIsMobileOpen(false)
      }
    }
    window.addEventListener('resize', handleResize)
    return () => window.removeEventListener('resize', handleResize)
  }, [])

  async function handleLogout() {
    try {
      await auth.logout()
    } catch {
      // ignore network errors during logout
    }
    authStore.clear()
    navigate('/login', { replace: true })
  }

  const handleToggle = () => {
    if (window.innerWidth <= 1024) {
      setIsMobileOpen((prev) => !prev)
    } else {
      setIsSidebarCollapsed((prev) => !prev)
    }
  }

  const handleCloseMobile = () => {
    setIsMobileOpen(false)
  }

  return (
    <div className={`admin-shell ${isSidebarCollapsed ? 'sidebar-collapsed' : ''}`}>
      <Sidebar
        isOpen={isMobileOpen}
        onToggle={handleToggle}
        onClose={handleCloseMobile}
        onLogout={handleLogout}
      />

      <div className="admin-main">
        <div className="mobile-topbar-bar">
          <button
            className="btn btn-secondary btn-sm btn-icon"
            onClick={handleToggle}
            aria-label="Open navigation menu"
          >
            <Menu size={18} />
          </button>
          <span style={{ fontWeight: 700, color: '#0b5c46', fontSize: '0.9rem' }}>
            Chirru Admin · Portfolio CMS
          </span>
        </div>

        {isSidebarCollapsed && (
          <div style={{ padding: '12px 24px 0', display: 'flex', alignItems: 'center' }}>
            <button
              className="btn btn-secondary btn-sm"
              onClick={handleToggle}
              style={{ gap: 6 }}
            >
              <Menu size={16} />
              <span>Show Sidebar</span>
            </button>
          </div>
        )}

        <main className="admin-content">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/projects" element={<Projects />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="/skills" element={<Skills />} />
            <Route path="/experience" element={<Experience />} />
            <Route path="/education" element={<Education />} />
            <Route path="/certifications" element={<Certifications />} />
            <Route path="/media" element={<MediaManager />} />
            <Route path="/messages" element={<Messages />} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </main>
      </div>
    </div>
  )
}

export default function App() {
  const [token, setToken] = useState(() => authStore.get())

  useEffect(() => {
    const handleAuthChange = () => {
      setToken(authStore.get())
    }
    window.addEventListener('auth-change', handleAuthChange)
    window.addEventListener('storage', handleAuthChange)
    return () => {
      window.removeEventListener('auth-change', handleAuthChange)
      window.removeEventListener('storage', handleAuthChange)
    }
  }, [])

  return (
    <Routes>
      <Route
        path="/login"
        element={token ? <Navigate to="/" replace /> : <Login />}
      />
      <Route
        path="/*"
        element={token ? <ProtectedLayout /> : <Navigate to="/login" replace />}
      />
    </Routes>
  )
}
