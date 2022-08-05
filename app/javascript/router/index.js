import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'

import TopIndex from "../pages/top/index"
import RegisterIndex from "../pages/register/index"
import LoginIndex from "../pages/login/index"
import Mypage from "../pages/mypage/show"
import Pose from "../pages/pose/pose"
import PurePose from "../pages/pose/pure_pose"
import Result from "../pages/result/index"

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopIndex,
      name: "TopIndex",
    },
    {
      path: '/register',
      component: RegisterIndex,
      name: "RegisterIndex",
    },
    {
      path: '/login',
      component: LoginIndex,
      name: 'LoginIndex',
    },
    {
      path: '/mypage',
      component: Mypage,
      name: 'Mypage',
      meta: { requiredAuth: true }
    },
    {
      path: '/pure_poses',
      component: PurePose,
      name: 'PurePose'
    },
    {
      path: '/poses',
      component: Pose,
      name: 'Pose',
      meta: { requiredAuth: true }
    },
    {
      path: '/results',
      component: Result,
      name: 'Result',
      meta: { requiredAuth: true }
    }
  ],
})
  
router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser').then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser ) {
      next({ name: 'LoginIndex' });
    } else {
      next();
    }
  })
});
  
export default router