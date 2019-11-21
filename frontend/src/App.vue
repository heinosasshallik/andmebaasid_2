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
              <router-link to="/" class="text-black">Logi välja</router-link>
            </b-nav-item>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>

    </div>
    <router-view/>
  </div>
</template>

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
</style>
