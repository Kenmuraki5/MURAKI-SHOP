<template>
    <div class="container rounded bg-white mb-5 lg:mt-14">
        <div class="row">
            <div class="col-md-4 border-right">
                <div class="relative flex flex-column align-items-center text-center p-3 lg:py-5">
                    <img class="rounded-full mt-5 w-56 h-56 lg:w-72 lg:h-72"
                        :src="img_user ? `http://localhost:3000/uploads/${this.img_user}` : `http://localhost:3000/uploads/noneprofile.png`" />
                    <div class="flex mt-3">
                        <div class="row">
                            <input type="file" id="file" ref="file" accept="image/png, image/jpeg"
                                @change="handleFileUpload()">
                            <button v-if="file"
                                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 my-2 rounded-full"
                                @click="changepicture()">uploads</button>
                        </div>

                    </div>
                    <span class="font-semibold mt-3">{{ username }}</span>
                    <span class="text-black-50">{{ email }}
                    </span>
                </div>
            </div>
            <div class="col-md-8 border-right">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right text-2xl font-semibold">Your Profile</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6"><label class="labels font-medium">Username</label>
                            <input type="text" class="form-control" placeholder="first name" v-model="username"
                                :readonly="showsubmit">
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6"><label class="labels font-medium">Name</label><input type="text"
                                class="form-control" placeholder="first name" v-model="name" :readonly="showsubmit"></div>
                        <div class="col-md-6"><label class="labels font-medium">Surname</label><input type="text"
                                class="form-control" v-model="surname" placeholder="surname" :readonly="showsubmit"></div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12"><label class="labels font-medium">Mobile Number</label><input type="text"
                                class="form-control" placeholder="enter phone number" v-model="phonenumber"
                                :readonly="showsubmit"></div>
                        <div class="col-md-12"><label class="labels font-medium">Address</label><textarea type="text"
                                class="form-control" placeholder="enter address line 1" v-model="address"
                                :readonly="showsubmit" /></div>
                        <!-- <div class="col-md-12"><label class="labels font-medium">Postcode</label><input type="text" class="form-control"
                                placeholder="enter postcode" v-model="postcode"></div>
                        <div class="col-md-12"><label class="labels font-medium">State</label><input type="text" class="form-control"
                                placeholder="enter state" v-model=""></div>
                        <div class="col-md-12"><label class="labels font-medium">Area</label><input type="text" class="form-control"
                                placeholder="enter area" v-model=""></div> -->
                        <div class="col-md-12 py-2"><label class="labels font-medium">Email</label>
                            <p class="control">{{ email }}
                            </p>
                            <a class="underline text-blue-600 cursor-pointer" @click="verifyemail()">change email</a>
                        </div>
                    </div>
                    <button v-if="showsubmit"
                        class="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded"
                        @click="editprofile()">
                        {{ edit }}
                    </button>
                    <button v-else
                        class="mt-4 bg-emerald-400 hover:bg-emerald-600 text-white font-bold py-2 px-4 border border-blue-700 rounded"
                        @click="submit()">
                        SAVE
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from '@/plugins/axios'
import swal from 'sweetalert';

export default {
    name: "ProfileUser",
    data() {
        return {
            img_user: "",
            name: "",
            surname: "",
            email: "",
            phonenumber: "",
            address: "",
            username: "",
            // password: "",
            // encodepassword:"",
            edit: "Edit Profile",
            showsubmit: true,
            file: null
        }
    },
    methods: {
        handleFileUpload() {
            this.file = this.$refs.file.files[0];
        },
        changepicture() {
            const formData = new FormData()
            formData.append("img", this.file);
            axios.put(`http://localhost:3000/changepicture`, formData, { headers: { 'Content-Type': 'multipart/form-data' } })
                .then((res) => {
                    console.log(res.data)
                    // this.$store.commit('login',[res.data])
                    location.reload()
                })
                .catch((err) => { console.log(err) })
        },
        editprofile() {
            let person = prompt("Please enter your password:", "");
            axios.get("http://localhost:3000/verifyuser", { params: { password: person } })
                .then((res) => {
                    if (res.data) {
                        this.showsubmit = false
                    }
                    else if (person == "" || person == null) {
                        this.showsubmit = true
                    }
                    else {
                        alert("password is invalid")
                    }
                })
                .catch(err => console.log(err))
        },
        submit() {
            if (!this.name) {
                alert('please fill firstname')
            }
            else if (!this.surname) {
                alert('please fill lastname.')
            }
            else if (!this.username) {
                alert('Please fill username.')
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
                this.showsubmit = true
                const formData = new FormData()
                // formData.append("id", this.$store.state.id)
                formData.append("fname", this.name)
                formData.append("lname", this.surname)
                formData.append("username", this.username)
                // formData.append("password", this.password)
                // formData.append("email", this.email)
                formData.append("address", this.address)
                formData.append("phonenumber", this.phonenumber)
                axios.put(`http://localhost:3000/EditProfile`, formData, { headers: { 'Content-Type': 'application/json' } })
                    .then((res) => {
                        alert("update success")
                        if (res.data.token) {
                            console.log(res.data.token)
                            this.$store.commit('login', [res.data.token])
                        }
                    })
                    .catch((err) => { alert(err.response.data) })
            }
        },
        changeemail() {
            swal("Please new email:", {
                content: "input",
            })
                .then((value) => {
                    if (value == this.email) {
                        swal({
                            title: "change mail success!",
                            icon: "success",
                        });
                    }
                    else {
                        axios.put(`http://localhost:3000/changeemail/`, { email: value })
                            .then((res) => {

                                this.email = res.data
                            })
                            .catch((err) => {
                                swal({
                                    title: "Error?",
                                    text: err.response.data,
                                    icon: "warning",
                                    dangerMode: true,
                                })
                            })
                    }

                });
        },
        verifyemail() {
            swal({
                title: "mail send success!",
                text: "Please check your mail!",
                icon: "success",
            });
            axios.get(`http://localhost:3000/changeemail/`)
                .then((res) => {
                    swal("Please enter your otp:", {
                        content: "input",
                    })
                        .then((value) => {
                            if (res.data == value) {
                                alert("success")
                                this.changeemail()
                            }
                            else {
                                swal("otp invalid")
                            }
                        });
                })
                .catch((err) => {
                    swal({
                        title: "Error",
                        text: err.response.data,
                        icon: "warning",
                        dangerMode: true,
                    })
                })
        }
    },
    created() {
        axios.get(`http://localhost:3000/user/me`)
            .then((res) => {
                this.img_user = res.data.c_image || res.data.a_image
                this.name = res.data.c_first_name || res.data.a_first_name
                this.surname = res.data.c_last_name || res.data.a_last_name
                this.email = res.data.c_email || res.data.a_email
                this.phonenumber = res.data.c_phone || res.data.a_phone
                this.address = res.data.c_address || res.data.a_address
                this.username = res.data.c_username || res.data.a_username
                // this.password = res.data.c_password
                this.data = res.data
                // this.encodepassword = this.password.substring(0, 3) + this.password.substring(3).replace(/./g, '*')
            })
            .catch((err) => {
                console.log(err)
                this.$store.commit("logout")
            })
    }
}
</script>