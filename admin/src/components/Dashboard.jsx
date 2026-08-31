import { useQuery } from '@tanstack/react-query'
import {
  ArrowRight,
  BadgeCheck,
  BriefcaseBusiness,
  FolderKanban,
  GraduationCap,
  Mail,
  Sparkles,
  UserRound,
  Wrench
} from 'lucide-react'
import { Link } from 'react-router-dom'
import { adminApi } from '../api'

export default function Dashboard() {
  const q = useQuery({
    queryKey: ['dashboard'],
    queryFn: adminApi.dashboard,
  })

  if (q.isLoading) {
    return (
      <div className="loading-state">
        <div className="spinner" />
        <span>Loading dashboard analytics…</span>
      </div>
    )
  }

  const d = q.data || {}

  const stats = [
    {
      label: 'Projects',
      value: d.projects ?? 0,
      icon: FolderKanban,
      color: 'primary',
      to: '/projects',
    },
    {
      label: 'Skills',
      value: d.skills ?? 0,
      icon: Wrench,
      color: 'purple',
      to: '/skills',
    },
    {
      label: 'Experience',
      value: d.experience ?? 0,
      icon: BriefcaseBusiness,
      color: 'cyan',
      to: '/experience',
    },
    {
      label: 'Education',
      value: d.education ?? 0,
      icon: GraduationCap,
      color: 'emerald',
      to: '/education',
    },
    {
      label: 'Certifications',
      value: d.certifications ?? 0,
      icon: BadgeCheck,
      color: 'amber',
      to: '/certifications',
    },
    {
      label: 'Unread Inquiries',
      value: d.unreadMessages ?? 0,
      icon: Mail,
      color: 'rose',
      to: '/messages',
    },
  ]

  const quickActions = [
    {
      to: '/projects',
      title: 'Add New Project',
      desc: 'Publish a new work showcase',
      icon: FolderKanban,
    },
    {
      to: '/profile',
      title: 'Update Profile',
      desc: 'Edit bio, avatar, and social links',
      icon: UserRound,
    },
    {
      to: '/messages',
      title: 'Review Messages',
      desc: 'Check inquiries from visitors',
      icon: Mail,
    },
    {
      to: '/skills',
      title: 'Manage Tech Stack',
      desc: 'Update proficiencies & tools',
      icon: Wrench,
    },
  ]

  // Time-aware greeting
  const hour = new Date().getHours()
  const greeting =
    hour < 12 ? 'Good morning' : hour < 18 ? 'Good afternoon' : 'Good evening'

  return (
    <>
      <div className="dashboard-hero">
        <div className="dashboard-hero-content">
          <h2 className="dashboard-hero-title">
            {greeting}, Chiranjit 👋
          </h2>
          <p className="dashboard-hero-subtitle">
            Welcome to your portfolio CMS. Here is a high-level summary of your active portfolio assets and recent incoming inquiries.
          </p>
        </div>
      </div>

      <div className="stats-grid">
        {stats.map(({ label, value, icon: Icon, color, to }) => (
          <Link key={label} to={to} className="stat-card">
            <div className="stat-card-header">
              <span className="stat-card-label">{label}</span>
              <div className={`stat-card-icon ${color}`}>
                <Icon size={20} />
              </div>
            </div>
            <div className="stat-card-value">{value}</div>
          </Link>
        ))}
      </div>

      <div className="panel" style={{ marginBottom: '28px' }}>
        <div className="panel-header">
          <h3 className="panel-title">
            <Sparkles size={18} color="var(--primary)" />
            <span>Quick Actions</span>
          </h3>
        </div>

        <div className="quick-actions-grid">
          {quickActions.map(({ to, title, desc, icon: Icon }) => (
            <Link key={to} to={to} className="quick-action-btn">
              <div className="quick-action-icon">
                <Icon size={18} />
              </div>
              <div style={{ display: 'flex', flexDirection: 'column' }}>
                <span>{title}</span>
                <small style={{ color: 'var(--text-muted)', fontSize: '0.78rem' }}>
                  {desc}
                </small>
              </div>
            </Link>
          ))}
        </div>
      </div>

      <div className="grid-2">
        <div className="panel">
          <div className="panel-header">
            <h3 className="panel-title">
              <FolderKanban size={18} color="var(--primary)" />
              <span>Projects Quick Status</span>
            </h3>
            <Link to="/projects" className="btn btn-ghost btn-sm">
              <span>View All</span>
              <ArrowRight size={14} />
            </Link>
          </div>
          <p style={{ fontSize: '0.9rem', color: 'var(--text-secondary)' }}>
            You currently have <strong>{d.projects ?? 0}</strong> projects listed on your portfolio. Head over to the Projects manager to adjust featured showcases, links, and descriptions.
          </p>
        </div>

        <div className="panel">
          <div className="panel-header">
            <h3 className="panel-title">
              <Mail size={18} color="var(--accent-rose)" />
              <span>Inbox Status</span>
            </h3>
            <Link to="/messages" className="btn btn-ghost btn-sm">
              <span>Open Inbox</span>
              <ArrowRight size={14} />
            </Link>
          </div>
          <p style={{ fontSize: '0.9rem', color: 'var(--text-secondary)' }}>
            {d.unreadMessages > 0 ? (
              <span style={{ color: 'var(--accent-rose)', fontWeight: 600 }}>
                You have {d.unreadMessages} unread message{d.unreadMessages > 1 ? 's' : ''}!
              </span>
            ) : (
              'All messages have been reviewed. No pending unread inquiries.'
            )}
          </p>
        </div>
      </div>
    </>
  )
}
