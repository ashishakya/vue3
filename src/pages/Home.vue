<template>
  <div class="m-auto">
  <h1 class="text-center">Welcome to Vue 3</h1>
  <h2>{{ $store.state.greet }}</h2>
    <Greeting/>
  </div>
</template>

<script>
import Greeting from "../components/Greeting";

export default {
  components:{
    Greeting
  }
}
</script>

<style scoped>

</style>
