<template>
  <div>
    <div v-if="!success">
    <InfoText/>
    <md-card>
      <md-card-content>
        <div class="center">
          <div class="md-field md-theme-demo-light md-has-textarea">
    <md-field>
      <label>Click and then type-in your report here ...</label>
      <md-textarea v-model="textReport" id="report-text" ref="testReport"></md-textarea>
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
          <md-button class="md-raised md-accent full-width bcolor-red" v-on:click="onSubmit">Send Your Report</md-button>
        </div>
      </md-card-content>
    </md-card>
    </div>
    <div v-if="success">
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
  import walletFactory from "@/util/WalletFactory";

  export default {
    name: 'new-report',
    data() {
      return {
        isExistingWallet: false,
        isLoading: false,
        wallet: null,
        isSubmitted: false,
        success: false,
        textReport: ""
      };
    },
    components: {
      InfoText,
      FileUploadz
    },
     methods: {
       onAccountLoad (err, result) {
         // store result
         console.log("Contract result: ",result," ERR:", err);
         this.isExistingWallet = result === null;
         this.wallet = result;

         // TODO: just save wallet id
         this.$store.dispatch('setContractInstance', result);

         // if submission is requested, submit user inputs
         if (this.isSubmitted) {
           this.packageSend()
         }
         this.isLoading = false;
       },
        onSubmit(){
          // no double takes & description required
          var description = this.$refs.testReport.value;
          if (this.isEmpty(description) || this.isSubmitted) {
            return;
          }

          // state flag used on wallet load
          this.isSubmitted = true;

          // if wallet is available, trigger mail now!
          if (this.isLoading || this.wallet == null) {
            console.log("Wallet not yet loaded. Please wait...");
          } else {
            this.sendMessage();
          }
        },
        sendMessage() {
          console.log("sendMessage");
          // retrieve user input
          var text = this.$refs.testReport.value; //TODO: get text & objuscate
          var attachment = this.getAttachmentHash(); //TODO: get attachment hash

          // send to blockchain
          walletFactory.addMessage(this.wallet, text, attachment, function(err, result) {
            console.log(result, err);
            if (result) {
              this.isSubmitted = false;
              success = true;
            }
          })
        },
        getAttachmentHash() {
          return 1;
        },
        isEmpty(str) {
            return (!str || 0 === str.length);
        }
    },

    mounted () {
      console.log('New Report Mounted... Attempting to retrieve wallet');

      // no double takes here either
      if (this.isLoading) {
        return
      }
      this.isLoading = true;

      // if account num is stored, load existing wallet, else create new
      var accountNum = this.$store.state.contractId;
      if (accountNum) {
        walletFactory.getExistingWallet(accountNum, this.onAccountLoad);
        this.isExistingWallet = true;
      } else {
        walletFactory.createWallet(this.onAccountLoad);
        this.isExistingWallet = false;
      }
    }
  }
</script>

<style>
  .vertical-padding{
    padding: 3% 0;
  }
</style>
