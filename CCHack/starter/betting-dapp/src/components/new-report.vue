<template>
  <div>
    <div v-if="!isSubmitted">
    <InfoText/>
    <md-card>
      <md-card-content>
        <div class="center">
          <div class="md-field md-theme-demo-light md-has-textarea">
    <md-field>
      <label>Click and then type-in your report here ...</label>
      <md-textarea v-model="textarea" id="report-text"></md-textarea>
    </md-field>
  </div>
        </div>
      </md-card-content>
    </md-card>
    <md-card>
      <md-card-content>
        <div>
          <div class="center">
          <span class="md-subheading md-gutter vertical-padding">You can submit 1 supporting document along with your report. </span>
          </div>
          <FileUploadz/>
        </div>
      </md-card-content>
    </md-card>
    <md-card>
      <md-card-content>
        <div>
          <md-button class="md-raised md-accent full-width bcolor-red" v-on:click="packageSend">Send Your Report</md-button>
        </div>
      </md-card-content>
    </md-card>
    </div>
    <div v-if="isSubmitted">
      <md-card>
        <md-card-content>
          <div>
          </div>
        </md-card-content>
      </md-card>
    </div>
  </div>
  
</template>

<script>
  import InfoText from "@/components/InfoText";
  import FileUploadz from "@/components/FileUploadz";
  
  export default {
    name: 'new-report',
    data() {
      return {
        isSubmitted: false
      };
    },
    components: {
      InfoText,
      FileUploadz
    },
     methods: {
        packageSend(){ 

          //when successful
            this.isSubmitted = true
        }
    }

  }
</script>

<style>
  .vertical-padding{
    padding: 3% 0;
  }
</style>
