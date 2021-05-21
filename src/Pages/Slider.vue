<template>
  <div class="flex flex-wrap w-full">
    <div v-for="(colour, index) in sliders"
         :key="colour"
         class="absolute w-full"
    >
      <div
          :class="colour"
          v-if="currentSlide===index"
          style="height: 350px"
      />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentSlide: 0,
      interval: "",
      sliders: ["bg-blue-600", "bg-yellow-400", "bg-red-400"]
    }
  },
  unmounted() {
    clearInterval(this.interval);
  },
  mounted() {
    this.interval = setInterval(() => {
      if (this.currentSlide === 2) {
        this.currentSlide = 0
      } else {
        this.currentSlide++
      }
    }, 1000)
  }
}
</script>

<style scoped>

</style>
