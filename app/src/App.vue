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
import axios from '@/plugins/axios'

export default {
  name: "MainNavbar",
  data() {
    return {

    }
  },
  created() {
    axios.get(`http://localhost:3000/user/me`)
    .then(res => {
      this.$store.state.image = res.data.c_image || res.data.a_image
    }).catch(err => console.log(err))
  }
};
</script>