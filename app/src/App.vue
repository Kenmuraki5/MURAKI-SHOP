<template>
  <router-view></router-view>
</template>
<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  /* margin-top: 60px; */
}
</style>

<script>

export default {
  name: "MainNavbar",
  data() {
    return {

    }
  },
  created(){
    this.$store.commit('getprofileuser')
  }
};
</script>