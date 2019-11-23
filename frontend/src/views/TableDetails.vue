<template>
  <div class="home">

    <h2 class="mt-2 mb-3">Laua detailid</h2>

    <b-container class="bv-example-row" v-if="tableData !== undefined">

<!--      <DetailViewRow v-for="(descriptionData, labelData) in tableData[0]"-->
<!--                     :labelData="labelData"-->
<!--                     :descriptionData="descriptionData"/>-->

      <DetailViewRow :labelData="'Laua kood'"
                     :descriptionData="this.tableData.LauaKood"/>
      <DetailViewRow :labelData="'Laua võrgu kõrgus (mm)'"
                     :descriptionData="this.tableData.LauaVorguKorgus"/>
      <DetailViewRow :labelData="'Maksimaalne mängijate arv'"
                     :descriptionData="this.tableData.MaxMangijateArv"/>
      <DetailViewRow :labelData="'Registreerimise aeg'"
                     :descriptionData="this.tableData.RegAeg"/>
      <DetailViewRow :labelData="'Kommentaar'"
                     :descriptionData="this.tableData.Kommentaar.String"
                     :longDescription="true"/>
      <DetailViewRow :labelData="'Seisund'"
                     :descriptionData="this.tableData.Staatus"/>
      <DetailViewRow :labelData="'Bränd'"
                     :descriptionData="this.tableData.Brand"/>
      <DetailViewRow :labelData="'Registreerija nimi'"
                     :descriptionData="this.tableData.IsikuNimi"/>
      <DetailViewRow :labelData="'Registreerija e-meil'"
                     :descriptionData="this.tableData.IsikuEmail"/>

      <b-row class="mb-1" v-if="categoriesData !== undefined" v-for="(category, i) in categoriesData">
        <b-col v-if="i === 0" cols="4" class="text-right pt-2">Laua kategooriad</b-col>
        <b-col v-if="i !== 0" cols="4" class="text-right"></b-col>
        <b-col cols="8" class="text-left">
          <b-form-input v-model="category.Kategooria" :readonly=true>
          </b-form-input>
        </b-col>
      </b-row>
    </b-container>

  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import DetailViewRow from "@/components/DetailViewRow.vue"; // @ is an alias to /src
    import getRequest from '@/requests';

    @Component({
        components: {
            DetailViewRow
        }
    })
    export default {
        components: {DetailViewRow},
        data() {
            return {
                tableData: undefined,
                categoriesData: undefined
            };
        },
        methods: {
            loadData(): void {
                getRequest('/api/v1/table/details') // todo add /this.$route.query.page
                    .then(response => response.json())
                    .then(data => this.tableData = data[0]);
                getRequest('/api/v1/table/categories') // todo add /this.$route.query.page
                    .then(response => response.json())
                    .then(data => this.categoriesData = data);
            },
        },
        beforeMount(): void {
            this.loadData();
        }
    }
</script>

<style scoped>
</style>
