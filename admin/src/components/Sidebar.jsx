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
  Menu,
  UserRound,
  Wrench,
  X,
} from 'lucide-react'
import { Link, useLocation } from 'react-router-dom'
import { adminApi } from '../api'

const navItems = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/projects', label: 'Projects', icon: FolderKanban },
  { to: '/profile', label: 'Profile & Bio', icon: UserRound },
  { to: '/skills', label: 'Technical Skills', icon: Wrench },
  { to: '/experience', label: 'Experience', icon: BriefcaseBusiness },
  { to: '/education', label: 'Education', icon: GraduationCap },
  { to: '/certifications', label: 'Certifications', icon: BadgeCheck },
  { to: '/messages', label: 'Inquiries & Messages', icon: Mail, isMessage: true },
]

export default function Sidebar({ isOpen, onToggle, onLogout }) {
  const location = useLocation()

  const profileQuery = useQuery({
    queryKey: ['profile'],
    queryFn: adminApi.profile,
  })

  const dashQuery = useQuery({
    queryKey: ['dashboard'],
    queryFn: adminApi.dashboard,
    staleTime: 30000,
  })

  const name = profileQuery.data?.name || 'Chiranjit Das'
  const unreadCount = dashQuery.data?.unreadMessages || 0

  return (
    <>
      {isOpen && <div className="sidebar-backdrop" onClick={onToggle} />}
      <aside className={`sidebar ${isOpen ? 'mobile-open' : ''}`}>
        {/* Header matching exact layout */}
        <div className="sidebar-header">
          <div className="sidebar-user-block">
            <div className="sidebar-brand-avatar">
              {profileQuery.data?.imageUrl ? (
                <img src={profileQuery.data.imageUrl} alt={name} />
              ) : (
                name.charAt(0).toUpperCase()
              )}
            </div>
            <div className="sidebar-user-meta">
              <span className="sidebar-user-name">{name}</span>
              <span className="sidebar-user-role">Portfolio Administrator</span>
            </div>
          </div>
          <button
            className="sidebar-toggle-btn"
            onClick={onToggle}
            aria-label="Toggle navigation menu"
          >
            <Menu size={18} />
          </button>
        </div>

        {/* Navigation Items with Forest Green Capsule Active State */}
        <nav className="sidebar-nav">
          {navItems.map(({ to, label, icon: Icon, isMessage }) => {
            const isActive = location.pathname === to
            return (
              <Link
                key={to}
                to={to}
                className={`sidebar-item ${isActive ? 'active' : ''}`}
                onClick={() => {
                  if (window.innerWidth <= 1024) {
                    onToggle()
                  }
                }}
              >
                <div className="sidebar-item-content">
                  <Icon size={16} />
                  <span>{label}</span>
                </div>
                {isMessage && unreadCount > 0 && (
                  <span className="sidebar-badge">{unreadCount}</span>
                )}
              </Link>
            )
          })}
        </nav>

        {/* Footer Actions */}
        <div className="sidebar-footer">
          <a
            href="http://localhost:5174"
            target="_blank"
            rel="noreferrer"
            className="sidebar-btn-footer"
          >
            <ExternalLink size={15} />
            <span>Public Website</span>
          </a>

          <button
            className="sidebar-btn-footer sidebar-btn-logout"
            onClick={onLogout}
          >
            <LogOut size={15} />
            <span>Sign Out</span>
          </button>
        </div>
      </aside>
    </>
  )
}
