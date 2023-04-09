<template>
    <MainNavbar :add="addtoCart" :totalCart="totalCart" :totalPrice="totalPrice" :remove="removefromCart" :cart="cart" />
    <div class="container px-6" style="margin-top: 100px;">
        <div class="row">
            <div class="col-md-8">
                <div class="">
                    <h1>Product list</h1>
                </div>
                <!-- ส่วนของ product-->
                <div class="row justify-content-center mb-3 mt-3" id="product">

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
                    <form method="POST">
                        <div class="p-3 d-flex justify-content-center flex-column" id="delivery-address"></div>
                        <div class="form-group row mt-3">
                            <label for="Phone" class="col-sm-2 col-form-label">Phone:</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" name="phone" placeholder="Phone number" required>
                            </div>
                        </div>
                        <hr>
                        <div id="d" style="display: none;">

                        </div>
                        <h3 style="text-align:center;">Summary</h3>
                        <!-- ส่วนของ summart -->
                        <div class="p-3 justify-content-between" id="summary"></div>
                        <hr>
                        <!-- ส่วนของ ราคารวม -->
                        <div id="totalprice"></div>
                        <div id="b" style="display: none;">

                        </div>
                        <hr>
                        <h6 style="text-align: center; color: rgb(229, 48, 78);">Now the system only has cash on delivery.
                        </h6>
                        <hr>
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
export default {
    components: {
        MainFooter,
        MainNavbar
    },
    data() {
        return {

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
    created() {
    this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart)
    }
}
</script>