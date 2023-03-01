import { createRouter, createWebHistory} from 'vue-router'
import Homepage from '../pages/Home.vue'
import Mangapage from '../pages/Manga.vue'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path:'/', name:"Home", component: Homepage },
        {path:'/Manga', name:"Manga", component: Mangapage }
    ]
})

export default router