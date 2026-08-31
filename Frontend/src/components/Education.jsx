export default function Education({ items, certifications }) {
  return (
    <section id="education" className="section">
      <div className="container">
        <p className="eyebrow">EDUCATION</p>
        <div className="stack">
          {items.length === 0 && <div className="empty">Education will appear here once added from the admin panel.</div>}
          {items.map((item) => (
            <article className="card" key={item.id}>
              <h3>{item.degree}</h3>
              <p className="muted">{item.institution}{item.field ? ` · ${item.field}` : ''}</p>
              {(item.startDate || item.endDate) && <p className="small">{item.startDate || ''} — {item.endDate || 'Present'}</p>}
              {item.description && <p>{item.description}</p>}
            </article>
          ))}
        </div>

        <div id="certifications" className="subsection">
          <p className="eyebrow">CERTIFICATIONS</p>
          <div className="stack">
            {certifications.length === 0 && <div className="empty">Certifications will appear here once added from the admin panel.</div>}
            {certifications.map((item) => (
              <article className="card" key={item.id}>
                <h3>{item.name}</h3>
                <p className="muted">{item.issuer || 'Certification'}{item.issueDate ? ` · ${item.issueDate}` : ''}</p>
                {item.credentialUrl && <a href={item.credentialUrl} target="_blank" rel="noreferrer">View credential <span aria-hidden="true">↗</span></a>}
              </article>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
}
