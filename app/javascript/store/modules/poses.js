import axios from "../../plugins/axios";

const state = {
  pose: [],
  purePose: [],
  bestPose: []
}

const getters = {
  pose: state => state.pose,
  purePose: state => state.purePose,
  bestPose: state => state.bestPose
}

const mutations = {
  setPose: (state, pose) => {
    state.pose = pose
  },
  setPurePose: (state, purePose) => {
    state.purePose = purePose
  },
  setBestPose: (state, bestPose) => {
    state.bestPose = bestPose
  }
}

const actions = {
  async createPose({ commit }, poseData) {
    const res = await axios.post('poses', poseData)
    commit('setPose', res.data)
    console.log(res.data)
  },
  fetchPurePose({ commit }) {
    axios.get('pure_poses')
      .then(res => { commit('setPurePose', res.data) })
      .catch(err => console.log(err.response));
  },
  fetchBestPose({ commit }) {
    axios.get('poses')
      .then(res => { commit('setBestPose', res.data) })
      .catch(err => console.log(err.response))
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};