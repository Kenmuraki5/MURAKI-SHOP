<template>
    <MainNavbar></MainNavbar>
    <ProfileUser></ProfileUser>
    <MainFooter></MainFooter>
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import MainFooter from '../components/MainFooter.vue'
import ProfileUser from '../components/ProfileUser.vue'
export default {
    name: 'ProfilePage',
    components: {
    MainNavbar,
    MainFooter,
    ProfileUser
},
    data() {
        return {

        }
    },
    mounted(){
        if(!this.$store.state.token){
            this.$router.push("/")
        }
    }
}
</script>