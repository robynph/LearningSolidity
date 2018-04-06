import Vue from 'vue'
import Router from 'vue-router'
import StarterDapp from '@/components/starter-dapp'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'starter-dapp',
      component: StarterDapp
    }
  ]
})
