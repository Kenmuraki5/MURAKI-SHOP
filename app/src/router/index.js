import { createRouter, createWebHistory} from 'vue-router'
import HomePage from '../pages/Home.vue'
import AllBook from '../pages/AllBook.vue'
import MangaPage from '../pages/Manga.vue'
import NovelPage from '../pages/Novel.vue'
import LoginPage from '../pages/LoginPage.vue'
import RegisterPage from '../pages/RegisterPage.vue'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path:'/', name:"HomePage", component: HomePage },
        {path:'/AllBook', name:"AllBookPage", component: AllBook },
        {path:'/Manga', name:"MangaPage", component: MangaPage },
        {path:'/Novel', name:"NovelPage", component: NovelPage },
        {path:'/LoginPage', name:"LoginPage", component: LoginPage },
        {path:'/RegisterPage', name:"RegisterPage", component: RegisterPage }
    ]
})

export default router