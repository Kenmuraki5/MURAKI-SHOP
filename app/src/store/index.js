import { createStore } from 'vuex'
import router from '../router/index'
import axios from '@/plugins/axios'
const storagePlugin = store => {
  // Listen for changes to the local storage and update the store
  window.addEventListener('storage', event => {
    if (event.key === 'token') {
      const prevtoken = store.state.token
      store.commit('login', prevtoken)
    }
  })
}

export default createStore({
  state: {
    token: localStorage.getItem('token') || '',
    products: [],
    recommended: [],
    image:"",
   
  },
  mutations: {
    login(state, token) {
      const signedToken = token
      state.token = signedToken
      localStorage.setItem('token', signedToken)
    },
    logout(state) {
      state.token = ''
      state.image = ''
      localStorage.removeItem('token')
      if(router.currentRoute.value.name == "ProfilePage" || router.currentRoute.value.name == "OrderDetail")
        router.push("/")
    },
    getprofileuser(state){
      axios.get(`http://34.16.145.46/api/user/me`)
      .then((res) => {
        state.image = res.data.c_image || res.data.a_image
      }).catch((err) => {
        console.log(err)
        this.commit('logout')
      })
    }
  },
  actions: {},
  plugins: [storagePlugin],
  modules: {}
})