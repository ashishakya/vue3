<template>
  <AppHeader/>
  <div class="w-full flex">
    <Calender/>
<!--    <DCHeros/>-->
  </div>
</template>

<script>
import AppHeader from "./components/AppHeader";
// import DCHeros from "./components/DCHeros";
import Calender from "./components/Calender";

export default {
  components:{
    // DCHeros,
    AppHeader,
    Calender
  },
}
</script>
