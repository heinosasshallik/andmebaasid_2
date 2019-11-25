<template>
  <b-row class="mb-1">
    <b-col cols="4" class="text-right pt-2">{{labelData}}</b-col>
    <b-col cols="8" class="text-left">
      <b-form-input v-if="!longDescription" v-model="descriptionData" :readonly=true>
      </b-form-input>
      <b-form-textarea v-if="longDescription" v-model="descriptionData" :readonly=true>
      </b-form-textarea>
    </b-col>
  </b-row>
</template>

<script lang="ts">
    import {Component, Prop, Vue} from 'vue-property-decorator';

    @Component
    export default class DetailViewRow extends Vue {
        @Prop() labelData!: string;
        @Prop() descriptionData!: string;
        @Prop() longDescription!: boolean;
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
