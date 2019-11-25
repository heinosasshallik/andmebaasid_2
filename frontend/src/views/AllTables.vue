<template>
  <div class="home">

    <h2 class="mt-2 mb-3">Kõik lauad</h2>

    <b-table class="all-table"
             striped
             hover
             :items="this.tableData"
             :fields="this.fields">
      <template v-slot:cell(details)="data">
        <b-button size="sm" @click="goToDetails(data.item.LauaKood)" class="mr-2 btn-success">
          Detailid
        </b-button>
      </template>
    </b-table>

  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import router from '@/router';
    import {getRequest} from '@/requests';

    @Component
    export default class AllTables extends Vue {
        private tableData: object[] = [];
        private fields: object[] = [
            {'LauaKood': 'Laua kood'},
            {'Kommentaar.String': 'Kommentaar'},
            {'Staatus': 'Seisund'},
            {'details': 'Detailid'},
        ];

        private mounted(): void {
            getRequest('/api/v1/table/all')
                .then((response) => response.json())
                .then((data) => this.tableData = data);
        }

        private goToDetails(tableId: number): void {
            router.push('/table_details/' + tableId.toString());
        }
    }
</script>

<style scoped>
  .all-table {
    margin: auto;
    width: 55% !important;
  }
</style>