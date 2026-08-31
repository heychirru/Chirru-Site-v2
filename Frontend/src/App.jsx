import { useQuery } from '@tanstack/react-query'
import { useState } from 'react'
import { portfolioApi } from './api'
import About from './components/About'
import Contact from './components/Contact'
import Education from './components/Education'
import Footer from './components/Footer'
import Hero from './components/Hero'
import Internship from './components/Internship'
import Navbar from './components/Navbar'
import Project from './components/Project'
import ResponsiveMenu from './components/ResponsiveMenu'

export default function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const profile = useQuery({ queryKey: ['profile'], queryFn: portfolioApi.profile })
  const projects = useQuery({ queryKey: ['projects'], queryFn: portfolioApi.projects })
  const skills = useQuery({ queryKey: ['skills'], queryFn: portfolioApi.skills })
  const experience = useQuery({ queryKey: ['experience'], queryFn: portfolioApi.experience })
  const education = useQuery({ queryKey: ['education'], queryFn: portfolioApi.education })
  const certifications = useQuery({ queryKey: ['certifications'], queryFn: portfolioApi.certifications })

  const data = profile.data || {}

  return (
    <div className="site-shell">
      <Navbar onMenu={() => setMenuOpen(true)} />
      <ResponsiveMenu open={menuOpen} onClose={() => setMenuOpen(false)} />
      <main>
        <Hero profile={data} />
        <About profile={data} skills={skills.data || []} />
        <Internship items={experience.data || []} />
        <Project projects={projects.data || []} loading={projects.isLoading || profile.isLoading} />
        <Education items={education.data || []} certifications={certifications.data || []} />
        <Contact />
      </main>
      <Footer profile={data} />
    </div>
  )
}
