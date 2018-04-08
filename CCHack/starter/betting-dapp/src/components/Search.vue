<template>
	<div class="center md-layout-item md-size-100">
	<md-card>
	<div>
		<md-card-content>
      		<form novalidate class="md-layout">
			<md-field>
		      <label>View Report Status by ID</label>
		      <md-input v-model="searchQuery" ref="searchQuery"></md-input>
		      <span class="md-helper-text">Looks like 0-1xxxxxx</span>
		    </md-field>

		    <div>
		        <md-button class="md-raised md-accent full-width bcolor-red" v-on:click="searchBlock">
		          <md-icon>arrow_forward</md-icon>
				</md-button>
        	</div>
			</form>

		</md-card-content>
	</div>


	</md-card>
	<md-card>
		<md-card-content>
		    <md-list v-if="searchResults.length > 0">
		    	<md-list-item v-for="searchResult in searchResults" :key="searchResult.id">
		        	{{ searchResult.value }}
				</md-list-item>
			</md-list>
			</md-card-content>
		</md-card>
	</div>
</template>
<script>
	import walletFactory from "@/util/WalletFactory";

	export default {
	  name: "Search",
	  data() {
	    return {
	  		searchQuery: " ",
	  		searchResults: []
	  	}
	  },
	  methods:{
	  	searchBlock(){
				var input = this.$refs.searchQuery.value;
				if (this.isEmpty(input)) {
					this.showError()
				} else {
					walletFactory.getExistingWallet(input, function(err, result) {
						if (result == null) {
							this.showError()
						} else {
							console.log("Wallet retrieved: ", result);
							// TODO: display messages to user
						}
					})
				}


	  	},
			showError() {
				this.searchResults = [{id: 0, value: "I did it again"},{id:1 , value: "oops"}]
			},
			isEmpty(str) {
					return (!str || 0 === str.length);
			}
	  }
	};
</script>
<style scoped>
	.md-card{
		width: 100%;
	}
</style>
