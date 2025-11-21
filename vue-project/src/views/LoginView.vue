<template>
  <div class="login-container">
    <div class="login-card">
      <h2 class="login-title">Connexion</h2>
      <p class="login-subtitle">Gestion des Notes - IT University</p>

      <div v-if="error" class="alert alert-error">
        {{ error }}
      </div>

      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="email" class="form-label">Email</label>
          <input
            type="email"
            id="email"
            v-model="credentials.email"
            class="form-control"
            placeholder="votre.email@univ.mg"
            required
          />
        </div>

        <div class="form-group">
          <label for="password" class="form-label">Mot de passe</label>
          <input
            type="password"
            id="password"
            v-model="credentials.password"
            class="form-control"
            placeholder="••••••••"
            required
          />
        </div>

        <button type="submit" class="btn btn-primary btn-block" :disabled="loading">
          {{ loading ? 'Connexion...' : 'Se connecter' }}
        </button>
      </form>

      <div class="login-info">
        <p><strong>Comptes de test :</strong></p>
        <p>admin@univ.mg / AdminPass123!</p>
        <p>secretaire@univ.mg / SecPass123!</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const credentials = ref({
  email: '',
  password: ''
})

const error = ref('')
const loading = ref(false)

const handleLogin = async () => {
  error.value = ''
  loading.value = true

  try {
    const result = await authStore.login(credentials.value)
    
    if (result.success) {
      router.push('/semesters')
    } else {
      error.value = result.error || 'Email ou mot de passe incorrect'
    }
  } catch (err) {
    error.value = 'Erreur de connexion. Veuillez réessayer.'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
  padding: 40px;
  width: 100%;
  max-width: 450px;
}

.login-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 8px;
  text-align: center;
}

.login-subtitle {
  color: #6c757d;
  text-align: center;
  margin-bottom: 30px;
  font-size: 14px;
}

.btn-block {
  width: 100%;
  padding: 12px;
  font-size: 16px;
  font-weight: 600;
  margin-top: 10px;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.login-info {
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #dee2e6;
  font-size: 13px;
  color: #6c757d;
  text-align: center;
}

.login-info p {
  margin: 5px 0;
}
</style>
