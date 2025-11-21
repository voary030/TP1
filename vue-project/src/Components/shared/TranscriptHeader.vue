<template>
  <div class="transcript-header">
    <h1 class="university-name">IT UNIVERSITY</h1>
    <h2 class="document-title">{{ title }}</h2>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    default: 'RELEVÉ DE NOTES PARTIEL'
  }
})
</script>

<style scoped>
.transcript-header {
  text-align: center;
  border-bottom: 2px solid #333;
  padding-bottom: 20px;
  margin-bottom: 30px;
}

.university-name {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin: 0;
  letter-spacing: 2px;
}

.document-title {
  font-size: 18px;
  font-weight: 600;
  color: #555;
  margin: 10px 0 0 0;
  letter-spacing: 1px;
}
</style>
