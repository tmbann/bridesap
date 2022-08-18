import Vue from 'vue'
import Vuex from 'vuex'
import users from './modules/users'
import poses from './modules/poses'
import flash from './modules/flash'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    poses,
    flash
  }
})