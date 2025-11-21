<script>
export default{
  data() {
    return {
      tableau_name:"Liste Product",
      datas:
[
  {name:"Introduction", unit_price:5, quantity:2, description:"Premier produit"},
  {name:"HTML Basics", unit_price:10, quantity:1, description:"Cours sur HTML"},
  {name:"CSS Fundamentals", unit_price:8, quantity:3, description:"Cours sur CSS"},
  {name:"JavaScript Intro", unit_price:12, quantity:2, description:"Cours sur JS"},
  {name:"Vue.js Basics", unit_price:15, quantity:1, description:"Cours sur Vue.js"},
  {name:"Node.js Intro", unit_price:20, quantity:2, description:"Cours sur Node.js"},
  {name:"Project Setup", unit_price:25, quantity:1, description:"Mise en place du projet"},
]
    }
  }
}
</script>

<template>
    <div>
        <h1>Nos produits</h1>
        <div class="product" v-for="(data,index) in datas" :key="index">
            <h3>{{data.name}}</h3>
            <div>
                <p>
                    <b>Prix unitaire:</b>
                    <b>{{data.unit_price }}</b><br>
                    <b>Quantity</b>
                    <b>{{data.quantity}}</b>
                </p>
            </div>
        </div>
    </div>
</template>

<style scoped>
</style>