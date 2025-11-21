<template>
  <div>
    <h2>Mes Vidéos</h2>
    <ul>
      <li 
        v-for="video in videos" 
        :key="video.id"
        :class="{ maxDuration: isMaxDuration(video.duration) }"
      >
        {{ video.title }} - {{ video.duration }} minutes
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const videos = ref([
  { id: 1, title: "Vue Basics", duration: 15 },
  { id: 2, title: "Advanced Vue", duration: 45 },
  { id: 3, title: "Composition API", duration: 30 }
]);

// Computed : trouve la durée maximum
const maxDuration = computed(() => {
  return Math.max(...videos.value.map(v => v.duration));
});

// Method : vérifie si c'est la durée maximum
function isMaxDuration(duration) {
  return duration === maxDuration.value;
}
</script>

<style>
li {
  padding: 10px;
  margin: 5px 0;
  border: 1px solid #ccc;
  border-radius: 5px;
}

/* Cette classe s'ajoute dynamiquement */
.maxDuration {
  background-color: #ffcccc;
  color: #cc0000;
  font-weight: bold;
  border-color: #cc0000;
}
</style>
