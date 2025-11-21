// Service mock pour développement frontend sans backend
// Simule les réponses de l'API

import {
  mockUsers,
  mockStudents,
  mockSemesters,
  mockParcours,
  mockStudentAverages,
  mockStudentDetails,
  mockSemesterGrades,
  mockYearGrades
} from './mockData'

// Délai simulé pour une vraie requête API
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms))

export default {
  // Authentication
  async login(credentials) {
    await delay(500) // Simule une requête API
    
    const user = mockUsers.find(u => u.email === credentials.email && u.mot_de_passe === credentials.password)
    
    if (user) {
      // Générer un faux token JWT (format réaliste)
      const header = btoa(JSON.stringify({ alg: 'HS256', typ: 'JWT' }))
      const payload = btoa(JSON.stringify({
        sub: user.id_user,
        email: user.email,
        username: user.username,
        role: user.role,
        iat: Math.floor(Date.now() / 1000),
        exp: Math.floor(Date.now() / 1000) + (24 * 60 * 60) // 24h
      }))
      const signature = 'mock_signature_' + Date.now()
      const token = `${header}.${payload}.${signature}`
      
      return {
        data: {
          status: 'success',
          data: {
            token,
            student: {
              id: user.id_user,
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
              username: user.username,
              role: user.role
            }
          }
        }
      }
    } else {
      const error = new Error('Credentials invalides')
      error.response = { status: 401, data: { status: 'error', error: { message: 'Email ou mot de passe incorrect' } } }
      throw error
    }
  },

  // Semesters
  async getSemesters() {
    await delay(300)
    return {
      data: {
        status: 'success',
        data: mockSemesters
      }
    }
  },

  async getParcoursBySemester(semesterId) {
    await delay(300)
    const parcours = mockParcours[semesterId] || []
    return {
      data: {
        status: 'success',
        data: parcours
      }
    }
  },

  // Students
  async getAllStudents() {
    await delay(400)
    return {
      data: {
        status: 'success',
        data: mockStudentAverages
      }
    }
  },

  async getStudentById(studentId) {
    await delay(300)
    const student = mockStudentDetails[studentId]
    
    if (student) {
      return {
        data: {
          status: 'success',
          data: student
        }
      }
    } else {
      const error = new Error('Student not found')
      error.response = { status: 404 }
      throw error
    }
  },

  // Grades
  async getSemesterGrades(studentId, semesterId) {
    await delay(400)
    const key = `${studentId}-${semesterId}`
    const grades = mockSemesterGrades[key]
    
    if (grades) {
      return {
        data: {
          status: 'success',
          data: grades
        }
      }
    } else {
      const error = new Error('Grades not found')
      error.response = { status: 404 }
      throw error
    }
  },

  async getYearGrades(studentId, yearLevel) {
    await delay(400)
    const key = `${studentId}-${yearLevel}`
    const grades = mockYearGrades[key]
    
    if (grades) {
      return {
        data: {
          status: 'success',
          data: grades
        }
      }
    } else {
      const error = new Error('Year grades not found')
      error.response = { status: 404 }
      throw error
    }
  }
}
