import { motion } from 'framer-motion'
import { GraduationCap, Award, ArrowUpRight, Calendar, Landmark } from 'lucide-react'

export default function Education({ items = [], certifications = [] }) {
  return (
    <section id="education" className="section">
      <div className="container">
        {/* Section Header */}
        <div className="section-header">
          <span className="eyebrow">
            <GraduationCap size={14} /> Academic & Professional Growth
          </span>
          <h2 className="section-title">
            Education & <span className="accent-highlight">Certifications</span>
          </h2>
          <p className="section-subtitle">
            Formal qualifications, technical degrees, and verified professional credentials.
          </p>
        </div>

        <div className="edu-cert-grid">
          {/* Left Column: Education */}
          <motion.div
            className="edu-cert-column"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.35 }}
          >
            <h3>
              <GraduationCap size={20} color="var(--primary-light)" /> Formal Education
            </h3>

            <div className="edu-cert-stack">
              {items.length === 0 ? (
                <div className="edu-card" style={{ color: 'var(--text-muted)', textAlign: 'center', padding: '30px 20px' }}>
                  Education history will appear here once configured.
                </div>
              ) : (
                items.map((item) => {
                  let field = item.field
                  if (field && field.toLowerCase().includes('computer science')) {
                    field = 'Computer Science & Engineering'
                  }
                  return (
                    <article className="edu-card" key={item.id}>
                      <h4 className="edu-degree">{item.degree}</h4>
                      <div className="edu-institution">
                        <Landmark size={14} style={{ display: 'inline', marginRight: 5, verticalAlign: 'middle' }} />
                        {item.institution}
                        {field ? ` · ${field}` : ''}
                      </div>
                      {(item.startDate || item.endDate) && (
                        <div className="edu-date">
                          <Calendar size={13} style={{ display: 'inline', marginRight: 4, verticalAlign: 'middle' }} />
                          {item.startDate || ''} — {item.endDate || 'Present'}
                        </div>
                      )}
                      {item.description && (
                        <p style={{ marginTop: 10, color: 'var(--text-secondary)', fontSize: '0.88rem', lineHeight: 1.6 }}>
                          {item.description}
                        </p>
                      )}
                    </article>
                  )
                })
              )}
            </div>
          </motion.div>

          {/* Right Column: Certifications */}
          <motion.div
            className="edu-cert-column"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.35, delay: 0.1 }}
          >
            <h3>
              <Award size={20} color="var(--accent-purple)" /> Certifications & Credentials
            </h3>

            <div className="edu-cert-stack">
              {certifications.length === 0 ? (
                <div className="cert-card" style={{ color: 'var(--text-muted)', textAlign: 'center', padding: '30px 20px' }}>
                  Certifications will appear here once added.
                </div>
              ) : (
                certifications.map((item) => (
                  <article className="cert-card" key={item.id}>
                    <h4 className="cert-name">{item.name}</h4>
                    <div className="cert-issuer">
                      {item.issuer || 'Official Issuer'}
                      {item.issueDate ? ` · ${item.issueDate}` : ''}
                    </div>
                    {item.credentialUrl && (
                      <a
                        href={item.credentialUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="cert-verify-link"
                      >
                        Verify Credential <ArrowUpRight size={13} />
                      </a>
                    )}
                  </article>
                ))
              )}
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
}
