import { useState } from 'react'
import { Navigate, Route, Routes, useNavigate } from 'react-router-dom'
import { auth, authStore } from './api'
import Certifications from './components/Certifications'
import Dashboard from './components/Dashboard'
import Education from './components/Education'
import Experience from './components/Experience'
import Login from './components/Login'
import Messages from './components/Messages'
import Navbar from './components/Navbar'
import Profile from './components/Profile'
import Projects from './components/Projects'
import Sidebar from './components/Sidebar'
import Skills from './components/Skills'

function ProtectedLayout() {
  const navigate = useNavigate()
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  async function handleLogout() {
    try {
      await auth.logout()
    } catch {
      // ignore network failure on logout
    }
    authStore.clear()
    navigate('/login', { replace: true })
  }

  return (
    <div className="admin-shell">
      <Navbar
        onMenuToggle={() => setIsMenuOpen(true)}
        onLogout={handleLogout}
      />

      <Sidebar
        isOpen={isMenuOpen}
        onClose={() => setIsMenuOpen(false)}
        onLogout={handleLogout}
      />

      <div className="admin-main">
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
