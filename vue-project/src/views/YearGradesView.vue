<template>
  <div class="container">
    <button @click="goBack" class="btn btn-secondary mb-20">
      ← Retour
    </button>

    <div v-if="loading" class="loading">
      Chargement...
    </div>

    <div v-else-if="gradesData" class="transcript-container">
      <!-- En-tête du relevé -->
      <div class="transcript-header">
        <h1 class="university-name">IT UNIVERSITY</h1>
        <h2 class="document-title">RELEVÉ DE NOTES PARTIEL</h2>
      </div>

      <!-- Informations étudiant -->
      <div class="student-info-section">
        <div class="info-row">
          <span class="info-label">Nom:</span>
          <span class="info-value">{{ gradesData.student.lastName?.toUpperCase() }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Prénom(s):</span>
          <span class="info-value">{{ gradesData.student.firstName }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Né(e) le :</span>
          <span class="info-value">{{ formatBirthDate(gradesData.student.birthDate) }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">N° d'inscription:</span>
          <span class="info-value">{{ String(gradesData.student.id).padStart(6, '0') }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Inscrit(e) en</span>
          <span class="info-value">L{{ yearLevel }} - INFORMATIQUE</span>
        </div>
      </div>

      <!-- Tableau des notes -->
      <div class="grades-section">
        <p class="section-intro">a obtenu les notes suivantes:</p>

        <!-- Boucle sur chaque semestre -->
        <div v-for="semester in gradesData.semesters" :key="semester.semesterId">
          <table class="grades-table">
            <thead>
              <tr>
                <th>UE</th>
                <th>Intitulé</th>
                <th>Crédits</th>
                <th>Note/20</th>
                <th>Résultat</th>
                <th>Session</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(grade, index) in semester.grades" :key="index">
                <td class="code-cell">{{ grade.subject.code }}</td>
                <td class="subject-name">{{ grade.subject.name }}</td>
                <td class="text-center">{{ grade.subject.credits }}</td>
                <td class="text-center grade-value">{{ formatGrade(grade.grade) }}</td>
                <td class="text-center">{{ getResult(grade.grade) }}</td>
                <td class="text-center">{{ formatSession(semester.semesterName) }}</td>
              </tr>
              <!-- Ligne de sous-total du semestre -->
              <tr class="semester-total-row">
                <td colspan="2" class="semester-label">
                  {{ semester.semesterName }}
                  <span v-if="semester.track"> - option {{ semester.track.toLowerCase() }}</span>
                </td>
                <td class="text-center total-credits">{{ semester.totalCredits }}</td>
                <td class="text-center total-average">{{ formatGrade(semester.average) }}</td>
                <td class="text-center total-result">{{ semester.passed ? 'P' : 'AR' }}</td>
                <td class="text-center">{{ semester.passed ? 'Passable' : '' }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Résumé global -->
      <div class="summary-section">
        <div class="summary-row">
          <span class="summary-label">Résultat :</span>
          <span class="summary-value">Crédits: {{ gradesData.summary.totalCredits }}</span>
        </div>
        <div class="summary-row">
          <span class="summary-label"></span>
          <span class="summary-value">Moyenne générale: {{ formatGrade(gradesData.summary.average) }}</span>
        </div>
        <div class="summary-row">
          <span class="summary-label"></span>
          <span class="summary-value">Mention: {{ getMention(gradesData.summary.average) }}</span>
        </div>
        <div class="summary-row">
          <span class="summary-label"></span>
          <span class="summary-value font-bold">{{ gradesData.summary.passed ? 'ADMIS(E)' : 'AJOURNÉ(E)' }}</span>
        </div>
        <div class="summary-row">
          <span class="summary-label"></span>
          <span class="summary-value">Session: {{ formatSession('') }}</span>
        </div>
      </div>

      <!-- Pied de page -->
      <div class="transcript-footer">
        <p>Fait à Antananarivo, le {{ formatDate(new Date()) }}</p>
        <p>Le Recteur de l'IT University</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import api from '../services/api'

const router = useRouter()
const route = useRoute()

const gradesData = ref(null)
const loading = ref(true)

const yearLevel = computed(() => route.params.yearLevel)

const formatGrade = (grade) => {
  return grade ? grade.toFixed(2) : '-'
}

const formatBirthDate = (dateString) => {
  if (!dateString) return '-'
  const date = new Date(dateString)
  const day = date.getDate()
  const month = date.getMonth() + 1
  const year = date.getFullYear()
  return `${day.toString().padStart(2, '0')}/${month.toString().padStart(2, '0')}/${year} à -`
}

const getResult = (grade) => {
  if (!grade) return 'AR'
  if (grade >= 16) return 'TB'
  if (grade >= 14) return 'B'
  if (grade >= 12) return 'AB'
  if (grade >= 10) return 'P'
  return 'AR'
}

const getMention = (average) => {
  if (!average) return '-'
  if (average >= 16) return 'Très Bien'
  if (average >= 14) return 'Bien'
  if (average >= 12) return 'Assez Bien'
  if (average >= 10) return 'Passable'
  return 'Ajourné'
}

const formatSession = (semesterName) => {
  const currentYear = new Date().getFullYear()
  const month = new Date().getMonth() + 1
  return `${month.toString().padStart(2, '0')}/${currentYear}`
}

const formatDate = (date) => {
  const day = date.getDate()
  const month = date.getMonth() + 1
  const year = date.getFullYear()
  return `${day}/${month}/${year}`
}

const goBack = () => {
  router.go(-1)
}

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
