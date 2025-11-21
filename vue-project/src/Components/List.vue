<script>
export default{
  data() {
    return {
      tableau_name:"Liste Product",
      topics:[
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
        {name:"introduction",unit_price:5,quantity:2,description:"first product"},
    ]
    }
  }
}
</script>

<template>
    <h2>{{tableau_name}}</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(topic,index) in topics" :key="index">
                <td>{{index + 1}}</td>
                <td>{{topic.name}}</td>
                <td>{{topic.unit_price}}</td>
                <td>{{topic.quantity}}</td>
                <td>{{topic.description}}</td>
            </tr>
        </tbody>
    </table>
</template>

<style scoped>
    table {
        width: 100%;
        border-collapse: collapse;
    }
</style>