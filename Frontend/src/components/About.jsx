export default function About({ profile, skills }) {
  const visibleSkills = skills.slice(0, 12)

  return (
    <section id="about" className="section">
      <div className="container two-column">
        <div>
          <p className="eyebrow">ABOUT</p>
          <h2>{profile.name || 'Chirru'}</h2>
        </div>
        <div className="copy">
          <p>{profile.bio || 'Portfolio content is managed from the private admin dashboard.'}</p>
          <p className="muted">{profile.location || 'India'}</p>
          <div className="chips">
            {visibleSkills.map((skill) => <span className="chip" key={skill.id}>{skill.name}</span>)}
          </div>
        </div>
      </div>
    </section>
  )
}
