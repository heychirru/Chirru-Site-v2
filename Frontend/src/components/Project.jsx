import { motion } from 'framer-motion'
import { ArrowUpRight, Github } from 'lucide-react'

export default function Project({ projects, loading }) {
  return (
    <section id="projects" className="section">
      <div className="container">
        <p className="eyebrow">PROJECTS</p>
        <div className="section-heading"><h2>Selected work</h2><span>{projects.length} project{projects.length === 1 ? '' : 's'}</span></div>
        {loading ? <div className="empty">Loading projects…</div> : <div className="project-grid">
          {projects.length === 0 && <div className="empty">Projects will appear here once added from the admin panel.</div>}
          {projects.map((project, index) => (
            <motion.article key={project.id} className="project-card" initial={{ opacity: 0, y: 18 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: index * 0.06 }}>
              <div className="project-media">
                {project.imageUrl ? <img src={project.imageUrl} alt={project.title} loading="lazy" /> : <span>{project.title?.slice(0, 1) || 'P'}</span>}
              </div>
              <div className="project-body">
                <div className="project-meta">{project.featured ? 'FEATURED' : project.slug}</div>
                <h3>{project.title}</h3>
                <p>{project.description}</p>
                <div className="chips">{(project.skills || []).map((skill) => <span className="chip" key={skill.id}>{skill.name}</span>)}</div>
                <div className="project-links">
                  {project.githubUrl && <a href={project.githubUrl} target="_blank" rel="noreferrer"><Github size={15} /> GitHub</a>}
                  {project.liveUrl && <a href={project.liveUrl} target="_blank" rel="noreferrer">Live <ArrowUpRight size={15} /></a>}
                </div>
              </div>
            </motion.article>
          ))}
        </div>}
      </div>
    </section>
  )
}
