<template>
  <div class="m-auto">
    <h1 class="text-2xl my-2 text-center">Vue Calender</h1>
    <section class="mx-2 flex justify-between">
      <h2 class="font-bold" v-text="currentMonthName"/>
      <h2 class="font-bold" v-text="currentYear"/>
    </section>
    <section class="flex my-2">
      <p class="text-center" style="width: 14.28%" v-for="(day, index) in days" :key="index">
        {{ day }}
      </p>
    </section>
    <section class="flex flex-wrap">
      <p class="text-center" style="width: 14.28%" v-for="num in startDay()" :key="num"/>
      <p
          class="text-center"
          style="width: 14.28%; cursor: pointer"
          v-for="num in daysInMonth()"
          :key="num"
          v-text="num"
          @click="handleDateSelect(num)"
          :class="[isToday(num) ? 'font-bold text-red-500': '',  isSelected(num) ? 'font-bold border rounded-md' : '']"
      />
    </section>
    <section class="flex justify-between my-4">
      <button class="px-2 border rounded" @click="handlePrev">Prev</button>
      <button class="px-2 border rounded" @click="handleNext">Next</button>
    </section>
    <section>
      <div>Selected Date: <span v-text="selectedDate" class="text-red-600"/></div>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      days: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      currentYear: new Date().getFullYear(),
      currentMonth: (new Date().getMonth()),
      currentDate: (new Date().getDate()),
      selectedDate: (new Date().toLocaleDateString()),
    }
  },
  methods: {
    isToday(date){
      return (new Date(this.currentYear, this.currentMonth, date).toDateString()) === (new Date().toDateString());
    },
    isSelected(date){
      return new Date(this.currentYear, this.currentMonth, date).toLocaleDateString() === this.selectedDate
    },
    daysInMonth() {
      return new Date(this.currentYear, this.currentMonth + 1, 0).getDate()
    },
    startDay() {
      return new Date(this.currentYear, this.currentMonth, 1).getDay();
    },
    handleNext() {
      if (this.currentMonth === 11) {
        this.currentYear++
        this.currentMonth = 0
      } else {
        this.currentMonth++
      }
    },
    handlePrev() {
      if (this.currentMonth === 0) {
        this.currentYear--
        this.currentMonth = 11
      } else {
        this.currentMonth--
      }
    },
    handleDateSelect(date){
      this.selectedDate = new Date(this.currentYear, this.currentMonth, date).toLocaleDateString()
    }
  },
  computed: {
    currentMonthName() {
      return new Date(this.currentYear, this.currentMonth).toLocaleString('default', {month: 'long'})
    }
  }
}
</script>

<style scoped>

</style>
