import { Menu } from 'lucide-react'
import { useState } from 'react'
import { Navigate, Route, Routes, useNavigate } from 'react-router-dom'
import { auth, authStore } from './api'
import Certifications from './components/Certifications'
import Dashboard from './components/Dashboard'
import Education from './components/Education'
import Experience from './components/Experience'
import Login from './components/Login'
import Messages from './components/Messages'
import Profile from './components/Profile'
import Projects from './components/Projects'
import Sidebar from './components/Sidebar'
import Skills from './components/Skills'

function ProtectedLayout() {
  const navigate = useNavigate()
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false)
  const [isMobileOpen, setIsMobileOpen] = useState(false)

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
      setIsMobileOpen(!isMobileOpen)
    } else {
      setIsSidebarCollapsed(!isSidebarCollapsed)
    }
  }

  return (
    <div className={`admin-shell ${isSidebarCollapsed ? 'sidebar-collapsed' : ''}`}>
      <Sidebar
        isOpen={isMobileOpen}
        onToggle={handleToggle}
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
            <Route path="/messages" element={<Messages />} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </main>
      </div>
    </div>
  )
}

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route
        path="/*"
        element={
          authStore.get() ? <ProtectedLayout /> : <Navigate to="/login" replace />
        }
      />
    </Routes>
  )
}
