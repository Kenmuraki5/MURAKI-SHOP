<template>
  <MainNavbar :add="addtoCart" :total="totalPrice" :remove="removefromCart" :cart="cart"/>
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
      for(let i = 0 ;i<this.cart.length;i++){
          if(this.cart[i].id == value.id){
            this.cart[i].quantity++
              return
          }
      }
    value.quantity = 1
    this.cart.push(value)
  },
    removefromCart(value){
      this.cart[this.cart.indexOf(value)].quantity-- == 1 ? this.cart.splice(this.cart.indexOf(value), 1) : 1
      // this.cart.splice(this.cart.indexOf(value), 1)
    }
  },
  computed:{
    totalPrice(){
      return this.cart.reduce((total, item) => total+(parseInt(item.price.slice(1)))*item.quantity, 0)
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
