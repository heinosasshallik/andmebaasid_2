<template>
  <div class="home">

    <b-table class="summary-table"
             striped
             hover
             :items="this.tableData">
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
                tableData: []
            };
        },
        methods: {
            loadData(): void {
                fetch(URL + '/api/v1/table/summary', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                })
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

<style>
  .summary-table {
    max-width: 500px;
    margin: auto;
    width: 50% !important;
  }
</style>