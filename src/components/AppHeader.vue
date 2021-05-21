<template>
  <nav class="w-full bg-gradient-to-r from-blue-800 to-blue-400 text-white px-4 py-2 font-bold">
    <router-link v-for="link in links" :key="link.to" :to="link.to" class="mx-2" v-text="link.title"/>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      links:[
        {to:"dc-heros", title: "DC HEROS"},
        {to:"calender", title: "CALENDER"},
        {to:"markdown", title: "MARK DOWN"},
      ]
    }
  }
}
</script>

<style scoped>

</style>
