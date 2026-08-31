import { useQuery, useQueryClient } from '@tanstack/react-query'
import {
  ExternalLink,
  FolderKanban,
  Github,
  Plus,
  Search,
  Star,
  Trash2,
} from 'lucide-react'
import { useState } from 'react'
import { adminApi } from '../api'

export default function Projects() {
  const qc = useQueryClient()
  const q = useQuery({ queryKey: ['projects'], queryFn: adminApi.projects })

  const [title, setTitle] = useState('')
  const [slug, setSlug] = useState('')
  const [description, setDescription] = useState('')
  const [featured, setFeatured] = useState(false)
  const [liveUrl, setLiveUrl] = useState('')
  const [githubUrl, setGithubUrl] = useState('')
  const [search, setSearch] = useState('')

  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [busy, setBusy] = useState(false)

  if (q.isLoading) {
    return (
      <div className="loading-state">
        <div className="spinner" />
        <span>Loading projects…</span>
      </div>
    )
  }

  // Auto-generate slug from title if slug not modified manually
  const handleTitleChange = (val) => {
    setTitle(val)
    if (!slug || slug === title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')) {
      setSlug(val.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, ''))
    }
  }

  async function handleAddProject(e) {
    e.preventDefault()
    setBusy(true)
    setError('')
    setSuccess('')

    try {
      await adminApi.createProject({
        title,
        slug,
        description,
        featured,
        displayOrder: 0,
        liveUrl: liveUrl || undefined,
        githubUrl: githubUrl || undefined,
        skillIds: [],
      })
      setTitle('')
      setSlug('')
      setDescription('')
      setFeatured(false)
      setLiveUrl('')
      setGithubUrl('')
      setSuccess('Project added successfully!')
      await qc.invalidateQueries({ queryKey: ['projects'] })
      await qc.invalidateQueries({ queryKey: ['dashboard'] })
    } catch (err) {
      setError(err.message || 'Failed to create project.')
    } finally {
      setBusy(false)
    }
  }

  async function handleDeleteProject(id, projectTitle) {
    if (!window.confirm(`Are you sure you want to delete "${projectTitle}"?`)) return
    try {
      await adminApi.deleteProject(id)
      await qc.invalidateQueries({ queryKey: ['projects'] })
      await qc.invalidateQueries({ queryKey: ['dashboard'] })
    } catch (err) {
      alert(err.message || 'Could not delete project.')
    }
  }

  const projects = q.data || []
  const filteredProjects = projects.filter((p) =>
    (p.title || '').toLowerCase().includes(search.toLowerCase()) ||
    (p.slug || '').toLowerCase().includes(search.toLowerCase()) ||
    (p.description || '').toLowerCase().includes(search.toLowerCase())
  )

  return (
    <>
      <div className="page-header">
        <div className="page-header-text">
          <h1>
            <FolderKanban size={26} color="var(--primary)" />
            <span>Projects Showcase</span>
          </h1>
          <p>Create, manage, and curate featured projects for your portfolio.</p>
        </div>
      </div>

      <div className="grid-split">
        {/* Left Column: Create Project Form */}
        <div className="panel">
          <div className="panel-header">
            <h3 className="panel-title">
              <Plus size={18} color="var(--primary)" />
              <span>Create New Project</span>
            </h3>
          </div>

          <form className="form" onSubmit={handleAddProject}>
            {error && <div className="alert alert-error">{error}</div>}
            {success && <div className="alert alert-success">{success}</div>}

            <div className="form-group">
              <label className="form-label">Project Title *</label>
              <input
                className="form-input"
                value={title}
                onChange={(e) => handleTitleChange(e.target.value)}
                placeholder="e.g. AI Workflow Engine"
                required
              />
            </div>

            <div className="form-group">
              <label className="form-label">Unique Slug / URL Path *</label>
              <input
                className="form-input"
                value={slug}
                onChange={(e) => setSlug(e.target.value)}
                placeholder="ai-workflow-engine"
                required
              />
            </div>

            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Live Demo URL</label>
                <input
                  className="form-input"
                  type="url"
                  value={liveUrl}
                  onChange={(e) => setLiveUrl(e.target.value)}
                  placeholder="https://app.domain.com"
                />
              </div>
              <div className="form-group">
                <label className="form-label">GitHub Repository</label>
                <input
                  className="form-input"
                  type="url"
                  value={githubUrl}
                  onChange={(e) => setGithubUrl(e.target.value)}
                  placeholder="https://github.com/..."
                />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Description *</label>
              <textarea
                className="form-textarea"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                placeholder="Describe the architectural highlights, challenges solved, and key features..."
                rows={4}
                required
              />
            </div>

            <div className="form-group">
              <label className="form-checkbox-label">
                <input
                  type="checkbox"
                  className="form-checkbox"
                  checked={featured}
                  onChange={(e) => setFeatured(e.target.checked)}
                />
                <span>Feature this project on hero/homepage</span>
              </label>
            </div>

            <button type="submit" className="btn btn-primary" disabled={busy}>
              {busy ? (
                <>
                  <div className="spinner" style={{ width: 16, height: 16 }} />
                  <span>Saving Project…</span>
                </>
              ) : (
                <>
                  <Plus size={16} />
                  <span>Add Project</span>
                </>
              )}
            </button>
          </form>
        </div>

        {/* Right Column: Existing Projects List */}
        <div className="panel">
          <div className="panel-header">
            <h3 className="panel-title">
              <span>Existing Projects ({filteredProjects.length})</span>
            </h3>
          </div>

          <div className="toolbar" style={{ marginBottom: '16px' }}>
            <div className="search-box" style={{ maxWidth: '100%' }}>
              <Search size={16} />
              <input
                className="form-input"
                placeholder="Search projects..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
            </div>
          </div>

          {filteredProjects.length === 0 ? (
            <div className="empty-state">
              <div className="empty-state-icon">
                <FolderKanban size={24} />
              </div>
              <p>No projects found matching your query.</p>
            </div>
          ) : (
            <div className="data-list">
              {filteredProjects.map((project) => (
                <div className="data-row" key={project.id}>
                  <div className="data-row-main">
                    <div className="data-row-title">
                      <span>{project.title}</span>
                      {project.featured && (
                        <span className="badge badge-amber">
                          <Star size={11} fill="currentColor" />
                          Featured
                        </span>
                      )}
                    </div>
                    <div className="data-row-subtitle">
                      <code>/{project.slug}</code>
                      {project.liveUrl && (
                        <a
                          href={project.liveUrl}
                          target="_blank"
                          rel="noreferrer"
                          style={{ display: 'inline-flex', alignItems: 'center', gap: 3, color: 'var(--primary)' }}
                        >
                          <ExternalLink size={12} /> Live
                        </a>
                      )}
                      {project.githubUrl && (
                        <a
                          href={project.githubUrl}
                          target="_blank"
                          rel="noreferrer"
                          style={{ display: 'inline-flex', alignItems: 'center', gap: 3, color: 'var(--text-secondary)' }}
                        >
                          <Github size={12} /> Code
                        </a>
                      )}
                    </div>
                  </div>

                  <div className="data-row-actions">
                    <button
                      className="btn btn-danger btn-sm btn-icon"
                      onClick={() => handleDeleteProject(project.id, project.title)}
                      title="Delete Project"
                    >
                      <Trash2 size={15} />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </>
  )
}
