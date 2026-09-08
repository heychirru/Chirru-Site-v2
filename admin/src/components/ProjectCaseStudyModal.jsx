import { useQuery, useQueryClient } from '@tanstack/react-query'
import {
  Check,
  FileCode2,
  FolderKanban,
  Plus,
  Save,
  Trash2,
  X,
} from 'lucide-react'
import { useEffect, useState } from 'react'
import { adminApi } from '../api'

export default function ProjectCaseStudyModal({ project, onClose }) {
  const qc = useQueryClient()
  const projectId = project?.id

  const caseStudyQuery = useQuery({
    queryKey: ['case-study', projectId],
    queryFn: () => adminApi.caseStudy(projectId),
    enabled: Boolean(projectId),
  })

  const tagsQuery = useQuery({
    queryKey: ['tags'],
    queryFn: adminApi.tags,
  })

  const projectTagsQuery = useQuery({
    queryKey: ['project-tags', projectId],
    queryFn: () => adminApi.projectTags(projectId),
    enabled: Boolean(projectId),
  })

  const [formData, setFormData] = useState({
    problem: '',
    solution: '',
    architecture: '',
    challenges: '',
    results: '',
    technologies: '',
    githubUrl: '',
    liveUrl: '',
  })

  const [selectedTagIds, setSelectedTagIds] = useState([])
  const [busy, setBusy] = useState(false)
  const [msg, setMsg] = useState({ text: '', type: '' })

  useEffect(() => {
    if (caseStudyQuery.data) {
      const d = caseStudyQuery.data
      setFormData({
        problem: d.problem || '',
        solution: d.solution || '',
        architecture: d.architecture || '',
        challenges: d.challenges || '',
        results: d.results || '',
        technologies: d.technologies || '',
        githubUrl: d.githubUrl || project?.githubUrl || '',
        liveUrl: d.liveUrl || project?.liveUrl || '',
      })
    }
  }, [caseStudyQuery.data, project])

  useEffect(() => {
    if (projectTagsQuery.data && Array.isArray(projectTagsQuery.data)) {
      setSelectedTagIds(projectTagsQuery.data.map((t) => t.id || t))
    }
  }, [projectTagsQuery.data])

  const toggleTag = (tagId) => {
    setSelectedTagIds((prev) =>
      prev.includes(tagId) ? prev.filter((id) => id !== tagId) : [...prev, tagId]
    )
  }

  async function handleSave(e) {
    e.preventDefault()
    setBusy(true)
    setMsg({ text: '', type: '' })
    try {
      await adminApi.saveCaseStudy(projectId, formData)
      await adminApi.saveProjectTags(projectId, selectedTagIds)
      setMsg({ text: 'Case study & project tags saved successfully!', type: 'success' })
      await qc.invalidateQueries({ queryKey: ['case-study', projectId] })
      await qc.invalidateQueries({ queryKey: ['project-tags', projectId] })
      await qc.invalidateQueries({ queryKey: ['projects'] })
    } catch (err) {
      setMsg({ text: err.message || 'Failed to save case study.', type: 'error' })
    } finally {
      setBusy(false)
    }
  }

  const allTags = tagsQuery.data || []

  return (
    <div className="modal-backdrop" onClick={onClose}>
      <div
        className="modal-card"
        style={{ maxWidth: 780, maxHeight: '90vh', overflowY: 'auto' }}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div>
            <h2 style={{ fontSize: '1.2rem', display: 'flex', alignItems: 'center', gap: 8 }}>
              <FileCode2 size={20} color="var(--primary)" />
              <span>Case Study: {project?.title || project?.name}</span>
            </h2>
            <p style={{ fontSize: '0.82rem', color: 'var(--text-secondary)', marginTop: 2 }}>
              Detailed architectural problem statement, challenges, and measurable results.
            </p>
          </div>
          <button type="button" className="btn btn-secondary btn-sm btn-icon" onClick={onClose}>
            <X size={16} />
          </button>
        </div>

        <form className="form" onSubmit={handleSave} style={{ padding: '20px' }}>
          {msg.text && (
            <div className={`alert ${msg.type === 'success' ? 'alert-success' : 'alert-error'}`}>
              {msg.text}
            </div>
          )}

          {/* Tag Selector */}
          <div className="form-group">
            <label className="form-label">Assign Project Tags</label>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, padding: '8px 0' }}>
              {allTags.map((tag) => {
                const isSelected = selectedTagIds.includes(tag.id)
                return (
                  <button
                    key={tag.id}
                    type="button"
                    className={`btn btn-sm ${isSelected ? 'btn-primary' : 'btn-secondary'}`}
                    onClick={() => toggleTag(tag.id)}
                    style={{ borderRadius: 16, fontSize: '0.78rem' }}
                  >
                    {isSelected && <Check size={12} />}
                    <span>{tag.name}</span>
                  </button>
                )
              })}
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Problem Statement</label>
            <textarea
              className="form-textarea"
              rows={3}
              placeholder="What core problem or architectural challenge does this project solve?"
              value={formData.problem}
              onChange={(e) => setFormData((prev) => ({ ...prev, problem: e.target.value }))}
            />
          </div>

          <div className="form-group">
            <label className="form-label">Solution & Implementation</label>
            <textarea
              className="form-textarea"
              rows={3}
              placeholder="Technical approach, frameworks used, and architecture overview..."
              value={formData.solution}
              onChange={(e) => setFormData((prev) => ({ ...prev, solution: e.target.value }))}
            />
          </div>

          <div className="form-group">
            <label className="form-label">Architecture & Data Flow</label>
            <textarea
              className="form-textarea"
              rows={3}
              placeholder="Describe database design, API design, caching, or microservices structure..."
              value={formData.architecture}
              onChange={(e) => setFormData((prev) => ({ ...prev, architecture: e.target.value }))}
            />
          </div>

          <div className="form-group">
            <label className="form-label">Challenges & Engineering Trade-offs</label>
            <textarea
              className="form-textarea"
              rows={3}
              placeholder="Key bottlenecks encountered, performance trade-offs, and lessons learned..."
              value={formData.challenges}
              onChange={(e) => setFormData((prev) => ({ ...prev, challenges: e.target.value }))}
            />
          </div>

          <div className="form-group">
            <label className="form-label">Results & Key Metrics</label>
            <textarea
              className="form-textarea"
              rows={2}
              placeholder="e.g. 40% reduction in latency, 99.9% uptime, 10k+ active users..."
              value={formData.results}
              onChange={(e) => setFormData((prev) => ({ ...prev, results: e.target.value }))}
            />
          </div>

          <div style={{ display: 'flex', justifyContent: 'flex-end', gap: 12, marginTop: 12 }}>
            <button type="button" className="btn btn-secondary" onClick={onClose}>
              Close
            </button>
            <button type="submit" className="btn btn-primary" disabled={busy}>
              {busy ? (
                <>
                  <div className="spinner" style={{ width: 16, height: 16 }} />
                  <span>Saving…</span>
                </>
              ) : (
                <>
                  <Save size={16} />
                  <span>Save Case Study</span>
                </>
              )}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
