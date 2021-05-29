<template>
  <section class="flex w-full">
    <div class="mx-auto">
      <div class="text-center"><b>USERS</b></div>
      <div class="mt-5">
        <table>
          <thead>
          <tr>
            <th class="px-4 py-2 border">#</th>
            <th class="px-4 py-2 border">Avatar</th>
            <th class="px-4 py-2 border">First Name</th>
            <th class="px-4 py-2 border">Last Name</th>
            <th class="px-4 py-2 border">Email</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(user, index) in state.users.data" :key="index">
            <td class="border px-4 py-2" v-text="++index"/>
            <td class="border px-4 py-2">
              <img class="rounded-full" width="50" :src="user.avatar"/>
            </td>
            <td class="border px-4 py-2" v-text="user.first_name"/>
            <td class="border px-4 py-2" v-text="user.last_name"/>
            <td class="border px-4 py-2" v-text="user.email"/>
          </tr>
          </tbody>
        </table>
        <div class="flex justify-between py-2">
          <button
              class="px-3 py-2 border rounded hover:shadow"
              :disabled="state.users.page===1"
              :class="state.users.page===1 ? 'bg-gray-100' : 'hover-shadow'"
              @click="handlePrev"
          >
            Prev
          </button>
          <button
              class="px-3 py-2 border rounded hover:shadow"
              :disabled="state.users.page===state.users.total_pages"
              :class="state.users.page===state.users.total_pages ? 'bg-gray-100' : 'hover-shadow'"
              @click="handleNext"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import {onMounted, reactive} from "vue";
import axios from "../../plugins/axios"

export default {
  setup() {
    const state = reactive({
      users: [],
    })

    onMounted(async () => {
      const {data} = await axios.get("users")
      state.users = data;
    })

    const handleNext = async () => {
      const {data} = await axios.get("users", {params:{page:2}})
      state.users = data;
    }

    const handlePrev = async () => {
      const {data} = await axios.get("users", {params:{page:1}})
      state.users = data;
    }

    return {state, handleNext, handlePrev}
  }
}
</script>

<style scoped>

</style>
