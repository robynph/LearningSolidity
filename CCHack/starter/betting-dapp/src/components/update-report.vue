<template>
	<div>
		<md-card v-if="!isID">
      		<md-card-content>
      		<div class="">
      			<input id="txtName"  v-model="txtInput" ref="txtInput" type="text" placeholder="type in your ID"></input>
				<div>
			        <md-button class="md-raised md-accent full-width bcolor-red" v-on:click="saveID">
			          <md-icon>arrow_forward</md-icon>
					</md-button>
        		</div>
      		</div>
      		</md-card-content>
      	</md-card>

<md-card v-if="isID">
      <md-card-content>
        <div class="center">
          <div class="md-field md-theme-demo-light md-has-textarea">
    <form >
      <label>Click and then type-in your report here ...</label>
      <input id="txtReport"  v-model="txtReport" type="textfield" placeholder="type in your ID"></input>

      <div>
          <md-button class="md-raised md-accent full-width bcolor-red" v-on:click="searchForWallet()">Send Your Report</md-button>
        </div>
    </form>
  </div>
        </div>
      </md-card-content>
    </md-card>


	</div>
</template>

<script>
	export default {
	    name: 'UpdateReport',
	    data () { return {
	    	txtInput: '',
	    	isID: false,
	    	txtReport: ''
	    }
		},
		methods: {
		    saveID(){
		      this.isID = true
		    },
		    searchForWallet(){
					if (this.isEmpty(input)) {
						this.showError()
					} else {
						walletFactory.getExistingWallet(input, function(err, result) {
							if (result == null) {
								this.showError()
							} else {
								this.$store.dispatch('setContractInstance', input);
							}
						})
					}
				}
		}


	}
</script>
<style>
	#txtReport{
		min-height:200px;
		width: 100%;
	}
</style>
