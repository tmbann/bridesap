import axios from "../../plugins/axios";

const state = {
  authUser: null,
  user: []
}

const getters = {
  authUser: state => state.authUser,
  user: state => state.user
}

const mutations = {
  setAuthUser: (state, authUser) => {
    state.authUser = authUser
  },
  setUser: (state, user) => {
    state.user = user
  },
  updateUser: (state, user) => {
    state.user = user
  }
};

const actions = {
  async loginUser({ commit }, user) {
    const sessionsResponse = await axios.post('sessions', user)
    localStorage.auth_token = sessionsResponse.data.token
    axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
    
    const userResponse = await axios.get('users/me')
    commit('setAuthUser', userResponse.data)
  },
  logoutUser({ commit }) {
    localStorage.removeItem('auth_token')
    axios.defaults.headers.common['Authorization'] = ''
    commit("setAuthUser", null);
  },
  async fetchAuthUser({ commit, state }) {
    if (!localStorage.auth_token) return null
    if (state.authUser) return state.authUser
    
    const userResponse = await axios.get('users/me')
      .catch((err) => {
        return null
      })
    if (!userResponse) return null

    const authUser = userResponse.data
    if (authUser) {
      commit('setAuthUser', authUser)
      return authUser
    } else {
      commit('setAuthUser', null)
      return null
    }
  },
  fetchUser({ commit }) {
    axios.get('mypage')
      .then(res => { commit('setUser', res.data) })
      .catch(err => console.log(err.response));
  },
  async updateUser({ commit }, user) {
    const res = await axios.patch('mypage', {user})
    commit('updateUser', res.data)
  }
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};