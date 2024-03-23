<template>
    <!-- EDIT BOOK -->
    <div class="overflow-x-auto rounded-lg border border-gray-200 shadow-md m-5">
        <table class="table-auto w-full border-collapse bg-white text-left text-sm text-gray-500">
            <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Order
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Username
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Total price
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Date
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Status order
                    </th>
                    <th scope="col" class="px-6 py-3 font-medium text-gray-900"></th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                <tr class="hover:bg-gray-50" v-for="slip in allSlip" :key="slip.order_id">
                    <td class="px-6 py-4 ">
                        {{ slip.order_id }}
                    </td>
                    <td class="px-6 py-4">
                        {{ slip.c_username }}
                    </td>
                    <td class="px-6 py-4">
                        {{ slip.total_price }}
                    </td>
                    <td class="px-6 py-4">
                        {{ slip.order_date }}
                    </td>
                    <td class="px-6 py-4">
                        {{ slip.status_value }}
                    </td>
                    <td class="px-6 py-4">
                        <button @click="showDetail(slip)">Show Detail</button>
                        <br>
                        <div class="" v-if="slip.status_value == 'pending'">
                            <button @click="approve(slip)">Approve</button>
                            <br>
                            <button @click="decline(slip)">Decline</button>
                        </div>
                    </td>

                </tr>
            </tbody>
        </table>
        <div v-if="detailVisible" class="fixed inset-0 z-10 overflow-y-auto">
            <div class="flex items-center justify-center min-h-screen px-4">
                <div class="bg-white w-full max-w-md px-4 h-1/4 md:h-auto">
                    <div class="h-1/12">
                        <h2 class="text-2xl font-semibold mb-4">Detail</h2>
                    </div>
                    <img class="max-h-[40rem]" :src='`http://34.16.145.46/images/uploads/${selectedSlip.slip_img}`' alt="">
                    <div class="h-3/12">
                        <p><strong>List:</strong></p>
                        <div v-for="(list, index) in selectedSlip.name.split(',')" :key="index">
                            <p> {{ list }} :
                                {{ selectedSlip.quantity.split(',')[index] }}pc    {{ selectedSlip.price.split(',')[index]
                                }}฿
                            </p>
                        </div>
                        <p><strong>Shipping Method:</strong> {{ selectedSlip.shipping_name }}</p>
                        <p><strong>Total price:</strong> {{ selectedSlip.total_price }} ฿</p>
                        <p><strong>Date:</strong> {{ selectedSlip.order_date }}</p>
                        <button class="bg-blue-500 text-white font-bold py-2 px-4 rounded mt-4"
                            @click="closeDetailModal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from '@/plugins/axios';
export default {
    data() {
        return {
            allSlip: null,
            detailVisible: false,
            selectedSlip: null,
        }
    },
    methods: {
        showDetail(slip) {
            this.selectedSlip = slip;
            this.detailVisible = true;
        },
        closeDetailModal() {
            this.selectedSlip = null; // Clear the selected slip
            this.detailVisible = false; // Hide the detail modal
        },
        approve(slip) {
            console.log(slip)
            axios.put('http://34.16.145.46/api/approve', slip).then(res => {
                console.log(res)
                this.$emit('slip');
            }).catch(err => {
                console.log(err)
            })
        },
        decline(slip) {
            console.log(slip)
            axios.put('http://34.16.145.46/api/decline', slip).then(res => {
                console.log(res)
                this.$emit('slip');
            }).catch(err => {
                console.log(err)
            })
        }
    },
    created() {
        axios.get("http://34.16.145.46/api/allSlip")
            .then(res => {
                this.allSlip = res.data
                console.log(this.allSlip)
            }
            ).
            catch(
                err => console.log(err)
            )
    },
};
</script>