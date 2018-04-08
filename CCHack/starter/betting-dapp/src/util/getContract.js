import Web3 from 'web3'
import store from '../store/state'
import {contract, ABI} from './constants/starterContract'

let getContract = new Promise(function (resolve, reject) {
  let web3 = new Web3(window.web3.currentProvider)
  web3.defaultAccount = web3.eth.accounts[0];
  let contract = web3.eth.contract(ABI)
  let contractInstance = contract.at(contract)

  console.log(contractInstance)

  contractInstance.getWalletAddress(
    {
    gas: 30000,
    value: 30000,
    from: contractInstance.address
  }
//   , (err, result) => {
//     if (err) {
//       console.log('ERROR!')
//     } else {
//       console.log('SUCCESS!', result)
//     }
//   }
)
})

export default getContract
