<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart" />
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
                                            <img :src="product.book_img" class="w-100" />
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
                                        <h3 class="">
                                            amount: ${{ product.quantity }}
                                        </h3>
                                        <h5 style="position:absolute; bottom:10px;">total price:
                                            <span style="color:red;">${{ product.quantity * product.book_price }} ฿</span>
                                        </h5>
                                    </div>
                                    <div class="col-md-12 col-lg-3 col-xl-3 border-sm-start-none border-start">
                                        <div class="d-flex justify-content-between mt-4">
                                            <h6 class="text-success">price</h6>
                                            <div class="div">
                                                <h4 style="text-align: right;">${{ product.book_price }} ฿</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 p-3">
                <div class="customers p-3b border rounded-3 p-3" style="background-color: rgb(251, 251, 251);">
                    <h3 style="text-align:center;">Delivery</h3>
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
                    <h5>Address</h5>
                    <form>
                        <div class="p-3 d-flex justify-content-center flex-column" id="delivery-address"></div>
                        <div class="form-group row mt-3">
                            <label for="Phone" class="col-sm-4 col-form-label">Phone:</label>
                            <div class="col-sm-8">
                                <input type="number" class="form-control" name="phone" placeholder="Phone number" required>
                            </div><br><br><br>
                            <label for="countries" class="col-sm-4 col-form-label text-sm text-gray-900 dark:text-white">ตัวเลือกการจัดส่ง</label>
                            <div class="col-sm-8">
                                <select id="countries"
                                class="form-control" v-model="selected">
                                    <option v-if="!selected" value="">Select Shipping</option>
                                    <option :value="val" v-for="val in shipping" :key="val.shipping_id">{{val.shipping_name}}</option>
                                </select>
                            </div>
                            <br><br><br>
                            <label></label>
                        </div>
                        <hr>
                        <h3 style="text-align:center;" class="py-4">ข้อมูลการชำระเงิน</h3>
                        <!-- ส่วนของ ราคารวม -->
                        <div class="grid px-4 my-4">
                            <div class="flex justify-between">
                                <span>ราคารวม</span>
                                <span class="text-rose-800">{{ totalPrice }} ฿</span>
                            </div>
                            <div class="flex justify-between">
                                <span>ค่าจัดส่ง</span>
                                <span class="text-rose-800">{{ selected == "" ? "Please select shipping" : selected.cost }} ฿</span>
                            </div>
                        </div>
                        <input type="submit" name="SUBMIT" value="Payment" class="btn btn-warning" style="width:100%;"><br>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <MainFooter />
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import MainFooter from '../components/MainFooter.vue'
import axios from 'axios'
export default {
    components: {
        MainFooter,
        MainNavbar
    },
    data() {
        return {
            cart: [],
            shipping:null,
            selected:""
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
    async created() {
        try {
            this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart);
            const res = await axios.get("http://localhost:3000/CheckOut")
            this.shipping = res.data
            const res1 = await axios.get("http://localhost:3000/")
            const result = this.cart.filter(val => res1.data.find(val2 => val.isbn == val2.isbn))
            console.log(result)
        } catch (error) {
            console.log(error)
        }
    }
}
</script>