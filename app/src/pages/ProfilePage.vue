<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart" />
    <ProfileUser></ProfileUser>
    <MainFooter></MainFooter>
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import MainFooter from '../components/MainFooter.vue'
import ProfileUser from '../components/ProfileUser.vue'
export default {
    name: 'ProfilePage',
    components: {
        MainNavbar,
        MainFooter,
        ProfileUser
    },
    data() {
        return {
            cart: [],
        }
    },
    methods: {
        addtoCart(value) {
            for (let i = 0; i < this.cart.length; i++) {
                if (this.cart[i].isbn == value.isbn) {
                    this.cart[i].quantity++
                    return localStorage.setItem("cart", JSON.stringify(this.cart))
                }
            }
            Object.assign(value, { quantity: 0 });
            value.quantity = 1
            this.cart.push(value)
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
    mounted() {
        this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart)
        if (!this.$store.state.token) {
            this.$router.push("/")
        }
    }
}
</script>