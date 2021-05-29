<template>
  <section class="flex w-full">
    <div class="mx-auto">
      <h1 class="text-2xl text-center">Calculator</h1>
      <p
          class="text-3xl text-right mt-10 mb-2 w-44 h-15 overflow-x-scroll"
          style="direction: rtl"
          v-text="currentNumber"
      />
      <small>{{ previousNumber}} {{ selectedOperation}} {{ currentNumber }}</small>
      <div class="grid grid-cols-4 gap-1">
        <button @click="handleClick('1')" class="p-2 border rounded shadow w-10 h-10">1</button>
        <button @click="handleClick('2')" class="p-2 border rounded shadow w-10 h-10">2</button>
        <button @click="handleClick('3')" class="p-2 border rounded shadow w-10 h-10">3</button>
        <button @click="handleClick('+')" class="p-2 border rounded shadow w-10 h-10">+</button>
        <button @click="handleClick('4')" class="p-2 border rounded shadow w-10 h-10">4</button>
        <button @click="handleClick('5')" class="p-2 border rounded shadow w-10 h-10">5</button>
        <button @click="handleClick('6')" class="p-2 border rounded shadow w-10 h-10">6</button>
        <button @click="handleClick('-')" class="p-2 border rounded shadow w-10 h-10">-</button>
        <button @click="handleClick('7')" class="p-2 border rounded shadow w-10 h-10">7</button>
        <button @click="handleClick('8')" class="p-2 border rounded shadow w-10 h-10">8</button>
        <button @click="handleClick('9')" class="p-2 border rounded shadow w-10 h-10">9</button>
        <button @click="handleClick('*')" class="p-2 border rounded shadow w-10 h-10">*</button>
        <button @click="handleClick('C')" class="p-2 border rounded shadow h-10 w-10">C</button>
        <button @click="handleClick('0')" class="p-2 border rounded shadow h-10 w-10">0</button>
        <button @click="handleClick('=')" class="p-2 border rounded shadow h-10 w-10">=</button>
        <button @click="handleClick('/')" class="p-2 border rounded shadow h-10 w-10">/</button>
      </div>
    </div>
  </section>
</template>
<script>
// import {onBeforeUnmount, onMounted, ref} from "vue"
import {ref} from "vue"
import useWindowEvent from "../utilities/composition/useWindowEvent";

export default {
  setup() {
    const operations = ["+", "-", "*", "/"];
    const numbers = [1,2,3,4,5,6,7,8,9,0];
    const currentNumber = ref("");
    const previousNumber = ref("");
    const selectedOperation = ref("");

    function handleClick(value) {
      if (value === "=" || value === "Enter") calculate();
      else if (operations.includes(value)) applyOperation(value);
      else if (value === "C") clear();
      else if (numbers.includes(+value)) appendDigit(value);
    }

    function appendDigit(value) {
      currentNumber.value += value;
    }

    function applyOperation(value) {
      calculate()
      previousNumber.value = currentNumber.value
      currentNumber.value = ""
      selectedOperation.value = value
    }

    function calculate() {
      if (selectedOperation.value === "*") multiply()
      else if (selectedOperation.value === "-") subtract()
      else if (selectedOperation.value === "+") sum()
      else if (selectedOperation.value === "/") divide()
      previousNumber.value=""
      selectedOperation.value=""
    }

    function clear() {
      currentNumber.value = ""
    }

    function multiply() {
      currentNumber.value = +previousNumber.value * +currentNumber.value
    }

    function subtract() {
      currentNumber.value = +previousNumber.value - +currentNumber.value
    }

    function sum() {
      currentNumber.value = (+previousNumber.value) + (+currentNumber.value)
    }

    function divide() {
      currentNumber.value = +previousNumber.value / +currentNumber.value
    }

    const handleKeyDown = e =>handleClick(e.key)

    useWindowEvent("keydown", handleKeyDown)

    // onMounted(()=>window.addEventListener("keydown", handleKeyDown))
    //
    // onBeforeUnmount(()=>window.removeEventListener("keydown", handleKeyDown))

    return {currentNumber, handleClick, selectedOperation, previousNumber}
  }
}
</script>

<style scoped>

</style>
