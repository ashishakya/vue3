<template>
  <AppHeader/>
  <div class="w-full flex">
    <CalenderPractise/>
<!--    <Calender/>-->
<!--    <DCHeros/>-->
  </div>
</template>

<script>
import AppHeader from "./components/AppHeader";
// import DCHeros from "./components/DCHeros";
// import Calender from "./components/Calender";
import CalenderPractise from "./components/CalenderPractise";

export default {
  components:{
    // DCHeros,
    AppHeader,
    // Calender,
    CalenderPractise
  },
}
</script>
