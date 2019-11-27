<template>
  <div>
    <b-container fluid>
      <b-row class="my-1 justify-content-center">
        <b-col md="12" lg="12" xl="12">
          <h3 class="my-4">Lauatennise laudade arvestuse infosüsteem</h3><br/>
        </b-col>

        <b-col md="8" lg="6" xl="5">

          <b-form @submit="onSubmit" @reset="onReset">
            <b-form-group
                id="email-input-group"
                label="E-meil:"
                label-for="email-input">
              <b-form-input
                  id="email-input"
                  v-model="email"
                  required
                  placeholder="Sisesta e-meil">
              </b-form-input>
            </b-form-group>

            <b-form-group id="password-input-group" label="Salasõna:" label-for="password-input">
              <b-form-input
                  id="password-input"
                  v-model="password"
                  type="password"
                  required
                  placeholder="Sisesta salasõna">
              </b-form-input>
            </b-form-group>

            <b-button type="submit" variant="primary">Log In</b-button>
          </b-form>

        </b-col>
      </b-row>
    </b-container>

  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import { putRequest } from '@/requests';

    @Component
    export default class Login extends Vue {
        private email: string = '';
        private password: string = '';

        onSubmit(event: Event): void {
            event.preventDefault();
            alert(JSON.stringify({emeil: this.email, parool: this.password}));
            // putRequest(`/api/v1/login`, {emeil: this.email, parool: this.password}); // todo
            if (true) { // todo: check response and enter here if auth successful
                this.$router.push({path: 'all_tables'});
            } else {
                console.log('whoopsie'); // todo: error handling or smth
            }
        }

        onReset(event: Event): void {
            event.preventDefault();
            this.email = '';
            this.password = '';
        }

    }
</script>