<template>
  <section class="flex w-full">
  <div class="m-auto">
    <div class="mt-10">
      <h1 class="text-2xl my-4">Tensorflow Object Detection</h1>
      <div class="flex flex-wrap justify-center">
        <img
            ref="imgRef"
            src="https://images.unsplash.com/photo-1604658768979-ca1ef26b2324?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"
            width="200"
            crossorigin="anonymous"
        />
        <div class="w-full text-center">
          <button
              @click="detect"
              class="w-30 px-4 mt-2 bg-blue-600 text-white rounded"
          >
            <span v-if="isLoading">Loading ....</span>
            <span v-else>Detect Object</span>
          </button>
          <div v-if="result.length">
            <p>{{ result[0].class }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  </section>
</template>

<script>
import {ref} from "vue";

require('@tensorflow/tfjs-backend-cpu');
require('@tensorflow/tfjs-backend-webgl');
const cocoSsd = require('@tensorflow-models/coco-ssd');

export default {
  setup(){
    const imgRef = ref("");
    const result = ref([]);
    const isLoading = ref(false);

    const detect = async ()=>{
      const img = imgRef.value;
      isLoading.value=true

      // Load the model.
      const model = await cocoSsd.load();

      // Classify the image.
      result.value  = await model.detect(img);
      isLoading.value=false
    }

    return {imgRef, result, detect, isLoading}
  }
}
</script>

<style scoped>

</style>
