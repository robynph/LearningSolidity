<template>
  <div>
    <InfoText/>

    <Search/>

    <md-card>
      <md-card-content>
      <div class="center">
        <div>
          <span class="md-display-1">What would you like to do ?</span>
        </div>
        <div>
          <div class="block">
          <md-button v-on:click="createContract"> <router-link :to="'new'">File New Report</router-link></md-button>
          <md-button v-on:click="getExistingContract"><router-link :to="'update'">Update Existing Report</router-link></md-button>
         </div>
        </div>

      </div>
      </md-card-content>
    </md-card>

  </div>
</template>

<script>
  import InfoText from "@/components/InfoText";
  import Search from "@/components/Search";
  import Contract from "@/util/Contract";

  export default {
    name: 'main-page',

    components: {
      InfoText,
      Search
    },
    methods: {
      createContract (event) {
        this.getExistingContract(event);
        // console.log("Try to create!");
        // Contract.createContract(function(err, result) {
        //   console.log(result);
        //   this.$store.state.contractInstance() = result;
        // })
      },
      getExistingContract (event) {
        console.log("Getting existing");
        var that = this;
        Contract.getExistingContract(Contract.existingContractId, function(err, result) {
          console.log(result);
          that.storeContract(result);
        });
      },
      storeContract(contract) {
        this.$store.dispatch('setContractInstance', contract);
      }
    }
  }
</script>
