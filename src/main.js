import { createApp } from 'vue'
import { createRouter, createWebHistory} from 'vue-router'
import App from './App.vue'
import './assets/tailwind.css' 

import Homepage from './pages/Home.vue'
import Mangapage from './pages/Manga.vue'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path:'/', name:"Home", component: Homepage },
        {path:'/Manga', name:"Manga", component: Mangapage }
    ]
})
createApp(App).use(router).mount('#app')
