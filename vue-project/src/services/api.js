import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000'

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
    return apiClient.post('/api/auth/login', credentials)
  },

  // Semesters
  getSemesters() {
    return apiClient.get('/api/semesters')
  },

  getParcoursBySemester(semesterId) {
    return apiClient.get(`/api/semesters/${semesterId}/parcours`)
  },

  // Students
  getAllStudents() {
    return apiClient.get('/api/students')
  },

  getStudentById(studentId) {
    return apiClient.get(`/api/students/${studentId}`)
  },

  // Grades
  getSemesterGrades(studentId, semesterId) {
    return apiClient.get(`/api/students/${studentId}/semesters/${semesterId}/grades`)
  },

  getYearGrades(studentId, yearLevel) {
    return apiClient.get(`/api/students/${studentId}/years/${yearLevel}/grades`)
  }
}
