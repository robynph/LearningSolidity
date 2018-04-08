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
          <md-button> <router-link :to="'new'">File New Report</router-link></md-button>
          <md-button><router-link :to="'update'">Update Existing Report</router-link></md-button>
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
  
  export default {
    name: 'main-page',

    components: {
      InfoText,
      Search
    }
  }
</script>

