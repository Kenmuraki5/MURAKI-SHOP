<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart" :clear="clearCart"/>

    <section class="text-gray-700 body-font overflow-hidden bg-white">
        <div class="container px-5 py-24 mx-auto">
            <div class="lg:w-4/5 mx-auto flex flex-wrap justify-center">
                <div class="basis-1/2">
                    <img class="w-96 object-cover object-center rounded border border-gray-200" :style="{ opacity: products.in_stock == 0 ? 0.25 : 1 }"
                        :src="products.book_img?`http://34.16.145.46/images/uploads/${products.book_img}`:'http://34.16.145.46/images/uploads/noneprofile.png'">
                </div>
                <div class="lg:basis-1/2">
                    <div class="w-full lg:pl-10 py-6 mt-6 lg:mt-0">
                        <h2 class="text-sm title-font text-gray-500 tracking-widest">{{ products.book_category }}</h2>
                        <h1 class="text-gray-900 text-3xl title-font font-medium mb-1">{{ products.book_name }}</h1>
                        <p class="text-xl font-medium">description</p>
                        <p class="leading-relaxed">{{ products.book_description }}</p>
                        <div class="flex mt-6 pb-5 border-b-2 border-gray-200 mb-5">
                            <div class="flex items-center">
                                <span class="mr-3">amount</span>
                                <div class="form">
                                    <input v-model="amount" type="number"
                                        class="rounded border appearance-none border-gray-400 py-2 focus:outline-none focus:border-red-500 text-base pl-3 pr-2" />
                                </div>
                            </div>
                        </div>
                        <div class="flex">
                            <span class="title-font font-medium text-2xl text-gray-900">฿ {{ products.book_price }}</span>
                            <button v-if="products.in_stock > 0"
                                class="flex ml-auto text-white bg-red-500 border-0 py-2 px-6 focus:outline-none hover:bg-red-600 rounded"
                                @click="addtoCart(products)">Button</button>

                        </div>
                    </div>
                </div>

            </div>
        </div>

    </section>
    <section class="container pb-3 w-full flex flex-col justify-center">
        <div class="relative grid grid-cols-1 gap-4 p-4 mb-2 text-gray-700 rounded-lg bg-white shadow-lg ">COMMENTS</div>
        <div class="relative grid grid-cols-1 gap-4 p-4 mb-2 border rounded-lg bg-white shadow-lg"
            v-if="this.$store.state.token && role == 'customer'">
            <div class="relative flex gap-4 ">
                <img :src="img_user ? `http://34.16.145.46/images/uploads/${this.img_user}`: `http://34.16.145.46/images/uploads/noneprofile.png`"
                    class="relative rounded-lg bg-white border h-20 w-20" alt="" loading="lazy">
                <div class="flex flex-col w-full">
                    <div class="flex flex-row justify-between">
                        <p class="relative text-xl whitespace-nowrap truncate overflow-hidden">{{ username }}</p>
                    </div>
                </div>
            </div>
            <textarea v-model="comment" placeholder="Comment..."
                class="block w-full px-4 py-2 leading-tight text-gray-700 bg-gray-200 border border-gray-300 rounded-md focus:outline-none"
                rows="5"></textarea>
            <button
                class="border-2 border-gray-100 focus:outline-none bg-blue-600 text-white font-bold tracking-wider block w-full p-2 rounded-lg focus:border-gray-700 hover:bg-blue-700"
                @click="addComment()">Submit</button>
        </div>
        <div class="relative grid grid-cols-1 gap-4 p-4 mb-2 border rounded-lg bg-white shadow-lg"
            v-for="comment in comments" :key="comment.comment_id">
            <div class="relative flex gap-4">
                <img :src="`http://34.16.145.46/images/uploads/${comment.c_image}`"
                    class="relative rounded-lg bg-white border h-20 w-20" alt="" loading="lazy">
                <div class="flex flex-col w-full">
                    <div class="flex flex-row justify-between">
                        <p class="relative text-xl whitespace-nowrap truncate overflow-hidden">{{ comment.c_username }}</p>
                    </div>
                    <p class="text-gray-400 text-sm">{{ comment.created_at }}</p>
                </div>
            </div>
            <p class="-mt-4 text-gray-500">{{ comment.comment }}</p>
        </div>

    </section>
    <MainFooter />
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import MainFooter from '../components/MainFooter.vue'
import axios from '@/plugins/axios'



export default {
    name: 'AllBookPage',
    components: {
        MainNavbar,
        MainFooter
    },
    data() {
        return {
            cart: [],
            name: "AllBook",
            products: [],
            comments: null,
            amount: 1,
            img_user: null,
            username: null,
            comment: null,
            role:""
        }
    },
    methods: {
        clearCart(){
            localStorage.removeItem("cart")
            this.cart = []
        },
        addtoCart(value) {
            for (let i = 0; i < this.cart.length; i++) {
                if (this.cart[i].isbn == value.isbn && this.cart[i].quantity < value.in_stock) {
                    this.cart[i].quantity += this.amount
                    if(this.cart[i].quantity > value.in_stock) this.cart[i].quantity = value.in_stock
                    return localStorage.setItem("cart", JSON.stringify(this.cart))
                }
            }
            if (!this.cart.find(x => x.isbn == value.isbn)) {
                Object.assign(value, { quantity: 0 });
                if(this.amount > value.in_stock) this.amount = value.in_stock 
                value.quantity = this.amount
                this.cart.push(value)
            }
            localStorage.setItem("cart", JSON.stringify(this.cart))
        },
        removefromCart(value) {
            this.cart[this.cart.indexOf(value)].quantity-- <= 1 ? this.cart.splice(this.cart.indexOf(value), 1) : 1
            // this.cart.splice(this.cart.indexOf(value), 1)
            localStorage.setItem("cart", JSON.stringify(this.cart))
        },
        addComment() {
            if (!this.comment) return false
            const formData = {
                comment: this.comment
            }
            axios.post(`http://34.16.145.46/api/addComment/${this.$route.params.id}`, formData)
                .then(res => {
                    console.log(res)
                    this.comments = res.data[1]
                    this.comment = null
                }).catch(err => console.log(err))
        }
    },
    computed: {
        totalPrice() {
            return this.cart.reduce((total, item) => total + (parseInt(item.book_price)) * item.quantity, 0)
        },
        totalCart() {
            return this.cart.reduce((total, item) => total + item.quantity, 0)
        },
    },
    created() {
        this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart)
        axios.get(`http://34.16.145.46/api/DetailPage/${this.$route.params.id}`)
            .then(res => {
                this.products = res.data[0]
                this.comments = res.data[1]
            }
            )
            .catch(err => console.log(err))
        axios.get(`http://34.16.145.46/api/user/me`)
        .then(res => {
            this.username = res.data.c_username || res.data.a_username
            this.img_user = res.data.c_image || res.data.a_image
            this.role = res.data.type
        }).catch(err => console.log(err))
    }
} 
</script>
