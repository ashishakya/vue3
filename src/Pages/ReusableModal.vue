<template>
  <section class="flex flex-wrap w-full">
    <div class="m-auto">
      <h1 class="text-2xl my-5"> Reusable Modal</h1>

      <Modal @close="closeModal" v-if="shouldShowRedModal">
        <template #header>Red Modal</template>
        <template #body>Red Modal Body</template>
      </Modal>
      <button @click="shouldShowRedModal=true" class="border rounded px-2 mx-4 bg-blue-500 text-white" >Red Modal</button>

      <Modal @close="shouldShowBlueModal=false" v-if="shouldShowBlueModal">
        <template #header>Blue Modal</template>
        <template #body>Blue Modal Body</template>
      </Modal>
      <button @click="shouldShowBlueModal=true" class="border rounded px-2 mx-4 bg-blue-500 text-white">Blue Modal</button>

    </div>
  </section>
</template>

<script>
import Modal from "../components/Modal";
import {ref} from "vue"
export default {
  name: 'ReusableModal',
  components: {
    Modal
  },
  setup(){
    const shouldShowRedModal = ref(false);
    const shouldShowBlueModal = ref(false);

    const closeModal = () => shouldShowRedModal.value = false

    return {closeModal, shouldShowRedModal, shouldShowBlueModal}
  }

}
</script>

<style scoped>

</style>
