<template>
  <div class="summary-section">
    <div class="summary-row">
      <span class="summary-label">Résultat :</span>
      <span class="summary-value">Crédits: {{ totalCredits }}</span>
    </div>
    <div class="summary-row">
      <span class="summary-label"></span>
      <span class="summary-value">Moyenne générale: {{ formatGrade(average) }}</span>
    </div>
    <div class="summary-row">
      <span class="summary-label"></span>
      <span class="summary-value">Mention: {{ getMention(average) }}</span>
    </div>
    <div class="summary-row">
      <span class="summary-label"></span>
      <span class="summary-value" :class="{ 'font-bold': bold }">
        {{ passed ? 'ADMIS(E)' : 'AJOURNÉ(E)' }}
      </span>
    </div>
    <div class="summary-row">
      <span class="summary-label"></span>
      <span class="summary-value">Session: {{ session }}</span>
    </div>
  </div>
</template>

<script setup>
defineProps({
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
  },
  bold: {
    type: Boolean,
    default: false
  }
})

const formatGrade = (grade) => {
  return grade ? grade.toFixed(2) : '-'
}

const getMention = (average) => {
  if (!average) return '-'
  if (average >= 16) return 'Très Bien'
  if (average >= 14) return 'Bien'
  if (average >= 12) return 'Assez Bien'
  if (average >= 10) return 'Passable'
  return 'Ajourné'
}
</script>

<style scoped>
.summary-section {
  margin-top: 30px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.summary-row {
  display: flex;
  padding: 8px 0;
}

.summary-label {
  font-weight: 600;
  color: #555;
  min-width: 120px;
}

.summary-value {
  color: #333;
  flex: 1;
}

.font-bold {
  font-weight: 700;
  font-size: 16px;
  color: #007bff;
}
</style>
