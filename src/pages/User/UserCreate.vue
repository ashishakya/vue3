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
            <input
                   @blur="v$.form.name.$touch"
                   class="w-full p-2 rounded border"
                   :class="{'border-red-500': v$.form.name.$error }"
                   type="text"
                   placeholder="Username"
                   v-model="state.form.name"
            />
            <span class="text-red-500" v-if="v$.form.name.$error" v-text="v$.form.name.$errors[0].$message"/>
          </div>
          <div class="p-2">
            <label>Email:</label>
            <input
                @blur="v$.form.email.$touch"
                class="w-full p-2 rounded border"
                :class="{'border-red-500': v$.form.email.$error }"
                type="email"
                placeholder="User email"
                v-model="state.form.email"
            />
            <span class="text-red-500" v-if="v$.form.email.$error" v-text="v$.form.email.$errors[0].$message"/>
          </div>
          <div class="p-2">
            <label>Avatar Url:</label>
            <input
                @blur="v$.form.avatar.$touch"
                class="w-full p-2 rounded border"
                :class="{'border-red-500': v$.form.avatar.$error }"
                type="text"
                placeholder="Avatar Url"
                v-model="state.form.avatar"
            />
            <span class="text-red-500" v-if="v$.form.avatar.$error" v-text="v$.form.avatar.$errors[0].$message"/>
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
import {computed, reactive, ref} from "vue";
import axios from "../../plugins/axios";
import useVuelidate from '@vuelidate/core'
import {email, required, url} from "@vuelidate/validators";

export default {
  components: {Modal},
  setup(_, {emit}) {
    const shouldShowModal = ref(false)

    const state = reactive({
      form: {
        name: "",
        email: "",
        avatar: ""
      }
    })

    const rules = computed(() => {
      return {
        form: {
          name: {required},
          email: {required, email},
          avatar: {required, url}
        }
      }
    })

    async function handleSubmit() {
      if(!v$.value.$error){
        const {data} = await axios.post("users", state.form)
        state.form = {
          name: "",
          email: "",
          avatar: ""
        }
        emit("new-user-added", data)
        shouldShowModal.value = false
      }
    }

    const v$ = useVuelidate(rules, state)

    // return {shouldShowModal, handleSubmit, state, v$}
    return {state, v$, handleSubmit, shouldShowModal}
  }
}
</script>

<style scoped>

</style>
