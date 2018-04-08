import Web3 from 'web3'
import store from '../store/state'
import {contract, ABI} from './constants/starterContract'

var Contract = {

  whistler : "0x582f61897691810b8c9AD79d9eB4d98734AF01F1",
  hr : "0x24f503299f816a5a0bb924925fceca03afd5f5d5",

  existingContractId : "0x6414e6a8f954727005c08ba47d07e834dec2eff9",

  // let testContractFunctions = new Promise(function (resolve, reject) {
  //  getExistingContract(existingContractId, function(err, result) {
  //   createContract(function(err, result) {
  //     console.log(result)
  //     web3.eth.defaultAccount=web3.eth.accounts[0]
  //
  //     var myContract = result
  //
  //     getMessageCount(myContract, function(err, result) {
  //       console.log(result)
  //
  //       addMessage(myContract, "This is a test", function(err, result) {
  //         console.log(result)
  //
  //         getMessages(myContract, function(err, result) {
  //           console.log(result)
  //         })
  //       })
  //     })
  //   })
  // })

  // TODO Figure out how to deploy a contract. Currently throwing invalid address error
  createContract : function(callback) {
    if (typeof callback === "function") {
      let web3 = new Web3(window.web3.currentProvider)
      web3.eth.defaultAccount=web3.eth.accounts[0]
      console.log(store, web3.eth.defaultAccount)
      this.whistler = web3.eth.defaultAccount

      var reportwalletContract = web3.eth.contract(ABI);
      var reportwallet = reportwalletContract.new(
       [this.whistler,this.hr], 2,
       {from: this.whistler}, callback)
    } else {
      console.log("ERROR: must send a callback function.")
    }
  },

  getExistingContract : function(contractId, callback) {
    let web3 = new Web3(window.web3.currentProvider)
    web3.eth.defaultAccount=web3.eth.accounts[0]

    if (typeof callback === "function") {
      let web3 = new Web3(window.web3.currentProvider)
      web3.eth.contract(ABI).at(contractId, callback)
    } else {
      console.log("ERROR: must send a callback function.")
    }
  },

  getMessageCount : function(contract, callback) {
    if (typeof callback === "function") {
      contract.getMessageLength(callback)
    } else {
      console.log("ERROR: must send a callback function.")
    }
  },

  addMessage : function(contract, text, hash, callback) {
    web3.eth.defaultAccount=web3.eth.accounts[0]
    if (typeof callback === "function") {
      contract.addMessage(this.whistler, text, hash, callback)
    } else {
      console.log("ERROR: must send a callback function.")
    }
  },

  getMessages : function(contract, callback) {
    if (typeof callback === "function") {
      getMessageCount(contract, function(err, result) {
        var messages = new Array(result)
        for (var i = 0; i < result; i++) {
          getMessage(contract, i, callback)
        }
      })
    } else {
      console.log("ERROR: must send a callback function.")
    }
  },

  getMessage : function(contract, index, callback) {
    if (typeof callback === "function") {
      contract.getMessage(index, callback)
    } else {
      console.log("ERROR: must send a callback function.")
    }
  }
}

// export default getContract
export default Contract