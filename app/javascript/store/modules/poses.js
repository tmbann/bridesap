import axios from "../../plugins/axios";

const state = {
  pose: []
}

const getters = {
  pose: state => state.pose
}

const mutations = {
  setPose: (state, pose) => {
    state.pose = pose
  }
}

const actions = {
  async createPose({ commit }, poseData) {
    const res = await axios.post('poses', poseData)
    commit('setPose', res.data) //res.data.result.score とかで取得できる
    console.log(res.data)
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};