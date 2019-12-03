<template>
  <p class="pt-2" v-if="userData.Nimi">
    Nimi: {{userData.Nimi.String}}<span class="pl-4">Amet: {{userData.TootajaInfo.Ametid[0].Amet}}</span>
  </p>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import {getRequest} from "@/requests"

    @Component
    export default class UserDetails extends Vue {
        private userData: object = {};

        private mounted(): void {
            getRequest(`/api/v1/user/me`)
                .then((response) => response.json())
                .then((data) => this.userData = data);
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
