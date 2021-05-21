<template>
  <div class="flex w-full flex-wrap">
    <h1 class="w-full text-center text-3xl my-4">Markdown App</h1>
    <section class="flex m-auto w-10/12 h-screen">
      <article class="w-1/2 border">
        <textarea class="w-full h-full" ref="text" :value="text" @input="handleUpdate"></textarea>
      </article>
      <article class="w-1/2 border bg-gray-100" v-html="markedText"/>
    </section>
  </div>
</template>

<script>
import marked from "marked"
import debounce from "../utilities/mixins/debounce"

export default {
  // beforeCreate() {
  //   console.log("before created")
  // },
  // created(){
  //   console.log("created")
  // },
  // beforeMount() {
  //   console.log("before mount")
  // },
  //  beforeUpdate() {
  //   console.log("beforeUpdate")
  // },
  // updated() {
  //   console.log("updated")
  // },
  // beforeUnmount() {
  //   console.log("beforeUnmount")
  // },
  // unmounted() {
  //   console.log("unmounted")
  // },
  mounted() {
    this.$refs.text.focus()
  },
  name: "MarkDown",
  mixins: [debounce],
  data() {
    return {
      text: "",
    }
  },
  computed: {
    markedText() {
      return marked(this.text)
    }
  },
  methods: {
    handleUpdate(event) {
      const task = () => (this.text = event.target.value)
      this.debounce(task, 500)
    },
  },
}
</script>

<style scoped>

</style>
