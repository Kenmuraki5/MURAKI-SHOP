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
import OrderDetail from '../pages/OrderDetail.vue'
import ResetPassword from '../pages/ResetPassword.vue'
import ChangePassword from '../pages/ChangePassword.vue'
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
        {path:'/ProfilePage', name:"ProfilePage", component: ProfilePage },
        {path:'/OrderDetail', name:"OrderDetail", component: OrderDetail },
        {path:'/ResetPassword', name:"ResetPassword", component: ResetPassword },
        {path:'/ResetPassword/:token', name:"ChangePassword", component: ChangePassword },
    ]
})
router.beforeEach((to, from, next) => {
  const isLoggedIn = localStorage.getItem('token')


  if ((to.name == "LoginPage" || to.name == "ChangePassword") && isLoggedIn) {
    alert("You've already logged in")
    next({ path: '/' })
  }
  if ((to.name == "OrderDetail" || to.name == "AdminPage" || to.name == "ProfilePage") && !isLoggedIn) {
    alert("You are not logged in")
    next({ path: '/' })
  }
  next()
})
export default router