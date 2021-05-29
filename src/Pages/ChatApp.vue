<template>
  <section class="flex w-full">
    <div class="m-auto">
      <h1 class="text-center text-2xl">Real Time Chat</h1>
      <div class="border rounded-lg">
        <div class="h-64 p-2">
          <div
              v-for="chat in state.chats"
              :key="chat.message"
              class="w-full"
              v-text="chat.message"
              :class="chat.userId===currentUserId ? 'text-right': ''"
          >
          </div>
        </div>
      </div>
      <div class="h-8 p-2">
        <input
            type="text"
            class="p-1 border rounded shadow"
            v-model="state.message"
            placeholder="Type Here..."
            @keydown.enter="handleSubmit"
        />
      </div>
    </div>
  </section>
</template>

<script>
import {computed, onMounted, reactive} from "vue";
// import firebase, {chatsRef} from "../utilities/firebase";
import {chatsRef} from "../utilities/firebase";
import {useStore} from 'vuex';

export default {
  setup() {
    const state = reactive({
      chats:[],
      message:"",
      // currentUserId:null
    });

    const handleSubmit = () =>{
      const newChat =chatsRef.push()
      // console.log({
      //     userId: currentUserId.value,
      //     message:state.message
      //   })
      newChat.set({
        // userId: state.currentUserId,
        userId: currentUserId.value,
        message:state.message
      });

      state.message=""
    }

    onMounted(async () => {
        // listens to the change in collection
      // state.collection.on('value', (snapshot) => {
      //   state.chats = snapshot.val();
      // });

      chatsRef.on('child_added', (snapshot)=>{
        // state.currentUserId = firebase.auth().currentUser.uid;
        state.chats.push({key:snapshot.key, ...snapshot.val()})

        console.log("child_added>>", snapshot.val(), snapshot.key)
      })
    })

    const store = useStore();
    const currentUserId = computed(()=>store.state.authUser.uid)

    return {state, handleSubmit, currentUserId}
  }
}
</script>

<style scoped>

</style>
