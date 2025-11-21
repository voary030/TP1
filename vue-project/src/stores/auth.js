import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import api from '../services/api'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('authToken') || null)
  const user = ref(JSON.parse(localStorage.getItem('user') || 'null'))

  const isAuthenticated = computed(() => !!token.value)

  async function login(credentials) {
    try {
      const response = await api.login(credentials)
      
      if (response.data.status === 'success') {
        token.value = response.data.data.token
        user.value = response.data.data.student
        
        localStorage.setItem('authToken', token.value)
        localStorage.setItem('user', JSON.stringify(user.value))
        
        return { success: true }
      } else {
        return { success: false, error: response.data.error }
      }
    } catch (error) {
      const errorMessage = error.response?.data?.error?.message || 'Erreur de connexion'
      return { success: false, error: errorMessage }
    }
  }

  function logout() {
    token.value = null
    user.value = null
    localStorage.removeItem('authToken')
    localStorage.removeItem('user')
  }

  return {
    token,
    user,
    isAuthenticated,
    login,
    logout
  }
})
