import { createApp } from 'vue'
import App from './App.vue'
import './assets/tailwind.css'
import router from './router/index.js'
import store from './store'

createApp(App).use(store).use(router).mount('#app')
