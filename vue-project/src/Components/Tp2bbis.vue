<template>
  <div>
    <h2>Filtres</h2>
    
    <div class="buttons">
      <button 
        v-for="category in categories" 
        :key="category.id"
        :class="{ active: activeCategory === category.id }"
        @click="selectCategory(category.id)"
      >
        {{ category.name }}
      </button>
    </div>
    
    <h3>Produits de : {{ selectedCategoryName }}</h3>
    <ul>
      <li v-for="product in filteredProducts" :key="product.id">
        {{ product.name }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const categories = ref([
  { id: 1, name: "Électronique" },
  { id: 2, name: "Vêtements" },
  { id: 3, name: "Livres" }
]);

const products = ref([
  { id: 1, name: "Laptop", categoryId: 1 },
  { id: 2, name: "T-Shirt", categoryId: 2 },
  { id: 3, name: "JavaScript Book", categoryId: 3 },
  { id: 4, name: "Mouse", categoryId: 1 }
]);

const activeCategory = ref(1);

// Computed : le nom de la catégorie sélectionnée
const selectedCategoryName = computed(() => {
  const category = categories.value.find(c => c.id === activeCategory.value);
  return category ? category.name : "Aucune";
});

// Computed : les produits filtrés
const filteredProducts = computed(() => {
  return products.value.filter(p => p.categoryId === activeCategory.value);
});

// Method : changer la catégorie active
function selectCategory(categoryId) {
  activeCategory.value = categoryId;
}
</script>

<style>
.buttons {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

button {
  padding: 10px 20px;
  border: 2px solid #ddd;
  background-color: white;
  cursor: pointer;
  border-radius: 5px;
  transition: all 0.3s;
}

/* Classe qui s'ajoute dynamiquement */
button.active {
  background-color: #007bff;
  color: white;
  border-color: #0056b3;
}

button:hover {
  border-color: #007bff;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  padding: 10px;
  background-color: #f5f5f5;
  margin-bottom: 5px;
  border-radius: 3px;
}
</style>
