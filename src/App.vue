<template>
  <MainNavbar :amount="cart"/>
  <EventBar></EventBar>
  <MainitemList :add="addtoCart"/>
  <MainFooter />
</template>

<script>
import MainNavbar from './components/Navbar.vue'
import EventBar from './components/CarouselBar.vue'
import MainitemList from './components/MainitemList.vue'
import MainFooter from './components/MainFooter.vue'
export default {
  name: 'App',
  components: {
    MainNavbar,
    EventBar,
    MainitemList,
    MainFooter
  },
  data(){
    return{
      cart:[]
    }
  },
  methods:{
    addtoCart(value){
      this.cart.push(value)
    }
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
