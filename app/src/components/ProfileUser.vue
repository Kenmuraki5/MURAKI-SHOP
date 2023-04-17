<template>
    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row">
            <div class="col-md-4 border-right">
                <div class="relative flex flex-column align-items-center text-center p-3 py-5">
                    <img class="rounded-full mt-5 sm:w-30 sm:h-30 lg:w-72 h-72"
                    :src="img_user ? `http://localhost:3000/uploads/${this.img_user}`: `http://localhost:3000/uploads/noneprofile.png`"/>
                    <div class="flex mt-3">
                        <input type="file"
                        id="file" ref="file"
                        accept="image/png, image/jpeg" @change="handleFileUpload()">
                        <button v-if="file" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full" 
                        @click="changepicture()">uploads</button>
                    </div>
                    <span class="font-semibold mt-3">{{ username }}</span>
                    <span
                        class="text-black-50">{{ email}}
                    </span>
                </div>
            </div>
            <div class="col-md-8 border-right">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right font-semibold">Profile Settings</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6"><label class="labels">Username</label><input type="text" class="form-control"
                                placeholder="first name" v-model="username" :readonly="showsubmit"></div>
                        <div v-if ="showsubmit" class="col-md-6"><label class="labels">Password</label><input type="text" class="form-control"
                            placeholder="surname" :value="encodepassword" :readonly="showsubmit"></div>
                        <div v-else class="col-md-6"><label class="labels">Password</label><input type="text" class="form-control"
                                v-model="password" placeholder="surname" :readonly="showsubmit"></div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6"><label class="labels">Name</label><input type="text" class="form-control"
                                placeholder="first name" v-model="name" :readonly="showsubmit"></div>
                        <div class="col-md-6"><label class="labels">Surname</label><input type="text" class="form-control"
                                v-model="surname" placeholder="surname" :readonly="showsubmit"></div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12"><label class="labels">Mobile Number</label><input type="text"
                                class="form-control" placeholder="enter phone number" v-model="phonenumber"
                                :readonly="showsubmit"></div>
                        <div class="col-md-12"><label class="labels">Address Line 1</label><textarea type="text"
                                class="form-control" placeholder="enter address line 1" v-model="address"
                                :readonly="showsubmit" /></div>
                        <!-- <div class="col-md-12"><label class="labels">Postcode</label><input type="text" class="form-control"
                                placeholder="enter postcode" v-model="postcode"></div>
                        <div class="col-md-12"><label class="labels">State</label><input type="text" class="form-control"
                                placeholder="enter state" v-model=""></div>
                        <div class="col-md-12"><label class="labels">Area</label><input type="text" class="form-control"
                                placeholder="enter area" v-model=""></div> -->
                        <div class="col-md-12"><label class="labels">Email</label><input type="text" class="form-control"
                                placeholder="enter email id" v-model="email" :readonly="showsubmit"></div>
                    </div>
                    <button v-if="showsubmit"
                        class="mt-5 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded"
                        @click="editprofile()">
                        {{ edit }}
                    </button>
                    <button v-else
                        class="mt-5 bg-emerald-400 hover:bg-emerald-600 text-white font-bold py-2 px-4 border border-blue-700 rounded"
                        @click="submit()">
                        SAVE
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios';

export default {
    name: "ProfileUser",
    data() {
        return {
            img_user:"",
            name: "",
            surname: "",
            email: "",
            phonenumber: "",
            address: "",
            username: "",
            password: "",
            encodepassword:"",
            edit: "Edit Profile",
            showsubmit: true,
            file:null
        }
    },
    methods: {
        handleFileUpload() {
        this.file = this.$refs.file.files[0];
        },
        changepicture(){
            const formData = new FormData()
            formData.append("img", this.file);
            formData.append("id", this.$store.state.id);
            axios.put(`http://localhost:3000/changepicture`, formData, { headers: { 'Content-Type': 'multipart/form-data' } })
                .then((res) => {
                    this.img_user = res.data.c_image
                    this.$refs.file.value = null;
                    this.showchage = false
                })
                .catch((err) => { console.log(err) })
        },
        editprofile() {
            let person = prompt("Please enter your password:", "");
            if (person == this.password) {
                this.showsubmit = false
            }
            else if(person == "" || person == null){
                this.showsubmit = true
            }
            else {
                alert("password is invalid")
            }
        },
        submit() {
            const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!this.name) {
                alert('please fill firstname')
            }
            else if (!this.surname) {
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
                this.showsubmit = true
                const formData = new FormData()
                formData.append("id", this.$store.state.id)
                formData.append("fname", this.name)
                formData.append("lname", this.surname)
                formData.append("username", this.username)
                formData.append("password", this.password)
                formData.append("email", this.email)
                formData.append("address", this.address)
                formData.append("phonenumber", this.phonenumber)
                axios.put(`http://localhost:3000/EditProfile`, formData, { headers: { 'Content-Type': 'application/json' } })
                    .then((res) => {
                        this.encodepassword = this.password.substring(0, 3) + this.password.substring(3).replace(/./g, '*')
                        alert(res.data)
                    })
                    .catch((err) => { console.log(err) })
            }
        }
    },
    created() {
        axios.get(`http://localhost:3000/profile`, { params: { id: this.$store.state.id } })
            .then((res) => {
                this.img_user = res.data.c_image
                this.name = res.data.c_first_name
                this.surname = res.data.c_last_name
                this.email = res.data.c_email
                this.phonenumber = res.data.c_phone
                this.address = res.data.c_address
                this.username = res.data.c_username
                this.password = res.data.c_password
                this.data = res.data
                this.encodepassword = this.password.substring(0, 3) + this.password.substring(3).replace(/./g, '*')
            })
            .catch((err) => { console.log(err) })
    }
}
</script>