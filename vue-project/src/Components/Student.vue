<script>
export default{
  data() {
    return {
      company_name:"Company group",
      topics:[
        {name:"introduction",duration:5},
        {name:"theorie",duration:10},
        {name:"pratique",duration:15},
    ]
    }
  }
}
</script>

<template>
<div>
  <h1>Formation vue.js - <small>{{ company_name }}</small></h1>
  <ul>
    <li v-for="(topic,index) in topics" :key="index">{{ index + 1 }}. {{ topic.name }} - {{ topic.duration }} hours</li>
  </ul>
</div>
</template>

<style scoped>

</style>


