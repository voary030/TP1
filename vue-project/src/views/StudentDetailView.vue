<template>
  <div class="container">
    <BackButton text="Retour à la liste" />

    <LoadingSpinner v-if="loading" />

    <div v-else-if="student" class="student-detail-container">
      <!-- Informations étudiant -->
      <div class="card student-info-card">
        <h2 class="student-name">{{ student.firstName }} {{ student.lastName }}</h2>
        <div class="student-details">
          <div class="detail-item">
            <span class="detail-label">Email:</span>
            <span class="detail-value">{{ student.email }}</span>
          </div>
          <div class="detail-item">
            <span class="detail-label">Date de naissance:</span>
            <span class="detail-value">{{ formatDate(student.birthDate) }}</span>
          </div>
          <div class="detail-item">
            <span class="detail-label">Numéro:</span>
            <span class="detail-value">{{ String(student.id).padStart(6, '0') }}</span>
          </div>
        </div>
      </div>

      <!-- Tableau des moyennes par semestre -->
      <div class="card averages-card">
        <h3 class="section-title">Moyennes par Semestre</h3>
        <table class="table averages-table">
          <thead>
            <tr>
              <th>Semestre</th>
              <th class="text-center">Moyenne</th>
              <th class="text-center">Résultat</th>
              <th class="text-center">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(average, semester) in student.semesterAverages" :key="semester">
              <td class="semester-name">{{ semester }}</td>
              <td class="text-center average-value">
                {{ formatGrade(average) }}
              </td>
              <td class="text-center">
                <span :class="getResultClass(average)">
                  {{ getResult(average) }}
                </span>
              </td>
              <td class="text-center">
                <button 
                  v-if="average"
                  @click="viewSemesterGrades(getSemesterId(semester))"
                  class="btn btn-primary btn-sm"
                >
                  Voir le relevé
                </button>
                <span v-else class="text-muted">-</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Liens vers les relevés annuels -->
      <div class="card annual-grades-card">
        <h3 class="section-title">Relevés de Notes Annuels</h3>
        <div class="annual-links">
          <button 
            @click="viewYearGrades(1)"
            class="btn btn-primary btn-large"
          >
            📄 Relevé L1 (S1 + S2)
          </button>
          <button 
            @click="viewYearGrades(2)"
            class="btn btn-primary btn-large"
          >
            📄 Relevé L2 (S3 + S4)
          </button>
        </div>
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
import { useGradeFormat } from '../composables/useGradeFormat'
import { useDateFormat } from '../composables/useDateFormat'

const router = useRouter()
const route = useRoute()

const student = ref(null)
const loading = ref(true)
const { formatGrade, getResult, getResultClass } = useGradeFormat()
const { formatDate } = useDateFormat()

const getSemesterId = (semesterName) => {
  return parseInt(semesterName.replace('S', ''))
}

const viewSemesterGrades = (semesterId) => {
  router.push(`/students/${student.value.id}/semester/${semesterId}`)
}

const viewYearGrades = (yearLevel) => {
  router.push(`/students/${student.value.id}/year/${yearLevel}`)
}

onMounted(async () => {
  try {
    const studentId = route.params.id
    const response = await api.getStudentById(studentId)
    
    if (response.data.status === 'success') {
      student.value = response.data.data
    }
  } catch (error) {
    console.error('Erreur lors du chargement de l\'étudiant:', error)
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.mb-20 {
  margin-bottom: 20px;
}

.student-detail-container {
  max-width: 900px;
  margin: 0 auto;
}

.student-info-card {
  text-align: center;
  padding: 30px;
  margin-bottom: 25px;
}

.student-name {
  font-size: 32px;
  font-weight: 700;
  color: #333;
  margin-bottom: 20px;
}

.student-details {
  display: flex;
  justify-content: center;
  gap: 40px;
  flex-wrap: wrap;
}

.detail-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.detail-label {
  font-size: 13px;
  color: #6c757d;
  margin-bottom: 5px;
}

.detail-value {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.averages-card {
  margin-bottom: 25px;
}

.section-title {
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #007bff;
}

.averages-table {
  margin: 0;
}

.semester-name {
  font-weight: 600;
  color: #007bff;
  font-size: 16px;
}

.text-center {
  text-align: center;
}

.average-value {
  font-size: 18px;
  font-weight: 700;
  color: #333;
}

.result-passed {
  color: #28a745;
  font-weight: 600;
  padding: 4px 12px;
  background-color: #d4edda;
  border-radius: 4px;
}

.result-failed {
  color: #dc3545;
  font-weight: 600;
  padding: 4px 12px;
  background-color: #f8d7da;
  border-radius: 4px;
}

.btn-sm {
  padding: 6px 12px;
  font-size: 13px;
}

.text-muted {
  color: #6c757d;
}

.annual-grades-card {
  padding: 30px;
}

.annual-links {
  display: flex;
  gap: 20px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn-large {
  padding: 15px 30px;
  font-size: 16px;
  font-weight: 600;
  min-width: 220px;
}
</style>
