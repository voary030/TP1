<template>
  <div class="container">
    <h2 class="page-title">Liste des Semestres</h2>
    
    <div v-if="loading" class="loading">
      Chargement...
    </div>

    <div v-else class="semesters-grid">
      <div
        v-for="semester in semesters"
        :key="semester.id"
        class="semester-card card clickable"
        @click="goToStudents(semester.id)"
      >
        <h3 class="semester-name">{{ semester.name }}</h3>
        <p class="semester-description">
          {{ getSemesterDescription(semester.name) }}
        </p>
        <div class="semester-arrow">→</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import api from '../services/api'

const router = useRouter()
const semesters = ref([])
const loading = ref(true)

const getSemesterDescription = (name) => {
  const descriptions = {
    'S1': 'Semestre 1 - Tronc commun',
    'S2': 'Semestre 2 - Tronc commun',
    'S3': 'Semestre 3 - Tronc commun',
    'S4': 'Semestre 4 - Parcours spécialisés'
  }
  return descriptions[name] || 'Cliquez pour voir les étudiants'
}

const goToStudents = (semesterId) => {
  router.push('/students')
}

onMounted(async () => {
  try {
    const response = await api.getSemesters()
    if (response.data.status === 'success') {
      semesters.value = response.data.data
    }
  } catch (error) {
    console.error('Erreur lors du chargement des semestres:', error)
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
  margin-bottom: 30px;
  text-align: center;
}

.semesters-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  max-width: 1000px;
  margin: 0 auto;
}

.semester-card {
  position: relative;
  padding: 30px;
  text-align: center;
  transition: all 0.3s;
  border: 2px solid transparent;
}

.semester-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  border-color: #007bff;
}

.semester-name {
  font-size: 28px;
  font-weight: 700;
  color: #007bff;
  margin-bottom: 10px;
}

.semester-description {
  color: #6c757d;
  font-size: 14px;
  margin-bottom: 15px;
}

.semester-arrow {
  font-size: 24px;
  color: #007bff;
  font-weight: bold;
}
</style>
