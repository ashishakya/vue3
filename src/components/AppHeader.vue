<template>
  <nav class="w-full bg-gradient-to-r from-blue-800 to-blue-400 text-white px-4 py-2 font-bold">
    <div class="flex justify-between">
      <div>
        <router-link
            v-for="link in links"
            :key="link.to"
            :to="link.to"
            class="mx-2"
            v-text="link.title"
        />
      </div>
      <div>
        <button class="mx-2" @click="handleLogout" v-if="isLoggedIn">LOGOUT</button>
        <button class="mx-2 content-end" @click="$emit('login')" v-else>LOGIN</button>
      </div>
    </div>
  </nav>
</template>

<script>
import firebase from "../utilities/firebase"

export default {
  data() {
    return {
      links: [
        {to: "dc-heros", title: "DC HEROS"},
        {to: "calender", title: "CALENDER"},
        {to: "markdown", title: "MARK DOWN"},
        {to: "slider", title: "SLIDER CAROUSEL"},
        {to: "calculator", title: "CALCULATOR"},
        {to: "reusable-modal", title: "REUSABLE MODAL"},
        {to: "chat-app", title: "CHAT APP"},
        {to: "users", title: "USER"},
        {to: "tensorflow", title: "TENSORFLOW"},
      ],
      store: this.$store.state
    }
  },
  computed:{
    isLoggedIn(){
      return this.$store.state.isLoggedIn
    }
  },
  methods: {
    handleLogout() {
      firebase.auth().signOut().then(() => {
        // Sign-out successful.
      }).catch((error) => {
        console.log(error)
      });
    }
  }
}
</script>

<style scoped>
.is-active{
  background: white;
  color: blue;
  padding: 2px;
  border-radius: 8px;
}
</style>
