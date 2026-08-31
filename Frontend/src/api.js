const API_URL = (import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v2').replace(/\/$/, '')

async function request(path, options = {}) {
  const response = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      ...(options.body ? { 'Content-Type': 'application/json' } : {}),
      ...(options.headers || {}),
    },
  })

  if (!response.ok) {
    let message = `Request failed (${response.status})`
    try {
      const body = await response.json()
      message = body.message || message
    } catch {
      // Keep the default status message when the response is not JSON.
    }
    throw new Error(message)
  }

  if (response.status === 204) return null
  return response.json()
}

export const portfolioApi = {
  profile: () => request('/portfolio/profile'),
  projects: () => request('/portfolio/projects'),
  featuredProjects: () => request('/portfolio/projects?featured=true'),
  project: (slug) => request(`/portfolio/projects/${encodeURIComponent(slug)}`),
  skills: (category) => request(`/portfolio/skills${category ? `?category=${encodeURIComponent(category)}` : ''}`),
  experience: () => request('/portfolio/experience'),
  education: () => request('/portfolio/education'),
  certifications: () => request('/portfolio/certifications'),
  contact: (body) => request('/portfolio/contact', { method: 'POST', body: JSON.stringify(body) }),
}
