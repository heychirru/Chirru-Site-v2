export default function Internship({ items }) {
  return (
    <section id="experience" className="section">
      <div className="container">
        <p className="eyebrow">EXPERIENCE</p>
        <div className="section-heading"><h2>Where I’ve worked</h2><span>{items.length} role{items.length === 1 ? '' : 's'}</span></div>
        <div className="timeline">
          {items.length === 0 && <div className="empty">Experience will appear here once added from the admin panel.</div>}
          {items.map((item) => (
            <article className="timeline-item" key={item.id}>
              <div className="timeline-date">{item.startDate} — {item.current ? 'Present' : item.endDate}</div>
              <div><h3>{item.position}</h3><p className="muted">{item.company}</p><p>{item.description}</p></div>
            </article>
          ))}
        </div>
      </div>
    </section>
  )
}
