<template>
  <div class="home">

    <h2 class="mt-2 mb-3">Laudade koondaruanne</h2>

    <b-table class="summary-table"
             striped
             hover
             :items="this.tableData"
             :fields="this.fields">
    </b-table>

  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import getRequest from "@/requests"; // @ is an alias to /src

    @Component({
        components: {}
    })
    export default {
        data() {
            return {
                tableData: [],
                fields: [
                    {'LauaSeisundiLiikKood': 'Kood'},
                    {'Staatus': 'Seisund'},
                    {'Kogus': 'Kogus'},
                ]
            };
        },
        methods: {
            loadData(): void {
                getRequest('/api/v1/table/summary')
                    .then(response => response.json())
                    .then(data =>
                        this.tableData = data
                    )
            },
        },
        beforeMount(): void {
            this.loadData();
        }
    }
</script>

<style scoped>
  .summary-table {
    margin: auto;
    width: 40% !important;
  }
</style>