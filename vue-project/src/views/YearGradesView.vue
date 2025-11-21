<template>
  <div class="container">
    <BackButton />

    <LoadingSpinner v-if="loading" />

    <div v-else-if="gradesData" class="transcript-container">
      <!-- En-tête du relevé -->
      <TranscriptHeader />

      <!-- Informations étudiant -->
      <StudentInfoSection 
        :student="gradesData.student"
        :level="yearLevel"
        show-birth-date
      />

      <!-- Tableau des notes -->
      <div class="grades-section">
        <p class="section-intro">a obtenu les notes suivantes:</p>

        <!-- Boucle sur chaque semestre -->
        <GradesTable
          v-for="semester in gradesData.semesters"
          :key="semester.semesterId"
          :grades="semester.grades"
          :semester-name="semester.semesterName"
          :track-name="semester.track"
          :total-credits="semester.totalCredits"
          :average="semester.average"
          :passed="semester.passed"
          :session="formatSession(semester.semesterName)"
        />
      </div>

      <!-- Résumé global -->
      <TranscriptSummary
        :total-credits="gradesData.summary.totalCredits"
        :average="gradesData.summary.average"
        :passed="gradesData.summary.passed"
        :session="formatSession('')"
        bold
      />

      <!-- Pied de page -->
      <TranscriptFooter />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import api from '../services/api'
import BackButton from '../Components/shared/BackButton.vue'
import LoadingSpinner from '../Components/shared/LoadingSpinner.vue'
import TranscriptHeader from '../Components/shared/TranscriptHeader.vue'
import StudentInfoSection from '../Components/shared/StudentInfoSection.vue'
import GradesTable from '../Components/shared/GradesTable.vue'
import TranscriptSummary from '../Components/shared/TranscriptSummary.vue'
import TranscriptFooter from '../Components/shared/TranscriptFooter.vue'
import { useDateFormat } from '../composables/useDateFormat'

const router = useRouter()
const route = useRoute()

const gradesData = ref(null)
const loading = ref(true)

const yearLevel = computed(() => route.params.yearLevel)
const { formatSession } = useDateFormat()

onMounted(async () => {
  try {
    const studentId = route.params.studentId
    const year = route.params.yearLevel
    
    const response = await api.getYearGrades(studentId, year)
    if (response.data.status === 'success') {
      gradesData.value = response.data.data
    }
  } catch (error) {
    console.error('Erreur lors du chargement des notes:', error)
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.mb-20 {
  margin-bottom: 20px;
}

.transcript-container {
  background: white;
  padding: 40px;
  max-width: 900px;
  margin: 0 auto;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border: 1px solid #ddd;
}

.transcript-header {
  text-align: center;
  margin-bottom: 30px;
  border-bottom: 2px solid #333;
  padding-bottom: 15px;
}

.university-name {
  font-size: 24px;
  font-weight: 700;
  color: #333;
  margin-bottom: 5px;
}

.document-title {
  font-size: 18px;
  font-weight: 600;
  color: #666;
}

.student-info-section {
  margin-bottom: 25px;
  line-height: 1.8;
}

.info-row {
  display: flex;
  margin-bottom: 5px;
}

.info-label {
  min-width: 150px;
  font-weight: 500;
  color: #555;
}

.info-value {
  font-weight: 600;
  color: #333;
}

.grades-section {
  margin-bottom: 30px;
}

.section-intro {
  margin-bottom: 15px;
  font-style: italic;
  color: #555;
}

.grades-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

.grades-table th {
  background-color: #f5f5f5;
  padding: 10px 8px;
  text-align: left;
  border: 1px solid #ddd;
  font-weight: 600;
  font-size: 14px;
}

.grades-table td {
  padding: 8px;
  border: 1px solid #ddd;
  font-size: 13px;
}

.code-cell {
  font-weight: 600;
  color: #007bff;
}

.subject-name {
  max-width: 300px;
}

.text-center {
  text-align: center;
}

.grade-value {
  font-weight: 600;
  color: #007bff;
}

.semester-total-row {
  background-color: #f8f9fa;
  font-weight: 600;
}

.semester-label {
  padding-left: 15px;
  font-size: 14px;
  text-transform: uppercase;
}

.total-credits,
.total-average,
.total-result {
  font-size: 15px;
  font-weight: 700;
  color: #007bff;
}

.summary-section {
  margin-bottom: 30px;
  padding: 15px;
  background-color: #f8f9fa;
  border-left: 4px solid #007bff;
}

.summary-row {
  display: flex;
  margin-bottom: 8px;
}

.summary-label {
  min-width: 120px;
  font-weight: 600;
  color: #555;
}

.summary-value {
  font-weight: 500;
  color: #333;
}

.font-bold {
  font-weight: 700 !important;
}

.transcript-footer {
  text-align: right;
  margin-top: 40px;
  font-style: italic;
  color: #666;
}

.transcript-footer p {
  margin: 5px 0;
}

@media print {
  .btn {
    display: none;
  }
  
  .transcript-container {
    box-shadow: none;
    border: none;
  }
}
</style>
