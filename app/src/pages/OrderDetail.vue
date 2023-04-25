<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart"
        :clear="clearCart" />
    <div class="min-h-full">
        <header class="bg-white shadow">
            <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                <h1 class="text-3xl font-bold tracking-tight text-gray-900">Order details</h1>

            </div>
        </header>
        <main v-if="orders">
            <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 overflow-x-auto">
                <table class="min-w-full leading-normal">
                    <thead>
                        <tr>
                            <th
                                class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                Order ID
                            </th>
                            <th
                                class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                Order date
                            </th>
                            <th
                                class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                shipping
                            </th>
                            <th
                                class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                address
                            </th>
                            <th
                                class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                value price
                            </th>
                            <th
                                class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                Status
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="order in orders" :key="order.order_id">
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                <div class="ml-3">
                                    <p class="text-gray-900 whitespace-no-wrap">
                                        {{ order.order_id }}
                                    </p>
                                </div>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- order date -->
                                    {{ order.order_date }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- shipping -->
                                    {{ order.shipping_name }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- address -->
                                    {{ order.address }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- value price -->
                                    {{ order.total_price }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                <span v-if="order.status_value == 'success'" class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                    <span v-if="order.status_value == 'success'" class="relative">{{order.status_value}}</span>
                                </span>
                                <span v-if="order.status_value == 'pending'" class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                    <span v-if="order.status_value == 'pending'" class="relative">{{order.status_value}}</span>
                                </span>
                                <span v-if="order.status_value == 'shipping'" class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                    <span v-if="order.status_value == 'shipping'" class="relative">{{order.status_value}}</span>
                                </span><span v-if="order.status_value == 'cancel'" class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                    <span v-if="order.status_value == 'cancel'" class="relative">{{order.status_value}}</span>
                                </span>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </main>
        <div v-else>
            <h1>none order</h1>
        </div>
    </div>
</template>

<script>
import axios from '@/plugins/axios'
import MainNavbar from '../components/Navbar.vue'

export default {
    name: 'HomePage',
    components: {
        MainNavbar,
    },
    data() {
        return {
            cart: [],
            orders: []
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
        axios.get(`http://localhost:3000/orderDetails`)
            .then(res => {
                this.orders = res.data
                console.log(this.orders)
            })
            .catch(err => {
                alert(err.response.data)
                this.$router.push("/")
            })
    }
} 
</script>