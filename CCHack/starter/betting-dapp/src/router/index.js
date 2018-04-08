import Vue from 'vue'
import Router from 'vue-router'
import StarterDapp from '@/components/starter-dapp'
import NewReport from '@/components/new-report'
import MainPage from '@/components/main-page'
import UpdateReport from '@/components/update-report'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'main-page',
      component: MainPage
    },
    {
      path: '/new',
      name: 'new-report',
      component: NewReport

    },
    {
      path: '/view',
      name: 'view',
      component: StarterDapp

    },
    {
      path: '/update',
      name: 'update-report',
      component: UpdateReport

    }
  ]
})
