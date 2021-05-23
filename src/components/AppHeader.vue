<template>
  <nav class="w-full bg-gradient-to-r from-blue-800 to-blue-400 text-white px-4 py-2 font-bold">
    <router-link v-for="link in links" :key="link.to" :to="link.to" class="mx-2" v-text="link.title"/>
    <button class="mx-2" @click="handleLogout" v-if="$root.isLoggedIn">LOGOUT</button>
    <button class="mx-2" @click="$emit('login')" v-else>LOGIN</button>
  </nav>
</template>

<script>
import firebase from "../utilities/firebase"
export default {
  data() {
    return {
      links:[
        {to:"dc-heros", title: "DC HEROS"},
        {to:"calender", title: "CALENDER"},
        {to:"markdown", title: "MARK DOWN"},
        {to:"slider", title: "SLIDER CAROUSEL"},
        {to:"calculator", title: "CALCULATOR"},
        {to:"reusable-modal", title: "REUSABLE MODAL"},
      ]
    }
  },
  methods:{
    handleLogout(){
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

</style>
