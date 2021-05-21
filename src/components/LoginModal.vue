<template>
  <section
      class="z-20 h-screen w-screen bg-gray-500 fixed top-0 opacity-50"
      @click="closeModal"
  >
  </section>
  <div class="absolute inset-0">
    <div class="flex h-full">
      <div class="z-30 m-auto bg-white p-2 rounded shadow w-1/3">
        <div class="p-2 border">
          <h1 class="text-xl text-center">Login</h1>
          <GoogleLogin @close="closeModal"/>
          <p class="text-center">OR</p>
          <form class="p-2 my-2" @submit.prevent="handleSubmit">
            <div class="my-4">
              <label>Email or Username</label>
              <input
                  ref="email"
                  class="rounded shadow p-2 w-full"
                  placeholder="Enter your email or username"
                  v-model="formData.email"
              />
            </div>
            <div class="my-4">
              <label>Password</label>
              <input
                  class="rounded shadow p-2 w-full"
                  type="password"
                  placeholder="Enter your password"
                  v-model="formData.password"
              />
            </div>
            <div class="my-4">
              <button
                  type="submit"
                  class="h-8 w-full rounded shadow-md bg-gradient-to-r from-red-800 to-pink-600 text-white p-2"
              >
                <span v-if="!isLoading">Login</span>
                <span v-else>⌛ ⌛ ⌛ ⌛ ⌛ ⌛</span>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import firebase from "../utilities/firebase";
import GoogleLogin from "./Login/GoogleLogin";
export default {
  name:"LoginModal",
  components: {GoogleLogin},
  data() {
    return {
      formData:{
        email:"",
        password:""
      },
      isLoading:false
    }
  },
  mounted() {
    this.$refs.email.focus()
  },
  methods:{
    handleSubmit(){
      this.isLoading = true
      firebase.auth().signInWithEmailAndPassword(this.formData.email, this.formData.password )
          .then(() => {
            this.isLoading = false
            this.formData.password = ""
            this.formData.email = ""
            this.closeModal()
          })
          .catch(() => {
            this.isLoading = false
            // const errorCode = error.code;
            // const errorMessage = error.message;
          });
    },
    closeModal(){
      this.$emit('close')
    }
  }
}
</script>

<style scoped>

</style>
