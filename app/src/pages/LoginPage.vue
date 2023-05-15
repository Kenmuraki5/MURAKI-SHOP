<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart"
        :clear="clearCart" />
    <section class="min-h-screen flex flex-col">
        <nav>
            <div class="px-4 py-8 text-center text-2xl">
                <h3>MURAKICOMIC</h3>
            </div>
        </nav>
        <div class="flex flex-1 items-center justify-center">
            <div class="rounded-lg sm:border-2 px-4 lg:px-24 py-16 lg:max-w-xl sm:max-w-md w-full text-center">
                <h1 class="font-bold tracking-wider text-3xl mb-8 w-full text-gray-600">
                    Sign in
                </h1>
                <div class="py-2 text-left">
                    <input type="text" name="username" v-model="username" v-on:keydown.enter.prevent='submit()'
                        class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700 "
                        placeholder="Email" />
                </div>
                <div class="py-2 text-left">
                    <input type="password" name="password" v-model="password" v-on:keydown.enter.prevent='submit()'
                        class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700 "
                        placeholder="Password" />
                </div>
                <div class="py-2">
                    <button type="submit" @click="submit()"
                        class="border-2 border-gray-100 focus:outline-none bg-purple-600 text-white font-bold tracking-wider block w-full p-2 rounded-lg focus:border-gray-700 hover:bg-purple-700">
                        Sign In
                    </button>
                </div>

                <div class="text-center">
                    <RouterLink to="/ResetPassword" class="hover:underline">Forgot password?</RouterLink>
                </div>
                <div class="text-center mt-12">
                    <span>
                        Don't have an account?
                    </span>
                    <RouterLink to="/RegisterPage"
                        class="font-light text-md text-indigo-600 underline font-semibold hover:text-indigo-800">Create
                        One</RouterLink>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import axios from '@/plugins/axios'
import MainNavbar from '../components/Navbar.vue'
export default {
    components: {
        MainNavbar,
    },
    data() {
        return {
            cart: [],
            username: "johndoe",
            password: "password123"
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
        },
        submit() {
            var formData = new FormData();
            formData.append("username", this.username);
            formData.append("password", this.password)
            axios.post('http://localhost:3000/signin', formData, {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then((response) => {
                console.log(response.data.token)
                this.$store.commit('login', [response.data.token])
                this.$store.commit('getprofileuser')
                this.$router.push({ name: "HomePage" })
            }).catch((error) => {
                alert(error.response.data)
            });
        },
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
    }
}
</script>