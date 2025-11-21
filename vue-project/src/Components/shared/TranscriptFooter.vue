<template>
  <div class="transcript-footer">
    <p>Fait à {{ location }}, le {{ formatDate(new Date()) }}</p>
    <p>{{ signature }}</p>
  </div>
</template>

<script setup>
defineProps({
  location: {
    type: String,
    default: 'Antananarivo'
  },
  signature: {
    type: String,
    default: 'Le Recteur de l\'IT University'
  }
})

const formatDate = (date) => {
  return date.toLocaleDateString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  })
}
</script>

<style scoped>
.transcript-footer {
  margin-top: 40px;
  padding-top: 30px;
  border-top: 1px solid #ddd;
  text-align: right;
}

.transcript-footer p {
  margin: 8px 0;
  color: #555;
  font-size: 14px;
}

.transcript-footer p:last-child {
  font-weight: 600;
  margin-top: 40px;
}
</style>
