<template>
  <button class="px-2 py-1 border rounded my-4" @click="shouldShowModal=true">Add New User</button>

  <teleport to="body">
    <Modal v-if="shouldShowModal" @close="shouldShowModal=false">
      <template #header>
        Add New User
      </template>
      <template #body>
        <form @submit.prevent="handleSubmit">
          <div class="p-2">
            <label>Username:</label>
            <input class="w-full p-2 rounded border" type="text" placeholder="Username" v-model="state.form.name"/>
          </div>
          <div class="p-2">
            <label>Email:</label>
            <input class="w-full p-2 rounded border" type="email" placeholder="User email" v-model="state.form.email"/>
          </div>
          <div class="p-2">
            <label>Avatar Url:</label>
            <input class="w-full p-2 rounded border" type="text" placeholder="Avatar Url" v-model="state.form.avatar"/>
          </div>
          <div class="p-2">
            <input type=submit class="w-full p-2 rounded border hover:bg-gray-300" value="Create"/>
          </div>
        </form>
      </template>
    </Modal>
  </teleport>
</template>

<script>
import Modal from "../../components/Modal";
import {reactive, ref} from "vue";
import axios from "../../plugins/axios";

export default {
  components: {Modal},
  setup(_, {emit}){
    const shouldShowModal = ref(false)

    const state = reactive({
      form: {
        name: "",
        email: "",
        avatar: ""
      }
    })

    async function handleSubmit() {
      const {data} = await axios.post("users", state.form)
      state.form = {
        name: "",
        email: "",
        avatar: ""
      }
      emit("new-user-added", data)
      shouldShowModal.value = false
    }

    return {shouldShowModal, handleSubmit, state}
  }
}
</script>

<style scoped>

</style>
