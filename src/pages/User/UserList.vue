<template>
  <section class="flex w-full">
    <div class="mx-auto">
      <div class="text-center"><b>USERS</b></div>
      <div class="mt-5">
        <UserCreate @new-user-added="addUser"/>
        <table>
          <thead>
          <tr>
            <th class="px-4 py-2 border">#</th>
            <th class="px-4 py-2 border">Avatar</th>
            <th class="px-4 py-2 border">Name</th>
            <th class="px-4 py-2 border">Email</th>
            <th class="px-4 py-2 border">Actions</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(user, index) in state.users" :key="index">
            <td class="border px-4 py-2" v-text="++index"/>
            <td class="border px-4 py-2">
              <img class="rounded-full" width="50" :src="user.avatar"/>
            </td>
            <td class="border px-4 py-2" v-text="user.name"/>
            <td class="border px-4 py-2" v-text="user.email"/>
            <td class="border px-4 py-2">
              <button @click="handleDelete(user._id)" class="px-2 py-1 bg-red-800 rounded text-white">Delete</button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </section>

</template>

<script>
import {onMounted, reactive} from "vue";
import axios from "../../plugins/axios"
import UserCreate from "./UserCreate";

export default {
  components: {UserCreate},
  setup() {

    const state = reactive({
      users: [],
      })

    onMounted(async () => {
      const {data} = await axios.get("users")
      state.users = data;
    })

     const  handleDelete = async (userId)=>{
      await axios.delete(`users/${userId}`)
      state.users = state.users.filter(user=>user._id !== userId)
    }

    const addUser = user =>state.users.push(user);

    return {state, handleDelete, addUser}
  }
}
</script>

<style scoped>

</style>
