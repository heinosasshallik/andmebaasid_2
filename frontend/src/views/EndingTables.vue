<template>
  <div class="home">

    <b-table class="ending-table"
             striped
             hover
             :items="this.tableData"
             :fields="this.fields">
      <template v-slot:cell(end_table)="row">
        <b-button size="sm" @click="row.toggleDetails" class="mr-2 btn-danger">
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
                fields: ['LauaKood', 'Kommentaar.String', 'Staatus', 'end_table']
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
        },
        beforeMount(): void {
            this.loadData();
        }
    }
</script>

<style>
  .ending-table {
    margin: auto;
    width: 60% !important;
  }
</style>