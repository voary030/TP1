import axios from 'axios'
import mockApi from './mockApi'

// Utiliser l'API mock seulement si explicitement activé via variable d'environnement
const USE_MOCK_API = import.meta.env.VITE_USE_MOCK_API === 'true'

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8060'

const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json'
  }
})

// Intercepteur pour ajouter le token à chaque requête
apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('authToken')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// Intercepteur pour gérer les erreurs
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('authToken')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export default {
  // Authentication
  login(credentials) {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for login')
      return mockApi.login(credentials)
    }
    // Utiliser l'endpoint admin pour tous les logins (car seuls les admins se connectent)
    return apiClient.post('/api/auth/admin/login', {
      email: credentials.email,
      mot_de_passe: credentials.password
    })
  },

  // Semesters
  getSemesters() {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for getSemesters')
      return mockApi.getSemesters()
    }
    return apiClient.get('/api/semesters')
  },

  getParcoursBySemester(semesterId) {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for getParcoursBySemester')
      return mockApi.getParcoursBySemester(semesterId)
    }
    return apiClient.get(`/api/semesters/${semesterId}/parcours`)
  },

  // Students
  getAllStudents() {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for getAllStudents')
      return mockApi.getAllStudents()
    }
    return apiClient.get('/api/students')
  },

  getStudentById(studentId) {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for getStudentById')
      return mockApi.getStudentById(studentId)
    }
    return apiClient.get(`/api/students/${studentId}`)
  },

  // Grades
  getSemesterGrades(studentId, semesterId, parcoursId) {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for getSemesterGrades')
      return mockApi.getSemesterGrades(studentId, semesterId)
    }
    // Construire l'URL avec ou sans le paramètre parcoursId
    let url = `/api/students/${studentId}/semesters/${semesterId}/grades`
    if (parcoursId) {
      url += `?parcoursId=${parcoursId}`
    }
    return apiClient.get(url)
  },

  getYearGrades(studentId, yearLevel) {
    if (USE_MOCK_API) {
      console.log('🔷 Using MOCK API for getYearGrades')
      return mockApi.getYearGrades(studentId, yearLevel)
    }
    return apiClient.get(`/api/students/${studentId}/years/${yearLevel}/grades`)
  }
}
