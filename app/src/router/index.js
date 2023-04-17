import { createRouter, createWebHistory} from 'vue-router'
import HomePage from '../pages/Home.vue'
import AllBook from '../pages/AllBook.vue'
import MangaPage from '../pages/Manga.vue'
import NovelPage from '../pages/Novel.vue'
import LoginPage from '../pages/LoginPage.vue'
import RegisterPage from '../pages/RegisterPage.vue'
import CheckOutPage from '../pages/CheckOut.vue'
import AdminPage from '../pages/AdminPage.vue'
import DetailPage from '../pages/DetailPage.vue'
import ProfilePage from '../pages/ProfilePage.vue'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path:'/', name:"HomePage", component: HomePage },
        {path:'/AllBook', name:"AllBookPage", component: AllBook },
        {path:'/Manga', name:"MangaPage", component: MangaPage },
        {path:'/Novel', name:"NovelPage", component: NovelPage },
        {path:'/LoginPage', name:"LoginPage", component: LoginPage },
        {path:'/RegisterPage', name:"RegisterPage", component: RegisterPage },
        {path:'/CheckOut', name:"CheckOutPage", component: CheckOutPage },
        {path:'/AdminPage', name:"AdminPage", component: AdminPage },
        {path:'/DetailPage/:id', name:"DetailPage", component: DetailPage },
        {path:'/ProfilePage', name:"ProfilePage", component: ProfilePage }
    ]
})

export default router