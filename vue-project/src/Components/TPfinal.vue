<template>
  <div class="app">
    <h1>Gestionnaire de Tâches</h1>
    
    <!-- Ajouter une tâche -->
    <div class="add-task">
      <input 
        v-model="newTask" 
        placeholder="Nouvelle tâche..."
        @keyup.enter="addTask"
      />
      <button @click="addTask">Ajouter</button>
    </div>
    
    <!-- Filtres -->
    <div class="filters">
      <button 
        :class="{ active: filter === 'all' }"
        @click="filter = 'all'"
      >
        Toutes ({{ totalTasks }})
      </button>
      <button 
        :class="{ active: filter === 'active' }"
        @click="filter = 'active'"
      >
        En cours ({{ activeTasks }})
      </button>
      <button 
        :class="{ active: filter === 'completed' }"
        @click="filter = 'completed'"
      >
        Complétées ({{ completedTasks }})
      </button>
    </div>
    
    <!-- Liste des tâches -->
    <ul class="task-list">
      <li 
        v-for="task in filteredTasks" 
        :key="task.id"
        :class="{ completed: task.done, urgent: isUrgent(task) }"
      >
        <input 
          type="checkbox" 
          v-model="task.done"
          @change="updateTask(task.id)"
        />
        <span>{{ task.title }}</span>
        <button @click="deleteTask(task.id)" class="delete-btn">✕</button>
      </li>
    </ul>
    
    <!-- Pas de tâches -->
    <p v-if="filteredTasks.length === 0" class="no-tasks">
      Aucune tâche à afficher
    </p>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const tasks = ref([
  { id: 1, title: "Apprendre Vue.js", done: false, priority: 3 },
  { id: 2, title: "Faire les exercices", done: false, priority: 2 },
  { id: 3, title: "Relire le cours", done: true, priority: 1 }
]);

const newTask = ref("");
const filter = ref("all");
let nextId = 4;

// ========== COMPUTED ==========

// Compute : total des tâches
const totalTasks = computed(() => tasks.value.length);

// Compute : tâches complétées
const completedTasks = computed(() => {
  return tasks.value.filter(t => t.done).length;
});

// Compute : tâches en cours
const activeTasks = computed(() => {
  return tasks.value.filter(t => !t.done).length;
});

// Compute : tâches filtrées selon le filtre sélectionné
const filteredTasks = computed(() => {
  switch(filter.value) {
    case 'active':
      return tasks.value.filter(t => !t.done);
    case 'completed':
      return tasks.value.filter(t => t.done);
    default:
      return tasks.value;
  }
});

// ========== METHODS ==========

// Method : ajouter une tâche
function addTask() {
  if (newTask.value.trim() === "") return;
  
  tasks.value.push({
    id: nextId++,
    title: newTask.value,
    done: false,
    priority: 2
  });
  
  newTask.value = "";
}

// Method : supprimer une tâche
function deleteTask(id) {
  const index = tasks.value.findIndex(t => t.id === id);
  if (index > -1) {
    tasks.value.splice(index, 1);
  }
}

// Method : vérifier si urgent (priorité haute ET non complétée)
function isUrgent(task) {
  return task.priority > 2 && !task.done;
}

// Method : mettre à jour une tâche
function updateTask(id) {
  console.log(`Tâche ${id} mise à jour`);
}
</script>

<style scoped>
.app {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

h1 {
  color: #333;
  text-align: center;
}

.add-task {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.add-task input {
  flex: 1;
  padding: 10px;
  border: 2px solid #ddd;
  border-radius: 5px;
  font-size: 16px;
}

.add-task button {
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.filters {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.filters button {
  padding: 8px 15px;
  border: 2px solid #ddd;
  background-color: white;
  cursor: pointer;
  border-radius: 5px;
}

.filters button.active {
  background-color: #007bff;
  color: white;
  border-color: #007bff;
}

.task-list {
  list-style: none;
  padding: 0;
}

.task-list li {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px;
  margin-bottom: 8px;
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  border-radius: 5px;
}

.task-list li.completed {
  opacity: 0.6;
  background-color: #e8f5e9;
}

.task-list li.completed span {
  text-decoration: line-through;
  color: #666;
}

.task-list li.urgent {
  background-color: #fff3e0;
  border-color: #ff9800;
}

.task-list input[type="checkbox"] {
  cursor: pointer;
  width: 18px;
  height: 18px;
}

.task-list span {
  flex: 1;
}

.delete-btn {
  background-color: #f44336;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 3px;
  cursor: pointer;
}

.delete-btn:hover {
  background-color: #d32f2f;
}

.no-tasks {
  text-align: center;
  color: #999;
  font-style: italic;
}
</style>
