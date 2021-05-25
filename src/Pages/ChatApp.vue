<template>
  <section>
    <div v-for="chat in state.chats" :key="chat.message" v-text="chat.message"/>
  </section>
</template>

<script>
import {onMounted, reactive} from "vue";
import firebase from "../utilities/firebase";

export default {
  setup() {
    const state = reactive({
      chats:{}
    });

    onMounted(async () => {
      const database = firebase.database();
      const collection = database.ref('chats');
      const data = await collection.once("value")
      state.chats = data.val();

      // listens to the change in collection
       collection.on('value', (snapshot) => {
        state.chats = snapshot.val();
        // updateStarCount(postElement, data);
      });
    })

    return {state}
  }
}
</script>

<style scoped>

</style>
