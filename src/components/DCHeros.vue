<template>
  <div class="m-auto">
    <h1 class="text-2xl text-center">DC Heros (<span v-text="herosCount"/>)</h1>
    <ul>
      <li class="flex justify-between" v-for="(hero, index) in dcHeros" :key="hero.name">
        <div>
          {{ hero.name }}
        </div>
        <button @click="handleRemove(index)">X</button>
      </li>
    </ul>
    <form @submit.prevent="handleSubmit" class="mt-10">
      <input class="border rounded" ref="input" type="text" v-model.trim.lazy="heroName" placeholder="New Hero"/>
      <button class="border rounded bg-gradient-to-r from-red-700 to-pink-500 text-white" type="submit">Add Hero</button>
    </form>
    <hr>
    <div v-text="randC"></div>
    <div v-text="randC"></div>
    <div v-text="randC"></div>
    <div v-text="randM()"></div>
    <div v-text="randM()"></div>
    <div v-text="randM()"></div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isDisabled: true,
      heroName: "",
      dcHeros: [
        {name: "Super Girl"},
        {name: "Flash"},
        {name: "Batman"},
        {name: "Arrow"},
        {name: "SuperMan"},
      ]
    }
  },
  methods: {
    handleSubmit() {
      if (this.heroName) {
        this.dcHeros.unshift({name: this.heroName});
        this.heroName = null
        this.$refs.input.focus()
      }
    },
    randM() {
      return Math.random()
    },
    handleRemove(id) {
      this.dcHeros.splice(id, 1)
    }
  },
  computed: {
    herosCount() {
      return this.dcHeros.length;
    },
    randC() {
      return Math.random()
    }
  }
}
</script>

<style scoped>

</style>
