<template>
 <div class='metamask-info'>
   <p>Metamask: {{ web3.isInjected }}</p>
   <p>Network: {{ web3.networkId }}</p>
   <p>Account: {{ web3.coinbase }}</p>
   <p>Balance: {{ web3.balance }}</p>

   <p v-on:click="addMessage">Add Message: </p>
 </div>
</template>
<script>
export default {
 name: 'hello-metamask',
 computed: {
   web3 () {
     return this.$store.state.web3
     }
   },
   methods: {
     addMessage() {
       console.log('Wallet', this.$store.state.contractInstance().getWalletAddress({
         gas: 300000,
         value: this.$store.state.web3.web3Instance().toWei(this.amount, 'ether'),
         from: this.$store.state.web3.coinbase
       }))
     }
   }
}
</script>
<style scoped></style>
