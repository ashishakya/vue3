<template>
  <section class="my-5 text-center">
    <button class="border px-2 rounded" @click="handleGoogleLogin">Login With Google</button>
  </section>
</template>

<script>
import firebase from "../../utilities/firebase";

export default {
  methods:{
    handleGoogleLogin(){
      const provider = new firebase.auth.GoogleAuthProvider();
      firebase.auth().signInWithPopup(provider).then(()=>this.$emit('close'));
    },
  }
}
</script>

<style scoped>

</style>
