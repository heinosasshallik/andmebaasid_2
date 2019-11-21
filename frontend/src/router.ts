import Vue from 'vue';
import Router from 'vue-router';
import Login from './views/Login.vue';
import AllTables from './views/AllTables.vue';
import SummaryReport from "@/views/SummaryReport.vue";
import EndingTables from "@/views/EndingTables.vue";

Vue.use(Router);

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      component: Login,
    },
    {
      path: '/all_tables',
      name: 'all_tables',
      component: AllTables,
    },
    {
      path: '/summary_report',
      name: 'summary_report',
      component: SummaryReport,
    },
    {
      path: '/ending_tables',
      name: 'ending_tables',
      component: EndingTables,
    },
  ],
});

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('db-2-jwt');

  // todo uncomment
  // if (authRequired && !loggedIn) {
  //   return next('/');
  // }

  next();
});

export default router;

// https://jasonwatmore.com/post/2018/07/14/vue-vuex-user-registration-and-login-tutorial-example
