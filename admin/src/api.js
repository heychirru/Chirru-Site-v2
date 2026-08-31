const API_URL = (import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v2').replace(/\/$/, '')
const TOKEN_KEY = 'chirru_admin_access_token'

export const authStore = {
  get: () => sessionStorage.getItem(TOKEN_KEY),
  set: token => sessionStorage.setItem(TOKEN_KEY, token),
  clear: () => sessionStorage.removeItem(TOKEN_KEY),
}

async function request(path, options = {}, retry = true) {
  const token = authStore.get()
  const response = await fetch(`${API_URL}${path}`, {
    ...options,
    credentials: 'include',
    headers: {
      ...(options.body ? { 'Content-Type': 'application/json' } : {}),
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(options.headers || {}),
    },
  })
  if (response.status === 401 && retry && !path.startsWith('/auth/')) {
    try {
      const refreshed = await request('/auth/refresh', { method: 'POST' }, false)
      authStore.set(refreshed.accessToken)
      return request(path, options, false)
    } catch {
      authStore.clear()
    }
  }
  if (!response.ok) {
    let message = `Request failed (${response.status})`
    try {
      const body = await response.json()
      message = body.message || message
    } catch {}
    throw new Error(message)
  }
  if (response.status === 204) return null
  return response.json()
}

export const auth = {
  login: (email, password) => request('/auth/login', { method: 'POST', body: JSON.stringify({ email, password }) }, false),
  refresh: () => request('/auth/refresh', { method: 'POST' }, false),
  logout: () => request('/auth/logout', { method: 'POST' }, false),
}

export const adminApi = {
  dashboard: () => request('/admin/dashboard'),
  profile: () => request('/admin/profile'),
  saveProfile: body => request('/admin/profile', { method: 'PUT', body: JSON.stringify(body) }),
  
  projects: () => request('/admin/projects'),
  createProject: body => request('/admin/projects', { method: 'POST', body: JSON.stringify(body) }),
  updateProject: (id, body) => request(`/admin/projects/${id}`, { method: 'PUT', body: JSON.stringify(body) }),
  deleteProject: id => request(`/admin/projects/${id}`, { method: 'DELETE' }),

  skills: () => request('/admin/skills'),
  createSkill: body => request('/admin/skills', { method: 'POST', body: JSON.stringify(body) }),
  updateSkill: (id, body) => request(`/admin/skills/${id}`, { method: 'PUT', body: JSON.stringify(body) }),
  deleteSkill: id => request(`/admin/skills/${id}`, { method: 'DELETE' }),

  experience: () => request('/admin/experience'),
  createExperience: body => request('/admin/experience', { method: 'POST', body: JSON.stringify(body) }),
  updateExperience: (id, body) => request(`/admin/experience/${id}`, { method: 'PUT', body: JSON.stringify(body) }),
  deleteExperience: id => request(`/admin/experience/${id}`, { method: 'DELETE' }),

  education: () => request('/admin/education'),
  createEducation: body => request('/admin/education', { method: 'POST', body: JSON.stringify(body) }),
  updateEducation: (id, body) => request(`/admin/education/${id}`, { method: 'PUT', body: JSON.stringify(body) }),
  deleteEducation: id => request(`/admin/education/${id}`, { method: 'DELETE' }),

  certifications: () => request('/admin/certifications'),
  createCertification: body => request('/admin/certifications', { method: 'POST', body: JSON.stringify(body) }),
  updateCertification: (id, body) => request(`/admin/certifications/${id}`, { method: 'PUT', body: JSON.stringify(body) }),
  deleteCertification: id => request(`/admin/certifications/${id}`, { method: 'DELETE' }),

  messages: () => request('/admin/messages'),
  markMessage: (id, read) => request(`/admin/messages/${id}/read`, { method: 'PATCH', body: JSON.stringify({ read }) }),
  deleteMessage: id => request(`/admin/messages/${id}`, { method: 'DELETE' }),
}
