<template>
  <div class="container">
    <BackButton />
    
    <h2 class="page-title">Sélection du Parcours - S4</h2>
    <p class="subtitle">Veuillez choisir un parcours pour voir les notes</p>
    
    <LoadingSpinner v-if="loading" />

    <div v-else class="parcours-grid">
      <div
        v-for="parcours in parcoursList"
        :key="parcours.id"
        class="parcours-card card clickable"
        @click="goToGrades(parcours.id)"
      >
        <div class="parcours-icon">📚</div>
        <h3 class="parcours-name">{{ parcours.name }}</h3>
        <p class="parcours-info">Cliquez pour voir les notes</p>
        <div class="parcours-arrow">→</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import api from '../services/api'
import BackButton from '../Components/shared/BackButton.vue'
import LoadingSpinner from '../Components/shared/LoadingSpinner.vue'

const router = useRouter()
const route = useRoute()
const parcoursList = ref([])
const loading = ref(true)

const goToGrades = (parcoursId) => {
  const studentId = route.params.studentId
  router.push(`/students/${studentId}/semester/4/parcours/${parcoursId}`)
}

onMounted(async () => {
  try {
    // Récupérer les parcours pour S4 (semesterId = 4)
    const response = await api.getParcoursBySemester(4)
    if (response.data.status === 'success') {
      parcoursList.value = response.data.data
    }
  } catch (error) {
    console.error('Erreur lors du chargement des parcours:', error)
    // En cas d'erreur, afficher les parcours en dur
    parcoursList.value = [
      { id: 1, name: 'Développement' },
      { id: 2, name: 'Web et Design' },
      { id: 3, name: 'Bases de Données et Réseaux' }
    ]
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.page-title {
  font-size: 32px;
  font-weight: 700;
  color: #333;
  margin-bottom: 10px;
  text-align: center;
}

.subtitle {
  text-align: center;
  color: #666;
  font-size: 16px;
  margin-bottom: 40px;
}

.parcours-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 25px;
  max-width: 1000px;
  margin: 0 auto;
}

.parcours-card {
  position: relative;
  padding: 40px 30px;
  text-align: center;
  transition: all 0.3s;
  border: 2px solid transparent;
  background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
}

.parcours-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 24px rgba(0, 123, 255, 0.15);
  border-color: #007bff;
}

.parcours-icon {
  font-size: 48px;
  margin-bottom: 15px;
}

.parcours-name {
  font-size: 22px;
  font-weight: 700;
  color: #007bff;
  margin-bottom: 10px;
  min-height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.parcours-info {
  color: #666;
  font-size: 14px;
  margin-bottom: 15px;
}

.parcours-arrow {
  position: absolute;
  bottom: 15px;
  right: 20px;
  font-size: 24px;
  color: #007bff;
  transition: transform 0.3s;
}

.parcours-card:hover .parcours-arrow {
  transform: translateX(5px);
}
</style>
