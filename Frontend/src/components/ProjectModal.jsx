import { useState, useEffect } from 'react'
import { useQuery } from '@tanstack/react-query'
import { motion, AnimatePresence } from 'framer-motion'
import { X, Github, ArrowUpRight, CheckCircle2, AlertTriangle, Layers, Award, Terminal, FolderGit2 } from 'lucide-react'
import { portfolioApi } from '../api'

export default function ProjectModal({ project, onClose }) {
  const [heroImgError, setHeroImgError] = useState(false)
  const projectId = project?.id

  // Reset img error if project changes
  useEffect(() => {
    setHeroImgError(false)
  }, [projectId])

  const caseStudyQuery = useQuery({
    queryKey: ['caseStudy', projectId],
    queryFn: () => portfolioApi.caseStudy(projectId),
    enabled: !!projectId,
  })

  // Track project view analytics
  useEffect(() => {
    if (projectId) {
      portfolioApi.trackEvent('project_view', {
        projectId: projectId,
        projectTitle: project.title,
      })
    }
  }, [projectId, project?.title])

  const caseStudy = caseStudyQuery.data || {}

  // Parse features or challenges if JSON string/array
  let featuresList = []
  if (Array.isArray(caseStudy.features)) {
    featuresList = caseStudy.features
  } else if (typeof caseStudy.features === 'string' && caseStudy.features.trim()) {
    try {
      featuresList = JSON.parse(caseStudy.features)
    } catch {
      featuresList = caseStudy.features.split('\n').filter(Boolean)
    }
  }

  let screenshotsList = []
  if (Array.isArray(caseStudy.screenshots)) {
    screenshotsList = caseStudy.screenshots
  } else if (typeof caseStudy.screenshots === 'string' && caseStudy.screenshots.trim()) {
    try {
      screenshotsList = JSON.parse(caseStudy.screenshots)
    } catch {
      screenshotsList = caseStudy.screenshots.split('\n').filter(Boolean)
    }
  }

  return (
    <AnimatePresence>
      {project && (
        <div className="modal-overlay" onClick={onClose}>
          <motion.div
            className="modal-card"
            initial={{ opacity: 0, scale: 0.95, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 20 }}
            transition={{ duration: 0.25, ease: 'easeOut' }}
            onClick={(e) => e.stopPropagation()}
          >
            {/* Header */}
            <div className="modal-header">
              <div>
                <span className="eyebrow" style={{ marginBottom: 4, padding: '3px 10px', fontSize: '0.72rem' }}>
                  {project.featured ? 'Featured Case Study' : 'Project Breakdown'}
                </span>
                <h2 style={{ fontFamily: 'var(--font-sans)', fontSize: '1.4rem', fontWeight: 700 }}>
                  {project.title}
                </h2>
              </div>
              <button className="modal-close-btn" onClick={onClose} aria-label="Close modal">
                <X size={18} />
              </button>
            </div>

            {/* Body */}
            <div className="modal-body">
              {/* Project Hero Image */}
              <div className="case-study-hero">
                {project.imageUrl && !heroImgError ? (
                  <img
                    src={project.imageUrl}
                    alt={project.title}
                    onError={() => setHeroImgError(true)}
                  />
                ) : (
                  <div className="case-study-hero-fallback">
                    <div className="project-fallback-icon-wrap">
                      <FolderGit2 size={36} />
                    </div>
                    <span style={{ fontSize: '1.1rem', fontWeight: 700, color: 'var(--text-secondary)' }}>
                      {project.title}
                    </span>
                  </div>
                )}
              </div>

              {/* Overview & Quick Links */}
              <div>
                <h3 className="case-study-section-title">Overview</h3>
                <p className="case-study-text">
                  {caseStudy.summary || project.description}
                </p>
                <div style={{ display: 'flex', gap: 12, marginTop: 16, flexWrap: 'wrap' }}>
                  {project.liveUrl && (
                    <a href={project.liveUrl} target="_blank" rel="noreferrer" className="btn btn-primary btn-sm">
                      Visit Live Demo <ArrowUpRight size={15} />
                    </a>
                  )}
                  {project.githubUrl && (
                    <a href={project.githubUrl} target="_blank" rel="noreferrer" className="btn btn-secondary btn-sm">
                      <Github size={15} /> View Source Code
                    </a>
                  )}
                </div>
              </div>

              {/* Technologies */}
              {((project.skills && project.skills.length > 0) || caseStudy.technologies) && (
                <div>
                  <h3 className="case-study-section-title" style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                    <Layers size={18} color="var(--primary-light)" /> Tech Stack & Architecture
                  </h3>
                  <div className="project-tech-tags" style={{ marginTop: 8 }}>
                    {(project.skills || []).map((skill) => (
                      <span className="tech-chip" key={skill.id || skill.name}>
                        {skill.name}
                      </span>
                    ))}
                    {caseStudy.technologies && typeof caseStudy.technologies === 'string' && (
                      <span className="tech-chip" style={{ background: 'var(--primary-subtle)', color: 'var(--primary-light)' }}>
                        {caseStudy.technologies}
                      </span>
                    )}
                  </div>
                </div>
              )}

              {/* Problem & Solution */}
              {caseStudy.problem && (
                <div style={{ background: 'var(--bg-surface-elevated)', padding: 20, borderRadius: 'var(--radius-lg)', border: '1px solid var(--border-subtle)' }}>
                  <h4 style={{ color: 'var(--accent-amber)', fontSize: '0.95rem', fontWeight: 700, marginBottom: 6, display: 'flex', alignItems: 'center', gap: 6 }}>
                    <AlertTriangle size={16} /> Problem Statement
                  </h4>
                  <p className="case-study-text" style={{ fontSize: '0.9rem' }}>
                    {caseStudy.problem}
                  </p>
                </div>
              )}

              {caseStudy.solution && (
                <div style={{ background: 'var(--bg-surface-elevated)', padding: 20, borderRadius: 'var(--radius-lg)', border: '1px solid var(--border-subtle)' }}>
                  <h4 style={{ color: 'var(--accent-emerald)', fontSize: '0.95rem', fontWeight: 700, marginBottom: 6, display: 'flex', alignItems: 'center', gap: 6 }}>
                    <CheckCircle2 size={16} /> Engineering Solution
                  </h4>
                  <p className="case-study-text" style={{ fontSize: '0.9rem' }}>
                    {caseStudy.solution}
                  </p>
                </div>
              )}

              {/* Key Features */}
              {featuresList.length > 0 && (
                <div>
                  <h3 className="case-study-section-title" style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                    <Terminal size={18} color="var(--primary-light)" /> Key Implementation Features
                  </h3>
                  <ul style={{ listStyle: 'none', display: 'flex', flexDirection: 'column', gap: 10, marginTop: 10 }}>
                    {featuresList.map((feat, idx) => (
                      <li key={idx} style={{ display: 'flex', alignItems: 'flex-start', gap: 10, fontSize: '0.92rem', color: 'var(--text-secondary)' }}>
                        <CheckCircle2 size={16} color="var(--primary-light)" style={{ flexShrink: 0, marginTop: 3 }} />
                        <span>{typeof feat === 'string' ? feat : JSON.stringify(feat)}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {/* Results & Outcomes */}
              {caseStudy.results && (
                <div style={{ background: 'rgba(99, 102, 241, 0.08)', padding: 20, borderRadius: 'var(--radius-lg)', border: '1px solid var(--border-highlight)' }}>
                  <h4 style={{ color: 'var(--primary-light)', fontSize: '0.95rem', fontWeight: 700, marginBottom: 6, display: 'flex', alignItems: 'center', gap: 6 }}>
                    <Award size={16} /> Results & Impact
                  </h4>
                  <p className="case-study-text" style={{ fontSize: '0.9rem' }}>
                    {caseStudy.results}
                  </p>
                </div>
              )}

              {/* Additional Screenshots */}
              {screenshotsList.length > 0 && (
                <div>
                  <h3 className="case-study-section-title">Media & Screenshots</h3>
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: 14, marginTop: 10 }}>
                    {screenshotsList.map((shot, idx) => (
                      <div key={idx} style={{ borderRadius: 'var(--radius-md)', overflow: 'hidden', border: '1px solid var(--border-subtle)' }}>
                        <img src={shot} alt={`Screenshot ${idx + 1}`} style={{ width: '100%', height: 'auto', display: 'block' }} />
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  )
}
