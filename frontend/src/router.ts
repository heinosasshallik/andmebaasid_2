import Vue from 'vue';
import Router from 'vue-router';
import Login from './views/Login.vue';
// @ts-ignore
import jwt_decode from 'jwt-decode';
import AllTables from './views/AllTables.vue';
import SummaryReport from "@/views/SummaryReport.vue";
import EndingTables from "@/views/EndingTables.vue";
import TableDetails from "@/views/TableDetails.vue";

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
    {
      path: '/table_details/:tableId',
      name: 'table_details',
      component: TableDetails,
    },
  ],
});

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/'];
  const authRequired = !publicPages.includes(to.path);
  const jwt = localStorage.getItem('JWT');

  if (authRequired && !isValidAuthorization(jwt)) {
    removeJwtIfExists(jwt);
    return next('/');
  }

  next();
});

function isValidAuthorization(jwt: any): boolean {
  return jwt && (Date.now() < jwt_decode(jwt).exp * 1000);
}

function removeJwtIfExists(jwt: any): void {
  if (jwt) {
    localStorage.removeItem('JWT');
  }
}

export default router;
