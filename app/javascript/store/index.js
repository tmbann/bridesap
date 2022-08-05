import Vue from 'vue'
import Vuex from 'vuex'
import users from './modules/users'
import poses from './modules/poses'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    poses
  }
})