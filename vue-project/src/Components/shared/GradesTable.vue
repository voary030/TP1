<template>
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
      <tr v-for="(grade, index) in grades" :key="index">
        <td class="code-cell">{{ grade.subject.code }}</td>
        <td class="subject-name">{{ grade.subject.name }}</td>
        <td class="text-center">{{ grade.subject.credits }}</td>
        <td class="text-center grade-value">{{ formatGrade(grade.grade) }}</td>
        <td class="text-center">{{ getResult(grade.grade) }}</td>
        <td class="text-center">{{ session }}</td>
      </tr>
      <!-- Ligne de sous-total -->
      <tr class="semester-total-row">
        <td colspan="2" class="semester-label">
          {{ semesterName }}
          <span v-if="trackName"> - option {{ trackName.toLowerCase() }}</span>
        </td>
        <td class="text-center total-credits">{{ totalCredits }}</td>
        <td class="text-center total-average">{{ formatGrade(average) }}</td>
        <td class="text-center total-result">{{ passed ? 'P' : 'AR' }}</td>
        <td class="text-center">{{ passed ? 'Passable' : '' }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script setup>
defineProps({
  grades: {
    type: Array,
    required: true
  },
  semesterName: {
    type: String,
    required: true
  },
  trackName: {
    type: String,
    default: null
  },
  totalCredits: {
    type: Number,
    required: true
  },
  average: {
    type: Number,
    required: true
  },
  passed: {
    type: Boolean,
    required: true
  },
  session: {
    type: String,
    required: true
  }
})

const formatGrade = (grade) => {
  return grade ? grade.toFixed(2) : '-'
}

const getResult = (grade) => {
  if (!grade) return 'AR'
  if (grade >= 16) return 'TB'
  if (grade >= 14) return 'B'
  if (grade >= 12) return 'AB'
  if (grade >= 10) return 'P'
  return 'AR'
}
</script>

<style scoped>
.grades-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
  background: white;
}

.grades-table thead {
  background: #f8f9fa;
}

.grades-table th {
  padding: 12px 8px;
  text-align: left;
  font-weight: 600;
  color: #333;
  border-bottom: 2px solid #dee2e6;
  font-size: 13px;
}

.grades-table td {
  padding: 10px 8px;
  border-bottom: 1px solid #e9ecef;
  font-size: 14px;
}

.code-cell {
  font-weight: 600;
  color: #007bff;
  width: 100px;
}

.subject-name {
  color: #333;
}

.grade-value {
  font-weight: 600;
  color: #28a745;
}

.semester-total-row {
  background: #e8f4f8;
  font-weight: 700;
}

.semester-label {
  color: #0056b3;
}

.total-credits,
.total-average,
.total-result {
  font-weight: 700;
  color: #333;
}

.text-center {
  text-align: center;
}
</style>
