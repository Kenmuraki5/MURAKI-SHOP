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
    image:"",
    prevtoken: '' // New state property to store the previous id value
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
      if(router.currentRoute.value.name == "ProfilePage")
        router.push("/")
    },
    getprofileuser(state){
      axios.get(`http://localhost:3000/user/me`)
      .then((res) => {
        state.image = res.data.c_image || res.data.a_image
      }).catch((err) => console.log(err))
    },
    setPrevId(state, token) {
      state.prevtoken = token
    }
  },
  actions: {},
  plugins: [storagePlugin],
  modules: {}
})