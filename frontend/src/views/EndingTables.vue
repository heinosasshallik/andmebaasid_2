<template>
  <div class="home">

    <h2 class="mt-2 mb-3">Lõpetatavad lauad</h2>

    <b-table class="ending-table"
             striped
             hover
             :items="this.tableData"
             :fields="this.fields">
      <template v-slot:cell(end)="data">
        <b-button size="sm" @click="confirmEndingTable(data.item.LauaKood)" class="mr-2 btn-danger">
          Lõpeta
        </b-button>
      </template>
    </b-table>

    <b-modal v-model="showModal"
             centered
             title="Kinnitus">
      <p class="my-4">Kas soovite lauda koodiga {{tableToEndCode}} lõpetada?</p>
      <template v-slot:modal-footer>
        <div class="w-100">
          <b-button variant="secondary"
                    class="float-right mr-2"
                    @click="cancelEndingTable()">
            Ei
          </b-button>
          <b-button variant="warning"
                    class="float-right mr-3"
                    @click="endTable()">
            Jah
          </b-button>
        </div>
      </template>
    </b-modal>

  </div>
</template>

<script lang="ts">
    import {Component, Vue} from 'vue-property-decorator';
    import {getRequest} from '@/requests';

    @Component
    export default class EndingTables extends Vue {
        private tableData: object[] = [];
        private fields: object[] = [
            {'LauaKood': 'Laua kood'},
            {'Kommentaar.String': 'Kommentaar'},
            {'Staatus': 'Seisund'},
            {'end': 'Lõpeta'},
        ];
        private showModal: boolean = false;
        private tableToEndCode: number = -1;

        private confirmEndingTable(tableCode: number): void {
            this.tableToEndCode = tableCode;
            this.showModal = true;
        }

        private cancelEndingTable(): void {
            this.tableToEndCode = -1;
            this.showModal = false;
        }

        private endTable(): void {
            this.showModal = false;
            // TODO: call method to end table
        }

        private mounted(): void {
            getRequest('/api/v1/table/endable')
                .then((response) => response.json())
                .then((data) => this.tableData = data);
        }
    }
</script>

<style scoped>
  .ending-table {
    margin: auto;
    width: 55% !important;
  }
</style>