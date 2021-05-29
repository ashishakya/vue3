<template>
  <AppHeader @login="$store.commit('toggleLoginModal', true)"/>
  <div class="w-full flex">
    <router-view/>
    <!--    <CalenderPractise v-model="dob"/>-->
    <!--    <Calender/>-->
    <!--    <DCHeros/>-->
  </div>
  <teleport to="body">
    <LoginModal v-if="$store.state.showLoginModal" @close="$store.commit('toggleLoginModal', false)"/>
  </teleport>
</template>

<script>
import AppHeader from "./components/AppHeader";
import LoginModal from "./components/LoginModal";
// import DCHeros from "./components/DCHeros";
// import Calender from "./components/Calender";
// import CalenderPractise from "./components/CalenderPractise";
import firebase from "./utilities/firebase";

export default {
  data() {
    return {
      // showLoginModal: false,
      dob: '6/21/2021',
      // isLoggedIn: false,
      // authUser: {}
      // dob:null
    }
  },
  mounted() {
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        // this.isLoggedIn = true
        // this.authUser = user
        this.$store.commit('setLoggedInStatus', true)
        this.$store.commit('setAuthUser', user)
      } else {
        // this.isLoggedIn = false
        // this.authUser = {}
        this.$store.commit('setLoggedInStatus', false)
        this.$store.commit('setAuthUser', {})
      }
    });
  },
  components: {
    // DCHeros,
    AppHeader,
    LoginModal
    // Calender,
    // CalenderPractise
  },
}
</script>
