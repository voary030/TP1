<template>
  <button @click="handleClick" class="btn btn-secondary mb-20">
    ← {{ text }}
  </button>
</template>

<script setup>
import { useRouter } from 'vue-router'

const props = defineProps({
  text: {
    type: String,
    default: 'Retour'
  },
  to: {
    type: String,
    default: null
  }
})

const router = useRouter()

const handleClick = () => {
  if (props.to) {
    router.push(props.to)
  } else {
    router.back()
  }
}
</script>
