import { useQuery } from '@tanstack/react-query'
import {
  BadgeCheck,
  BriefcaseBusiness,
  ExternalLink,
  FolderKanban,
  GraduationCap,
  LayoutDashboard,
  LogOut,
  Mail,
  Moon,
  Sparkles,
  Sun,
  UserRound,
  Wrench,
  X,
} from 'lucide-react'
import { useEffect, useState } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { adminApi } from '../api'

const navItems = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/projects', label: 'Projects', icon: FolderKanban },
  { to: '/profile', label: 'Profile', icon: UserRound },
  { to: '/skills', label: 'Skills', icon: Wrench },
  { to: '/experience', label: 'Experience', icon: BriefcaseBusiness },
  { to: '/education', label: 'Education', icon: GraduationCap },
  { to: '/certifications', label: 'Certificates', icon: BadgeCheck },
  { to: '/messages', label: 'Messages', icon: Mail, isMessage: true },
]

export default function Sidebar({ onLogout, isOpen, onClose }) {
  const location = useLocation()
  const [theme, setTheme] = useState(() => localStorage.getItem('chirru_admin_theme') || 'dark')

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('chirru_admin_theme', theme)
  }, [theme])

  const toggleTheme = () => {
    setTheme((prev) => (prev === 'dark' ? 'light' : 'dark'))
  }

  const dashQuery = useQuery({
    queryKey: ['dashboard'],
    queryFn: adminApi.dashboard,
    staleTime: 30000,
  })

  const name = profileQuery.data?.name || 'Chiranjit'
  const unreadCount = dashQuery.data?.unreadMessages || 0

  return (
    <>
      {isOpen && <div className="mobile-drawer-backdrop" onClick={onClose} />}
      <aside className={`mobile-drawer ${isOpen ? 'open' : ''}`}>
        <div className="mobile-drawer-brand">
          <div className="navbar-brand">
            <div className="navbar-brand-logo">
              <Sparkles size={18} />
            </div>
            <div className="navbar-brand-text">
              chirru<span>.</span>
              <span className="navbar-brand-tag">admin</span>
            </div>
          </div>
          <button
            className="btn btn-ghost btn-icon"
            onClick={onClose}
            aria-label="Close navigation"
          >
            <X size={20} />
          </button>
        </div>

        <nav className="mobile-drawer-nav">
          {navItems.map(({ to, label, icon: Icon, isMessage }) => {
            const isActive = location.pathname === to
            return (
              <Link
                key={to}
                to={to}
                className={`mobile-drawer-link ${isActive ? 'active' : ''}`}
                onClick={onClose}
              >
                <div className="mobile-drawer-link-content">
                  <Icon size={18} />
                  <span>{label}</span>
                </div>
                {isMessage && unreadCount > 0 && (
                  <span className="navbar-badge">{unreadCount}</span>
                )}
              </Link>
            )
          })}
        </nav>

        <div style={{ marginTop: 'auto', paddingTop: '16px', display: 'flex', flexDirection: 'column', gap: '10px' }}>
          <button
            className="btn btn-secondary btn-sm"
            onClick={toggleTheme}
            style={{ width: '100%', justifyContent: 'flex-start' }}
          >
            {theme === 'dark' ? <Sun size={16} /> : <Moon size={16} />}
            <span>Switch to {theme === 'dark' ? 'Light' : 'Dark'} Mode</span>
          </button>

          <a
            href="http://localhost:5173"
            target="_blank"
            rel="noreferrer"
            className="btn btn-secondary btn-sm"
            style={{ width: '100%', justifyContent: 'flex-start' }}
          >
            <ExternalLink size={16} />
            <span>Open Public Website</span>
          </a>

          <button
            className="btn btn-danger btn-sm"
            onClick={onLogout}
            style={{ width: '100%', justifyContent: 'flex-start' }}
          >
            <LogOut size={16} />
            <span>Sign Out</span>
          </button>
        </div>
      </aside>
    </>
  )
}
