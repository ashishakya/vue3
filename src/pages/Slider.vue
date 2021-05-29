<template>
  <div class="flex flex-wrap w-full relative">
    <div v-for="(colour, index) in sliders"
         :key="colour"
         class="absolute w-full"
    >
      <transition name="fade">
        <div
            :class="colour"
            v-if="currentSlide===index"
            style="height: 350px"
        />
      </transition>
    </div>
    <div class="w-full" style="height: 340px">
      <div class="absolute bottom-0 w-full flex justify-center">
        <div
            v-for="(item, index) in sliders"
            :key="item"
            :class="currentSlide === index ? 'bg-gray-700' : 'bg-gray-300' "
            class="w-4 mx-2 h-4 rounded-full cursor-pointer"
            @click="setActive(index)"
        />
      </div>
    </div>
    <!--    <div class="my-10 flex w-full">-->
    <!--      <div class="m-auto">-->
    <!--        <transition name="fade">-->
    <!--          <h1 v-if="shouldShowTitle">Slider Carousel</h1>-->
    <!--        </transition>-->
    <!--        <button class="px-2 rounded border" @click="shouldShowTitle = !shouldShowTitle">Toggle Text</button>-->
    <!--      </div>-->
    <!--    </div>-->
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentSlide: 0,
      interval: "",
      sliders: ["bg-blue-600", "bg-yellow-400", "bg-red-400"],
      shouldShowTitle: true
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
  },
  methods:{
    setActive(index){
      this.currentSlide = index
    }
  }
}
</script>

<style scoped>

.fade-enter-active,
.fade-leave-active {
  transition: all 1s ease;
}

.fade-enter-from {
  opacity: 0;
  transform: translateX(-100%);
}

.fade-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

</style>
