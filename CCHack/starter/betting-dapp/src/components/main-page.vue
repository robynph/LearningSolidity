<template>
  <div>
    <InfoText/>

    <md-card>
      <md-card-content>
      <div class="center">
        <div>
          <span class="md-display-1">What would you like to do ?</span>
        </div>
        <div>
          <div class="block">
          <router-link :to="'new'"><md-button>File New Report</md-button></router-link>
          <router-link :to="'update'"><md-button>Update Existing Report</md-button></router-link>
         </div>
        </div>

      </div>
      </md-card-content>
    </md-card>

    <Search/>

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
    },
    methods: {
    }
  }
</script>
