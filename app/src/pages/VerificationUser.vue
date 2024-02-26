<template>
    <section class="min-h-screen flex flex-col">
        <nav>
            <div class="px-4 py-8 text-center text-2xl">
                <h3>MURAKICOMIC</h3>
            </div>
        </nav>
        <div class="max-w-lg mx-auto my-10 bg-white p-8 rounded-xl shadow shadow-slate-300">
            <h1 class="text-4xl font-medium">Reset password</h1>
            <p class="text-slate-500">Fill up the form to reset the password</p>
                <div class="flex flex-col space-y-5">
                    <label for="email">
                        <p class="font-medium text-slate-700 pb-2">Email address</p>
                        <input id="email" name="email" type="email"
                            class="w-full py-3 border border-slate-200 rounded-lg px-3 focus:outline-none focus:border-slate-500 hover:shadow"
                            placeholder="Enter email address" v-model="email">
                    </label>
                    <span v-if="show == 'A link to change the password has been sent to your email.'" 
                    class="text-green-400">{{show}}</span>
                    <span v-else class="text-rose-500">{{show}}</span>
                    <button @click="sendmail()"
                        class="w-full py-3 font-medium text-white bg-indigo-600 hover:bg-indigo-500 rounded-lg border-indigo-500 hover:shadow inline-flex space-x-2 items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z" />
                        </svg>
                        <span>Reset password</span>
                    </button>
                    <p class="text-center">Not registered yet? <RouterLink to="/RegisterPage"
                            class="text-indigo-600 font-medium inline-flex space-x-1 items-center"><span>Register now
                            </span><span><svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                                </svg></span></RouterLink>
                    </p>
                </div>
        </div>
    </section>
</template>
<script>
import axios from 'axios';

    export default{
        data(){
            return {
                email:'',
                show:"",
            }
        },
        methods:{
            sendmail(){
                this.show = "wait 1 minute";
                axios.post("http://localhost/api/verification", {email:this.email})
                .then((res) => {
                    alert(res.data)
                    this.show = "A link to change the password has been sent to your email."
                })
                .catch((err) => {
                    alert(err.response.data)
                    this.show = err.response.data
                })
            }
        }
    }
</script>