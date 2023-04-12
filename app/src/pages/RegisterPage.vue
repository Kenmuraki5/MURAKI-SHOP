<template>
    <div class="flex justify-center items-center min-h-screen bg-gray-100">
        <div class="w-full max-w-md">
            <div class="bg-white rounded-lg shadow-lg px-10 py-8">
                    <h2 class="text-2xl font-semibold mb-6">Register</h2>
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full md:w-1/2 px-3 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                for="grid-first-name">
                                First Name
                            </label>
                            <input
                                class="appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
                                id="grid-first-name" type="text" placeholder="Jane" v-model="fname" required>
                        </div>
                        <div class="w-full md:w-1/2 px-3">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                for="grid-last-name">
                                Last Name
                            </label>
                            <input
                                class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                id="grid-last-name" type="text" placeholder="Doe" v-model="lname" required>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-semibold mb-2" for="name">
                            Username
                        </label>
                        <input
                            class="w-full px-3 py-2 rounded-lg border border-gray-400 focus:outline-none focus:border-blue-500"
                            id="name" type="text" v-model="username" required />
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-semibold mb-2" for="password">
                            password
                        </label>
                        <input
                            class="w-full px-3 py-2 rounded-lg border border-gray-400 focus:outline-none focus:border-blue-500"
                            id="password" type="password"  v-model="password" required />
                    </div>
                    <div class="mb-6">
                        <label class="block text-gray-700 font-semibold mb-2" for="email">
                            Email
                        </label>
                        <input
                            class="w-full px-3 py-2 rounded-lg border border-gray-400 focus:outline-none focus:border-blue-500"
                            id="email" type="email"  v-model="email" required />
                    </div>
                    <div class="w-full">
                        <label class="block text-gray-700 font-semibold mb-2" for="message">
                            address
                        </label>
                        <textarea
                            class="w-full px-3 py-2 rounded-lg border border-gray-400 focus:outline-none focus:border-blue-500"
                            id="address" name="address" rows="5" v-model="address" required></textarea>
                    </div>
                    <div class="w-full">
                        <label class="block text-gray-700 font-semibold mb-2" for="phone">
                            Phone Number
                        </label>
                        <div class="flex">
                            <input
                                class="w-full px-3 py-2 rounded-r-lg border border-gray-400 focus:outline-none focus:border-blue-500"
                                id="phone" type="tel"  placeholder="123-456-7890" v-model="phonenumber"
                                required />
                        </div>
                    </div>
                    <div>
                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-semibold my-3 py-2 px-4 rounded-lg"
                            type="submit" @click="submit()">
                            Register
                        </button>
                    </div>
            </div>
        </div>
    </div>
</template>
  

<script>
import axios from 'axios';

export default {
    data() {
        return {
            fname: "",
            lname: "",
            username: "",
            password: "",
            email: "",
            address: "",
            phonenumber: ""
        }
    },
    methods: {
        async submit() {
            const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            try {
                if (!this.fname) {
                    alert('please fill firstname')
                }
                else if (!this.lname) {
                    alert('please fill lastname.')
                }
                else if (!this.username) {
                    alert('Please fill username.')
                }
                else if (!this.password) {
                    alert('Please fill password.')
                }
                else if (pattern.test(this.password)) {
                    alert('Password is invalid.')
                }
                else if (!this.email) {
                    alert('Please fill email.')
                }
                else if (!this.email.includes("@")) {
                    alert('Email is invalid.')
                }
                else if (!this.address) {
                    alert('Please fill address.')
                }
                else if (!this.phonenumber) {
                    alert('Please fill phone number')
                }
                else {
                    const formData = new FormData()
                    formData.append("fname", this.fname)
                    formData.append("lname", this.lname)
                    formData.append("username", this.username)
                    formData.append("password", this.password)
                    formData.append("email", this.email)
                    formData.append("address", this.address)
                    formData.append("phonenumber", this.phonenumber)
                    let res = await axios.post("http://localhost:3000/register", formData, { headers: { 'Content-Type': 'application/json' } })
                    alert(res.data)
                    this.$router.push("/LoginPage")
                }
            } catch (error) {
                alert(error.response.data)
            }
        }
    }
}
</script>