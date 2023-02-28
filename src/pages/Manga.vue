<template>
    <MainNavbar/>
    <MainitemList/>
</template>
<script>
import MainNavbar from '../components/Navbar.vue'
import MainitemList from '../components/MainitemList.vue'
export default {
    name: 'HomePages',
    components: {
        MainitemList,
        MainNavbar,
    },
}
</script>
