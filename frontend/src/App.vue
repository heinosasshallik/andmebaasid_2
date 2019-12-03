<template>
  <div id="app">
    <div id="nav" v-if="this.$route.path !== '/'">
      <b-navbar toggleable="lg" type="dark" variant="dark">
        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav>
            <b-nav-item>
              <router-link to="/all_tables" class="text-black">Vaata kõiki laudu</router-link>
            </b-nav-item>
            <b-nav-item>
              <router-link to="/ending_tables" class="text-black">Lõpeta laud</router-link>
            </b-nav-item>
            <b-nav-item>
              <router-link to="/summary_report" class="text-black">Vaata laudade koondaruannet</router-link>
            </b-nav-item>
          </b-navbar-nav>

          <b-navbar-nav class="ml-auto">
            <b-nav-item>
              <a @click="logOut()" class="text-black">Logi välja</a>
            </b-nav-item>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
    </div>

    <div id="user-details"
         v-if="this.$route.path !== '/' && this.jwt"
         class="user-details text-right pr-4">
      <UserDetails></UserDetails>
    </div>

    <router-view/>
  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import UserDetails from "@/components/UserDetails.vue";

    @Component({
        components: {
            UserDetails
        }
    })
    export default class App extends Vue {
        private jwt:boolean = localStorage.getItem('JWT') !== null;

        private logOut(): void {
            localStorage.removeItem('JWT');
            this.$router.push('/');
        }
    }
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.text-black {
  color: #6e6e6e;
}

.user-details {
  height: 40px;
  width: 100%;
  background-color: #bbbbbb;
}
</style>
