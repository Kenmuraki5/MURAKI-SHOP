<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart"/>
    <BookList :add="addtoCart" :typebook="typeBook" :Name="name"/>
    <MainFooter />
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import BookList from '../components/BookList.vue'
import MainFooter from '../components/MainFooter.vue'


import Book from "../data/book.js"

export default {
  name: 'HomePages',
  components: {
    MainNavbar,
    BookList,
    MainFooter
  },
  data(){
    return{
      cart:[],
      typeBook:Book,
      name:"ALL BOOK"
    }
  },
  methods:{
    addtoCart(value){
      for(let i = 0 ;i<this.cart.length;i++){
          if(this.cart[i].id == value.id){
            this.cart[i].quantity++
            return localStorage.setItem("cart", JSON.stringify(this.cart))
          }
      }
      value.quantity = 1
      this.cart.push(value)
      localStorage.setItem("cart", JSON.stringify(this.cart))
    },
    removefromCart(value){
      this.cart[this.cart.indexOf(value)].quantity-- == 1 ? this.cart.splice(this.cart.indexOf(value), 1) : 1
      // this.cart.splice(this.cart.indexOf(value), 1)
      localStorage.setItem("cart", JSON.stringify(this.cart))
    }
  },
  computed:{
    totalPrice(){
      return this.cart.reduce((total, item) => total+(parseInt(item.price.slice(1)))*item.quantity, 0)
    },
    totalCart(){
      return this.cart.reduce((total, item) => total+item.quantity, 0)
    }
  },
  created(){
    this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart)
  }

} 
</script>
