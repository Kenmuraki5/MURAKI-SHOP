import { createRouter, createWebHistory} from 'vue-router'
import Homepage from '../pages/Home.vue'
import AllBook from '../pages/AllBook.vue'
import Mangapage from '../pages/Manga.vue'
import Novelpage from '../pages/Novel.vue'
import Loginpage from '../pages/LoginPage.vue'
import Registerpage from '../pages/RegisterPage.vue'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path:'/', name:"Home", component: Homepage },
        {path:'/AllBook', name:"AllBook", component: AllBook },
        {path:'/Manga', name:"Manga", component: Mangapage },
        {path:'/Novel', name:"Novel", component: Novelpage },
        {path:'/LoginPage', name:"Login", component: Loginpage },
        {path:'/RegisterPage', name:"Register", component: Registerpage }
    ]
})

export default router