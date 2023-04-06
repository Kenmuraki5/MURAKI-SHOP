import { createRouter, createWebHistory} from 'vue-router'
import Homepage from '../pages/Home.vue'
import AllBook from '../pages/AllBook.vue'
import Mangapage from '../pages/Manga.vue'
import Novelpage from '../pages/Novel.vue'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path:'/', name:"Home", component: Homepage },
        {path:'/AllBook', name:"AllBook", component: AllBook },
        {path:'/Manga', name:"Manga", component: Mangapage },
        {path:'/Novel', name:"Novel", component: Novelpage }
    ]
})

export default router