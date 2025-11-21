<template>
  <div id="app">
    <div v-if="isAuthenticated" class="header">
      <div class="header-content">
        <h1 class="header-title">Gestion des Notes - IT University</h1>
        <div>
          <span v-if="user">{{ user.firstName }} {{ user.lastName }}</span>
          <button @click="handleLogout" class="btn btn-secondary" style="margin-left: 15px">
            Déconnexion
          </button>
        </div>
      </div>
    </div>
    
    <router-view />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from './stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const isAuthenticated = computed(() => authStore.isAuthenticated)
const user = computed(() => authStore.user)

const handleLogout = () => {
  authStore.logout()
  router.push('/login')
}
</script>

<style>
#app {
  min-height: 100vh;
}
</style>
