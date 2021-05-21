<template>
  <AppHeader/>
  DOB: {{ dob }}
  <div class="w-full flex">
    <CalenderPractise v-model="dob"/>
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
  data(){
    return {
      dob:'6/21/2021'
      // dob:null
    }
  },
  components:{
    // DCHeros,
    AppHeader,
    // Calender,
    CalenderPractise
  },
}
</script>
