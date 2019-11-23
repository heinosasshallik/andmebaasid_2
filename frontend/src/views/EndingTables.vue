<template>
  <div class="home">

    <h2 class="mt-2 mb-3">Lõpetatavad lauad</h2>

    <b-table class="ending-table"
             striped
             hover
             :items="this.tableData"
             :fields="this.fields">
      <template v-slot:cell(end)="data">
        <b-button size="sm" @click="endTable(data.item.LauaKood)" class="mr-2 btn-danger">
          Lõpeta
        </b-button>
      </template>

    </b-table>

  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import {URL} from "@/constants"; // @ is an alias to /src

    @Component({
        components: {}
    })
    export default {
        data() {
            return {
                tableData: [],
                fields: [
                    {'LauaKood': 'Laua kood'},
                    {'Kommentaar.String': 'Kommentaar'},
                    {'Staatus': 'Seisund'},
                    {'end': 'Lõpeta'},
                ]
            };
        },
        methods: {
            loadData(): void {
                fetch(URL + '/api/v1/table/endable', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                })
                    .then(response => response.json())
                    .then(data => this.tableData = data)
            },
            endTable(tableCode: bigint): void {
                // TODO: confirmation modal + call method to end table
            }
        },
        beforeMount(): void {
            this.loadData();
        }
    }
</script>

<style scoped>
  .ending-table {
    margin: auto;
    width: 50% !important;
  }
</style>