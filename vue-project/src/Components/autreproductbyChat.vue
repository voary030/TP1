
<script>
export default {
  name: "Divproduct",
  data() {
    return {
      pro: [
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
        { name: "introduction", unit_price: 5, quantity: 2, description: "first product" },
      ]
    }
  }
}
</script>

<template>
  <div>
    <h1>Nos produits</h1>
    <div class="product" v-for="(data, index) in pro" :key="index">
      <h3>{{ data.name }}</h3>
      <p>
        <b>Prix unitaire:</b> {{ data.unit_price }}<br>
        <b>Quantité:</b> {{ data.quantity }}<br>
        <b>Description:</b> {{ data.description }}
      </p>
    </div>
  </div>
</template>


<style scoped>
.product {
  border: 1px solid #ccc;
  padding: 10px;
  margin-bottom: 10px;
}
</style>
