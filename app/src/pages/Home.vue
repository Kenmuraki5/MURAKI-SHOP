<template>
  <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart" />
  <EventBar></EventBar>
  <MainitemList :add="addtoCart" />
  <MainFooter />
</template>

<script>
// import { mapState } from 'vuex'

import MainNavbar from '../components/Navbar.vue'
import EventBar from '../components/CarouselBar.vue'
import MainitemList from '../components/MainitemList.vue'
import MainFooter from '../components/MainFooter.vue'
import axios from 'axios'
export default {
  name: 'HomePage',
  components: {
    MainNavbar,
    EventBar,
    MainitemList,
    MainFooter
  },
  data() {
    return {
      cart: [],
    }
  },
  methods: {
    addtoCart(value) {

      for (let i = 0; i < this.cart.length; i++) {
        if (this.cart[i].isbn == value.isbn && this.cart[i].quantity < value.in_stock) {
          this.cart[i].quantity++
          return localStorage.setItem("cart", JSON.stringify(this.cart))
        }
      }
      if(!this.cart.find(x => x.isbn == value.isbn)) {
        Object.assign(value, { quantity: 0 });
        value.quantity = 1
        this.cart.push(value)
      }
      localStorage.setItem("cart", JSON.stringify(this.cart))
    },
    removefromCart(value) {
      this.cart[this.cart.indexOf(value)].quantity-- == 1 ? this.cart.splice(this.cart.indexOf(value), 1) : 1
      // this.cart.splice(this.cart.indexOf(value), 1)
      localStorage.setItem("cart", JSON.stringify(this.cart))
    }
  },
  computed: {
    totalPrice() {
      return this.cart.reduce((total, item) => total + (parseInt(item.book_price)) * item.quantity, 0)
    },
    totalCart() {
      return this.cart.reduce((total, item) => total + item.quantity, 0)
    }
  },
  created() {
    this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart)
    axios.get(`http://localhost:3000/`)
      .then(res => this.$store.state.products = res.data)
      .catch(err => {
        console.log(err)

      })

  }
} 
</script>

