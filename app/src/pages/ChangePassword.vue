<template>
    <div class="h-screen bg-white flex flex-col space-y-10 justify-center items-center">
        <div class="bg-white w-96 shadow-xl rounded p-5">
            <h1 class="text-3xl font-medium">CHANGE PASSWORD</h1>

            <form class="space-y-5 mt-5">
                <input type="text" class="w-full h-12 border border-gray-800 rounded px-3" placeholder="Password" v-model="conpassword"/>
                <div class="w-full flex items-center border border-gray-800 rounded px-3">
                    <input type="password" class="w-4/5 h-12" placeholder="Confirm Password" v-model="password" />
                </div>
                <button class="text-center w-full bg-blue-900 rounded-md text-white py-3 font-medium" @click="changePassword()">Change Password</button>
            </form>
        </div>
    </div>
</template>
<script>
import axios from 'axios';
export default{
    name: 'ChangePassword',
    data(){
        return{
            password:"",
            conpassword:""
        }
    },
    methods:{
        changePassword(){
            if(this.password == this.conpassword){
              axios.put(`http://localhost:3000/ResetPassword/${this.$route.params.token}`, {password:this.password})
            .then(res => alert(res.data), this.$router.push("/LoginPage"))
            .catch(err => alert(err.response.data))  
            }
            else{
                alert("password and confirm password is not the same")
            }
            
        }
    }
}
</script>