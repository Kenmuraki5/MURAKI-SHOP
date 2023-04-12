import { createStore } from 'vuex'

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
    prevId: '' // New state property to store the previous id value
  },
  mutations: {
    login(state, id) {
      state.id = id
      localStorage.setItem('id', id)
    },
    logout(state) {
      state.id = ''
      localStorage.removeItem('id')
    },
    setPrevId(state, id) {
      state.prevId = id
    }
  },
  actions: {},
  plugins: [storagePlugin],
  modules: {}
})