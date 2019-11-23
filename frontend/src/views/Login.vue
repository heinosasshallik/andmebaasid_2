<template>
  <div>
    <b-container fluid>
      <b-row class="my-1 justify-content-center" >
        <b-col md="8" lg="6" xl="5">

          <b-form @submit="onSubmit" @reset="onReset">
            <b-form-group
                id="email-input-group"
                label="E-mail:"
                label-for="email-input">
              <b-form-input
                  id="email-input"
                  v-model="form.email"
                  type="username"
                  required
                  placeholder="Sisesta e-mail">
              </b-form-input>
            </b-form-group>

            <b-form-group id="password-input-group" label="Salasõna:" label-for="password-input">
              <b-form-input
                  id="password-input"
                  v-model="form.password"
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

<script>
  //todo: hmm, typescript?
    export default {
        data() {
            return {
                form: {
                    email: '',
                    password: '',
                },
            };
        },
        methods: {
            onSubmit(evt) {
                evt.preventDefault();
                // todo: if backend has endpoint ready, send it there
                //alert(JSON.stringify(this.form));
                if (true) { // todo: check response and enter here if auth successful
                    this.$router.push({ path: 'all_tables'});
                } else {
                    console.log('whoopsie'); // todo: error handling or smth
                }
            },
            onReset(evt) {
                evt.preventDefault();
                this.form.email = '';
                this.form.password = '';
            },
        },
    };
</script>