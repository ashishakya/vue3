<template>
  <div>
<!--    <button -->
<!--        class="border rounded bg-gradient-to-r from-blue-700 to-pink-500 text-white" -->
<!--        @click="UPDATE_GREET_MESSAGE"-->
<!--    >-->
      <button
          class="border rounded bg-gradient-to-r from-blue-700 to-pink-500 text-white"
          @click="updateWithAction"
      >
      Update greet
    </button>
    <hr>
    <div>Map State User: {{ user.name }}</div>
    <div>Using getters: {{ $store.getters.userAge }}</div>
    <div>Using mapGetters: {{ userAge }}</div>
  </div>
</template>

<script>
import {UPDATE_GREET_MESSAGE} from "../store/mutation-types";
import { mapState, mapGetters, mapMutations } from "vuex";

export default {
  name: "Greeting",
  computed: {
    ...mapState([
      'user'
    ]),
    ...mapGetters([
      'userAge'
    ])
  },
  methods: {
    ...mapMutations(
        [
          UPDATE_GREET_MESSAGE
        ]
    ),
    handleUpdate(){
      this.$store.commit({
        type: UPDATE_GREET_MESSAGE,
        message:"hey myan welcome to store"
      })
    },
    updateWithAction(){
      // this.$store.dispatch('resetGreetMessageWithAction')
      this.$store.dispatch('asyncResetGreetMessageWithAction')
    },
  }
}
</script>

<style scoped>

</style>
