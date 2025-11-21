<template>
  <div class="student-info-section">
    <div v-for="(item, index) in infoItems" :key="index" class="info-row">
      <span class="info-label">{{ item.label }}:</span>
      <span class="info-value">{{ item.value }}</span>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  student: {
    type: Object,
    required: true
  },
  level: {
    type: [String, Number],
    default: null
  },
  track: {
    type: Object,
    default: null
  },
  showBirthDate: {
    type: Boolean,
    default: false
  }
})

const infoItems = computed(() => {
  const items = [
    { label: 'Nom', value: props.student.lastName?.toUpperCase() || '-' },
    { label: 'Prénom(s)', value: props.student.firstName || '-' }
  ]

  if (props.showBirthDate && props.student.birthDate) {
    items.push({ 
      label: 'Né(e) le', 
      value: formatBirthDate(props.student.birthDate) 
    })
  }

  items.push({
    label: 'N° d\'inscription',
    value: String(props.student.id).padStart(6, '0')
  })

  if (props.level) {
    items.push({
      label: 'Inscrit(e) en',
      value: `L${props.level} - INFORMATIQUE`
    })
  }

  if (props.track) {
    items.push({
      label: 'Parcours',
      value: props.track.name
    })
  }

  return items
})

const formatBirthDate = (dateString) => {
  const date = new Date(dateString)
  const day = date.getDate()
  const month = date.getMonth() + 1
  const year = date.getFullYear()
  return `${day.toString().padStart(2, '0')}/${month.toString().padStart(2, '0')}/${year} à -`
}
</script>

<style scoped>
.student-info-section {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 30px;
}

.info-row {
  display: flex;
  padding: 8px 0;
  border-bottom: 1px solid #e0e0e0;
}

.info-row:last-child {
  border-bottom: none;
}

.info-label {
  font-weight: 600;
  color: #555;
  min-width: 180px;
}

.info-value {
  color: #333;
  flex: 1;
}
</style>
