import { useState, useMemo } from 'react'
import { motion } from 'framer-motion'
import { ArrowUpRight, Github, FolderGit2 } from 'lucide-react'

function ProjectCardMedia({ project }) {
  const [imgError, setImgError] = useState(false)
  const hasValidImage = Boolean(project.imageUrl && !imgError)

  return (
    <div className="project-media-wrapper">
      {hasValidImage ? (
        <img
          src={project.imageUrl}
          alt={project.title}
          className="project-thumbnail"
          loading="lazy"
          onError={() => setImgError(true)}
        />
      ) : (
        <div className="project-fallback-container">
          <div className="project-fallback-icon-wrap">
            <FolderGit2 size={28} />
          </div>
          <span className="project-fallback-title">{project.title}</span>
        </div>
      )}
      {project.featured && <span className="project-featured-badge">Featured</span>}
    </div>
  )
}

export default function Project({ projects = [], loading }) {
  const [activeFilter, setActiveFilter] = useState('all')

  const filterOptions = useMemo(() => {
    return [
      { id: 'all', label: 'All Projects' },
      { id: 'featured', label: 'Featured Work' },
    ]
  }, [])

  const filteredProjects = useMemo(() => {
    if (activeFilter === 'featured') {
      return projects.filter((p) => p.featured)
    }
    return projects
  }, [projects, activeFilter])

  return (
    <section id="projects" className="section">
      <div className="container">
        {/* Section Header */}
        <div className="section-header">
          <span className="eyebrow">
            <FolderGit2 size={14} /> Portfolio Projects
          </span>
          <h2 className="section-title">
            Featured <span className="accent-highlight">Projects</span>
          </h2>
          <p className="section-subtitle">
            Selected software architectures, web applications, and systems built with modern tech stacks.
          </p>
        </div>

        {/* Filter Bar */}
        <div className="projects-filter-bar">
          <div className="filter-pills">
            {filterOptions.map((opt) => (
              <button
                key={opt.id}
                className={`filter-pill ${activeFilter === opt.id ? 'active' : ''}`}
                onClick={() => setActiveFilter(opt.id)}
              >
                {opt.label}
              </button>
            ))}
          </div>
          <span className="kbd-badge" style={{ padding: '4px 10px' }}>
            Showing {filteredProjects.length} of {projects.length}
          </span>
        </div>

        {/* Projects Grid */}
        {loading ? (
          <div style={{ padding: '60px 0', textAlign: 'center', color: 'var(--text-muted)' }}>
            Loading projects...
          </div>
        ) : filteredProjects.length === 0 ? (
          <div style={{ padding: '60px 20px', textAlign: 'center', background: 'var(--bg-surface)', borderRadius: 'var(--radius-xl)', border: '1px dashed var(--border-medium)', color: 'var(--text-muted)' }}>
            No projects found in this view.
          </div>
        ) : (
          <div className="projects-grid">
            {filteredProjects.map((project, index) => {
              // Clean description if it's test characters
              let desc = project.description
              if (!desc || desc.length < 6 || desc === 'dfsb') {
                desc = 'A modern full-stack web application developed with Java, Spring Boot, and reactive frontend architecture.'
              }

              return (
                <motion.article
                  key={project.id || project.slug || index}
                  className="project-card"
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.35, delay: index * 0.06 }}
                >
                  {/* Media Thumbnail */}
                  <ProjectCardMedia project={project} />

                  {/* Card Body */}
                  <div className="project-card-body">
                    <h3 className="project-card-title">
                      {project.title}
                    </h3>
                    <p className="project-card-desc">{desc}</p>

                    {/* Skills / Tech Tags */}
                    {project.skills && project.skills.length > 0 && (
                      <div className="project-tech-tags">
                        {project.skills.map((skill) => (
                          <span className="tech-chip" key={skill.id || skill.name}>
                            {skill.name}
                          </span>
                        ))}
                      </div>
                    )}

                    {/* Card Footer with Live and Code Links */}
                    <div className="project-card-footer">
                      <div className="project-action-links">
                        {project.liveUrl && (
                          <a
                            href={project.liveUrl}
                            target="_blank"
                            rel="noreferrer"
                            className="project-action-link"
                            aria-label="Visit live demo"
                          >
                            <ArrowUpRight size={15} /> Live Demo
                          </a>
                        )}
                        {project.githubUrl && (
                          <a
                            href={project.githubUrl}
                            target="_blank"
                            rel="noreferrer"
                            className="project-action-link"
                            aria-label="View source code on GitHub"
                          >
                            <Github size={15} /> Code
                          </a>
                        )}
                      </div>
                    </div>
                  </div>
                </motion.article>
              )
            })}
          </div>
        )}
      </div>
    </section>
  )
}
