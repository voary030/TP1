<template>
  <div class="container">
    <h2 class="page-title">Liste des Étudiants</h2>
    
    <LoadingSpinner v-if="loading" />

    <div v-else class="card">
      <table class="table">
        <thead>
          <tr>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th class="text-center clickable-header">Moyenne S1</th>
            <th class="text-center clickable-header">Moyenne S2</th>
            <th class="text-center clickable-header">Moyenne S3</th>
            <th class="text-center clickable-header">Moyenne S4</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="student in students" :key="student.id">
            <td>
              <a @click.prevent="goToStudent(student.id)" class="student-link">
                {{ student.lastName }}
              </a>
            </td>
            <td>{{ student.firstName }}</td>
            <td class="text-muted">{{ student.email }}</td>
            <td 
              class="text-center clickable-grade"
              @click="goToSemesterGrades(student.id, 1)"
            >
              {{ formatGrade(student.s1Average) }}
            </td>
            <td 
              class="text-center clickable-grade"
              @click="goToSemesterGrades(student.id, 2)"
            >
              {{ formatGrade(student.s2Average) }}
            </td>
            <td 
              class="text-center clickable-grade"
              @click="goToSemesterGrades(student.id, 3)"
            >
              {{ formatGrade(student.s3Average) }}
            </td>
            <td 
              class="text-center clickable-grade"
              @click="goToSemesterGrades(student.id, 4)"
            >
              {{ formatGrade(student.s4Average) }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import api from '../services/api'
import LoadingSpinner from '../Components/shared/LoadingSpinner.vue'
import { useGradeFormat } from '../composables/useGradeFormat'

const router = useRouter()
const students = ref([])
const loading = ref(true)
const { formatGrade } = useGradeFormat()

const goToStudent = (studentId) => {
  router.push(`/students/${studentId}`)
}

const goToSemesterGrades = (studentId, semesterId) => {
  // Pour S4, rediriger vers la sélection du parcours
  if (semesterId === 4) {
    router.push(`/students/${studentId}/semester/4/select-parcours`)
  } else {
    router.push(`/students/${studentId}/semester/${semesterId}`)
  }
}

onMounted(async () => {
  try {
    const response = await api.getAllStudents()
    if (response.data.status === 'success') {
      students.value = response.data.data
    }
  } catch (error) {
    console.error('Erreur lors du chargement des étudiants:', error)
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
}

.text-center {
  text-align: center;
}

.text-muted {
  color: #6c757d;
  font-size: 14px;
}

.student-link {
  color: #007bff;
  font-weight: 600;
  cursor: pointer;
}

.student-link:hover {
  text-decoration: underline;
}

.clickable-header {
  background-color: #e9ecef;
  font-weight: 600;
}

.clickable-grade {
  cursor: pointer;
  font-weight: 500;
  color: #007bff;
  transition: all 0.2s;
}

.clickable-grade:hover {
  background-color: #e7f3ff;
  font-weight: 600;
}
</style>
