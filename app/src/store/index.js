import { createStore } from 'vuex'
import router from '../router/index'

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
    setPrevId(state, token) {
      state.prevtoken = token
    }
  },
  actions: {},
  plugins: [storagePlugin],
  modules: {}
})