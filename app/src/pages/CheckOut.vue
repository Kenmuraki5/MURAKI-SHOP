<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart"
        :clear="clearCart" />
    <div class="container px-6 py-20">
        <div class="row">
            <div class="col-md-8">
                <div class="">
                    <h1>Product list</h1>
                </div>
                <!-- ส่วนของ product-->
                <div class="row justify-content-center mb-3 mt-3">
                    <div class="col-md-12 col-xl-12 my-3" v-for="product in cart" :key="product.book_isbn">
                        <div class="card shadow-0 border rounded-3">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 col-lg-3 col-xl-3 mb-4 mb-lg-0">
                                        <div class="bg-image hover-zoom ripple rounded ripple-surface">
                                            <img :src="`http://34.16.145.46/images/uploads/${product.book_img}`" class="w-100" />
                                            <a href="#!">
                                                <div class="hover-overlay">
                                                    <div class="mask" style="background-color: rgba(253, 253, 253, 0.15);">
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-6">
                                        <h5>{{ product.book_name }}</h5>
                                        <h3 class="py-3">
                                            amount: {{ product.quantity }}
                                        </h3>
                                        <h5 style="position:absolute; bottom:10px;">total price:
                                            <span style="color:red;">{{ product.quantity * product.book_price }} ฿</span>
                                        </h5>
                                    </div>
                                    <div class="col-md-12 col-lg-3 col-xl-3 border-sm-start-none border-start">
                                        <div class="d-flex justify-content-end mt-4">
                                            <div class="div">
                                                <h4 style="text-align: right;">{{ product.book_price }} ฿</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 ">

                <div class="customers mt-3 p-3 border rounded-3" style="background-color: rgb(251, 251, 251);">

                    <!-- <div class="form-check">
                       <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="option1" <?php echo 'onclick="showaddress()"'; ?> checked>
                       <label class="form-check-label" for="exampleRadios1">
                           Address as previously applied
                       </label>
                   </div>
                   <div class="form-check">
                       <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="option2" <?php echo 'onclick="showaddress()"'; ?>>
                       <label class="form-check-label" for="exampleRadios2">
                           New address
                       </label>
                   </div> -->
                    <section class="flex flex-col">
                        <img src="../assets/qrpayment.jpg"
                            alt="">
                        <br>
                        <div class="flex">
                            Slip image:
                            <input type="file" id="file" ref="file" accept="image/png, image/jpeg"
                                @change="handleFileUpload()">

                        </div>
                        <br>
                        <div class="flex">
                            Shipping methods:
                            <select id="shipping" class="form-control" v-model="selected">
                                <option v-if="!selected" value="">Select Shipping</option>
                                <option :value="val" v-for="val in shipping" :key="val.shipping_id">
                                    {{ val.shipping_name }}</option>
                            </select>
                        </div>
                        <br>
                        <div class="flex">
                            Address:
                            <select id="address" class="form-control" v-model="addressSelected">
                                <option value=0>Select Address</option>
                                <option :value=address>{{ address }}</option>
                                <option value=2>New Address</option>
                            </select>

                        </div>
                        <br>
                        <div class="flex" v-if="addressSelected == 2">
                            New Address:
                            <input class="form-control" v-model="newAddress" type="text">
                        </div>
                        <br>
                        <hr>
                        <!-- ส่วนของ ราคารวม -->
                        <div class="grid px-4 my-4">
                            <div class="flex justify-between">
                                <span>Books price</span>
                                <span class="text-rose-800">{{ totalPrice }} ฿</span>
                            </div>
                            <div class="flex justify-between">
                                <span>Shipping cost</span>
                                <span class="text-rose-800">{{ selected == "" ? "Please select shipping" : selected.cost }}
                                    ฿</span>
                            </div>
                            <div class="flex justify-between" v-if="selected">
                                <span>Total Price</span>
                                <span class="text-rose-800">{{ totalPrice + selected.cost }} ฿</span>
                            </div>
                        </div>
                        <input type="submit" name="" value="Submit" @click="validateForm()"
                            class="mt-5 bg-emerald-400 hover:bg-emerald-600 text-white font-bold py-2 px-4 border border-blue-700 rounded"><br>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <MainFooter />
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import MainFooter from '../components/MainFooter.vue'
import axios from '@/plugins/axios'
import swal from 'sweetalert';


export default {
    components: {
        MainFooter,
        MainNavbar
    },
    data() {
        return {
            cart: [],
            shipping: null,
            selected: "",
            addressSelected: 0,
            address: null,
            file: null,
            addSelected: "",
            newAddress: null
        }
    },
    methods: {
        clearCart() {
            localStorage.removeItem("cart")
            this.cart = []
        },
        handleFileUpload() {
            this.file = this.$refs.file.files[0];
        },
        validateForm() {
            let errors = []
            if (!this.file) {
                errors.push('Please upload file.')
            }
            if (!this.selected) {
                errors.push('Please select shipping.')
            }
            if (this.addressSelected == 0 || (this.addressSelected == 2 && !this.newAddress)) {
                errors.push('Please select address.')
            }
            if (errors.length) {
                // Display error messages to user or handle them however you wish
                alert(errors)
                return false
            }
            // If all fields are valid, submit form
            this.submit()
        },
        submit() {
            const form = new FormData()
            form.append("cart", JSON.stringify(this.cart))
            form.append("address", this.newAddress || this.address)
            form.append("shipping", this.selected.shipping_id)
            form.append("totalPrice", this.totalPrice)
            form.append("image", this.file)

            axios.post('http://34.16.145.46/api/addPayment', form, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then((res) => {
                console.log(res)
                localStorage.removeItem("cart")
                swal("Payment success!", "thank you very much!", "success");
                this.$router.push("/")
            }).catch((err) => {
                swal({
                    title: "Error",
                    text: err.response.data,
                    icon: "warning",
                    dangerMode: true,
                })
            })
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
    async created() {
        try {
            this.cart = JSON.parse(localStorage.cart == undefined ? [] : localStorage.cart);
            const res = await axios.get("http://34.16.145.46/api/CheckOut", { params: { cart: this.cart } })
            this.shipping = res.data

            const res1 = await axios.get("http://34.16.145.46/api")
            const result = this.cart.filter(val => res1.data.find(val2 => val.isbn == val2.isbn))
            console.log(result)
        } catch (error) {
            console.log(error)
            alert(error.response.data)
            this.$router.push("/")
        }
        axios.get(`http://34.16.145.46/api/user/me`)
            .then((res) => {
                this.address = res.data.c_address || res.data.a_address
            })
            .catch((err) => {
                console.log(err)
            })
    }
}
</script>