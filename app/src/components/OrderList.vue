<template>
    <header class="bg-white shadow flex justify-between">
        <div class="px-4 py-6 sm:px-6 lg:px-8">
            <h1 class="text-3xl font-bold tracking-tight text-gray-900">{{ show ? "Order detail" : "Order Line" }}</h1>
        </div>
        <Menu as="div" class="relative inline-block text-left px-4 py-6 sm:px-6 lg:px-8">
            <div>
                <MenuButton v-if="show"
                    class="inline-flex w-full justify-center gap-x-1.5 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                    sort
                    <ChevronDownIcon class="-mr-1 h-5 w-5 text-gray-400" aria-hidden="true" />
                </MenuButton>
            </div>

            <transition enter-active-class="transition ease-out duration-100"
                enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95">
                <MenuItems 
                  class="absolute right-0 z-10 mt-2 w-40 origin-top-right rounded-md bg-white shadow-2xl ring-1 ring-black ring-opacity-5 focus:outline-none">
                  <div class="py-1">
                    <MenuItem v-for="sta in statuss"  :key="sta.status" v-slot="{ active }" >
                    <a  @click="sort(sta.value)"
                      :class="[sta.current ? 'font-medium text-gray-900' : 'text-gray-500', active ? 'bg-gray-100' : '', 'block px-4 py-2 text-sm']">{{
                        sta.status }}</a>
                    </MenuItem>
                  </div>
                </MenuItems>
            </transition>
        </Menu>
    </header>
    <div class="min-h-full" v-if="show">
        <main>
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
                        <tr v-for="order in orders" :key="order.order_id" class="hover:bg-blue-100"
                            @click="showOrderLine(order.order_id)">
                            <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <div class="ml-3">
                                    <p class="text-gray-900 whitespace-no-wrap">
                                        {{ order.order_id }}
                                    </p>
                                </div>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- order date -->
                                    {{ order.order_date }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- shipping -->
                                    {{ order.shipping_name }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- address -->
                                    {{ order.address }}
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    <!-- value price -->
                                    {{ order.total_price }} ฿
                                </p>
                            </td>
                            <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <span v-if="order.status_value == 'success'"
                                    class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                    <span class="relative">{{ order.status_value }}</span>
                                </span>
                                <span v-if="order.status_value == 'pending'"
                                    class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-cyan-200 opacity-50 rounded-full"></span>
                                    <span class="relative">{{ order.status_value }}</span>
                                </span>
                                <span v-if="order.status_value == 'shipping'"
                                    class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-yellow-300 opacity-50 rounded-full"></span>
                                    <span class="relative">{{ order.status_value }}</span>
                                </span><span v-if="order.status_value == 'cancel'"
                                    class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                    <span aria-hidden class="absolute inset-0 bg-red-600 opacity-50 rounded-full"></span>
                                    <span class="relative">{{ order.status_value }}</span>
                                </span>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </main>
    </div>
    <div class="orderline" v-if="show == false">
        <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 overflow-x-auto">
            <button @click="show = true" class="font-bold py-3 px-3 hover:text-rose-600">
                <i style='font-size:24px' class='fas'>&#xf104;</i>
                Back
            </button>
            <table class="min-w-full leading-normal">
                <thead>
                    <tr>
                        <th
                            class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                            Order ID
                        </th>
                        <th
                            class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                            isbn
                        </th>
                        <th
                            class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                            book name
                        </th>
                        <th
                            class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                            quantity
                        </th>
                        <th
                            class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                            price
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="orderlines in orderlines" :key="orderlines.line_id" class="hover:bg-blue-100">
                        <td class="px-5 py-5 border-b border-gray-200 text-sm">
                            <div class="ml-3">
                                <p class="text-gray-900 whitespace-no-wrap">
                                    {{ orderlines.order_id }}
                                </p>
                            </div>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 text-sm">
                            <p class="text-gray-900 whitespace-no-wrap mt-3">
                                <!-- order date -->
                                <img class="w-20 h-30" :src="`http://34.125.67.227/images/uploads/${orderlines.book_img}`" alt="">
                                {{ orderlines.isbn }}
                            </p>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 text-sm">
                            <p class="text-gray-900 whitespace-no-wrap mt-3">
                                <!-- order date -->
                                {{ orderlines.book_name }}
                            </p>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 text-sm">
                            <p class="text-gray-900 whitespace-no-wrap">
                                <!-- address -->
                                {{ orderlines.quantity }}
                            </p>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 text-sm">
                            <p class="text-gray-900 whitespace-no-wrap">
                                <!-- value price -->
                                {{ orderlines.price }} ฿
                            </p>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </div>
</template>
<script setup>
import { Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/vue'
import { ChevronDownIcon } from '@heroicons/vue/20/solid'
const statuss = [
      {status: 'AllOrder', value: null},
      {status: 'Shipping', value: "shipping"},
      {status: 'Cancel', value: "cancel"},
      {status: 'Success', value: "success"},
      {status: 'Pending', value: "pending"},
    ]
</script>
<script>
import axios from '@/plugins/axios'

export default {
    name: 'OrderList',
    data() {
        return {
            orders: [],
            orderlines: [],
            show: true
        }
    },
    methods: {
        showOrderLine(order_id) {
            this.show = false
            var formData = new FormData()
            formData.append("order_id", order_id)
            axios.post("http://34.125.67.227/api/orderline", formData, {
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(res => {
                    this.orderlines = res.data
                })
                .catch(err => {
                    alert(err.response.data)
                })
        },
        sort(value){
            console.log(value)
            axios.get(`http://34.125.67.227/api/orderDetails`, {params:{status:value}})
            .then(res => {
                this.orders = res.data
                console.log(this.orders)
            })
            .catch(err => {
                alert(err.response.data)
                this.$router.push("/")
            })
        }
    },
    created() {
        this.cart = JSON.parse(localStorage.cart == undefined ? "[]" : localStorage.cart)
        axios.get(`http://34.125.67.227/api/orderDetails`)
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