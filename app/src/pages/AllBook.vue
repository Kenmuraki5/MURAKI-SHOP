<template>
  <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart"
    :clear="clearCart" />
  <BookList :add="addtoCart" :name="name" />
  <MainFooter />
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import BookList from '../components/BookList.vue'
import MainFooter from '../components/MainFooter.vue'
import axios from 'axios'



export default {
  name: 'AllBookPage',
  components: {
    MainNavbar,
    BookList,
    MainFooter
  },
  data() {
    return {
      cart: [],
      name: "AllBook",
    }
  },
  methods: {
    clearCart() {
      localStorage.removeItem("cart")
      this.cart = []
    },
    addtoCart(value) {
      for (let i = 0; i < this.cart.length; i++) {
        if (this.cart[i].isbn == value.isbn && this.cart[i].quantity < value.in_stock) {
          this.cart[i].quantity++
          return localStorage.setItem("cart", JSON.stringify(this.cart))
        }
      }
      if (!this.cart.find(x => x.isbn == value.isbn)) {
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
    axios.get(`http://34.125.67.227/api/AllBook`)
      .then(res => this.$store.state.products = res.data)
      .catch(err => console.log(err))
  }
} 
</script>
