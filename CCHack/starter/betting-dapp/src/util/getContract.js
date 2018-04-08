import Web3 from 'web3'
import store from '../store/state'
import {contract, ABI} from './constants/starterContract'

var whistler = "0x582f61897691810b8c9AD79d9eB4d98734AF01F1"
var hr = "0x24f503299f816a5a0bb924925fceca03afd5f5d5"

var existingContractId = "0x6414e6a8f954727005c08ba47d07e834dec2eff9"

let getContract = new Promise(function (resolve, reject) {
  //getExistingContract(existingContractId, function(err, result) {
  //   console.log(result)
  //   resolve(result)
  whistler = web3.eth.accounts[0]
  createContract(function(err, result) {
    console.log(result)
    web3.eth.defaultAccount=web3.eth.accounts[0]
    
    var myContract = result
  
    getMessageCount(myContract, function(err, result) {
      console.log(result)
  
      addMessage(myContract, "This is a test", function(err, result) {
        console.log(result)
  
        getMessages(myContract, function(err, result) {
          console.log(result)
        })
      })
    })
  })
})

// TODO Figure out how to deploy a contract. Currently throwing invalid address error
function createContract(callback) {
  if (typeof callback === "function") {
    let web3 = new Web3(window.web3.currentProvider)

    web3.eth.defaultAccount=web3.eth.accounts[0]

    var reportwalletContract = web3.eth.contract(ABI);
    var reportwallet = reportwalletContract.new(
     [whistler,hr], 2,
     {from: whistler}, callback)
  } else {
    console.log("ERROR: must send a callback function.")
  }
}

function getExistingContract(contractId, callback) {
  if (typeof callback === "function") {
    let web3 = new Web3(window.web3.currentProvider)
    web3.eth.contract(ABI).at(contractId, callback)
  } else {
    console.log("ERROR: must send a callback function.")
  }
}

function getMessageCount(contract, callback) {
  if (typeof callback === "function") {
    contract.getMessageLength(callback)
  } else {
    console.log("ERROR: must send a callback function.")
  }
}

function addMessage(contract, text, hash, callback) {
  web3.eth.defaultAccount=web3.eth.accounts[0]
  if (typeof callback === "function") {
    contract.addMessage(whistler, text, hash, callback)
  } else {
    console.log("ERROR: must send a callback function.")
  }
}

function getMessages(contract, callback) {
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
}

function getMessage(contract, index, callback) {
  if (typeof callback === "function") {
    contract.getMessage(index, callback)
  } else {
    console.log("ERROR: must send a callback function.")
  }
}

export default getContract
