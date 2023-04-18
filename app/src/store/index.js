import { createStore } from 'vuex'
import router from '../router/index'

const storagePlugin = store => {
  // Listen for changes to the local storage and update the store
  window.addEventListener('storage', event => {
    if (event.key === 'id') {
      const prevId = store.state.id
      store.commit('login',prevId)
    }
  })
}

export default createStore({
  state: {
    id: localStorage.getItem('id') || '',
    user: localStorage.getItem('user') || '',
    prevId: '' // New state property to store the previous id value
  },
  mutations: {
    login(state, id) {
      state.id = id[0]
      state.user = id[1]
      localStorage.setItem('id', id[0])
      localStorage.setItem('user', id[1])
    },
    logout(state) {
      state.id = ''
      state.user = ''
      localStorage.removeItem('id')
      localStorage.removeItem('user')
      if(router.currentRoute.value.name == "ProfilePage")
        router.push("/")
    },
    setPrevId(state, id) {
      state.prevId = id
    }
  },
  actions: {},
  plugins: [storagePlugin],
  modules: {}
})