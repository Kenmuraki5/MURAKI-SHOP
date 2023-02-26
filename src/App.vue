<template>
  <MainNavbar />
  <EventBar></EventBar>
  <MainitemList />
</template>

<script>
import MainNavbar from './components/Navbar.vue'
import EventBar from './components/CarouselBar.vue'
import MainitemList from './components/MainitemList.vue'
export default {
  name: 'App',
  components: {
    MainNavbar,
    EventBar,
    MainitemList
  }
} 
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
}
</style>
