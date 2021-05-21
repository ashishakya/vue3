<template>
  <div class="mx-auto">
    <section class="text-center font-bold">
      <h1>Vue Calender Learning</h1>
    </section>
    <section class="flex justify-between">
      <h2 class="font-bold">{{ currentMonthName }}</h2>
      <h2 class="font-bold">{{ currentYear }}</h2>
    </section>
    <section class="flex">
      <p v-for="day in days" :key="day" v-text="day" class="mx-4 text-center" style="width: 14.28%"/>
    </section>
    <div class="flex flex-wrap">
      <p v-for="date in startDayOfMonth" :key="date" style="width: 14.28%" class="text-center"/>
      <p v-for="date in daysInMonth"
         :class="[isToday(date) ? 'font-bold text-red-500': '',  isSelected(date) ? 'font-bold border rounded-md bg-gray-200' : '']"
         v-text="date"
         :key="date"
         style="width: 14.28%; cursor: pointer"
         class="text-center"
         @click="handleDateSelect(date)"
      />
    </div>
    <div class="flex justify-between">
      <button class="border rounded" @click="handlePrevious">Prev</button>
      <button class="border rounded" @click="setToday">Today</button>
      <button class="border rounded" @click="handleNext">Next</button>
    </div>
    <div class="my-2">
      Selected Date: <span v-text="selectedDate" class="font-bold text-red-600"/>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      days: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      currentYear: new Date().getFullYear(),
      currentMonth: new Date().getMonth(),
      currentDay: new Date().getDay(),
      selectedDate: (new Date().toLocaleDateString()),
    }
  },
  props: ['modelValue'],
  computed: {
    startDayOfMonth() {
      return new Date(this.currentYear, this.currentMonth, 1).getDay()
    },
    daysInMonth() {
      return new Date(this.currentYear, this.currentMonth + 1, 0).getDate()
    },
    currentMonthName() {
      return new Date(this.currentYear, this.currentMonth + 1, 0).toLocaleString('default', {month: 'long'})
    },
  },
  methods: {
    handlePrevious() {
      if (this.currentMonth === 0) {
        this.currentYear--;
        this.currentMonth = 11
      } else {
        this.currentMonth--;
      }
    },
    handleNext() {
      if (this.currentMonth === 11) {
        this.currentYear++
        this.currentMonth = 0
      } else {
        this.currentMonth++
      }
    },
    isToday(date) {
      return new Date(this.currentYear, this.currentMonth, date).toDateString() === new Date().toDateString()
    },
    isSelected(date) {
      return new Date(this.currentYear, this.currentMonth, date).toLocaleDateString() === this.selectedDate
    },
    handleDateSelect(date) {
      this.selectedDate = new Date(this.currentYear, this.currentMonth, date).toLocaleDateString()
    },
    setToday() {
      this.currentYear = new Date().getFullYear();
      this.currentMonth = new Date().getMonth();
      this.currentDay = new Date().getDay();
      this.selectedDate = new Date().toLocaleDateString()
    }
  },
  watch: {
    selectedDate: {
      handler(selectedDate) {
        this.$emit('update:modelValue', selectedDate)
      },
      immediate: true
    },
    modelValue: {
      handler(selectedDate) {
        if (selectedDate) {
          const date = new Date(selectedDate);
          this.selectedDate = date.toLocaleDateString()
          this.currentYear = date.getFullYear();
          this.currentMonth = date.getMonth();
          this.currentDay = date.getDay();
        }
      },
      immediate: true
    }
  }
}
</script>

<style scoped>

</style>
