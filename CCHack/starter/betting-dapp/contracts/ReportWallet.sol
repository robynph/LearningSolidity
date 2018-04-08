pragma solidity ^0.4.19;

import "./escrowSimple.sol";
import "./factory.sol";
import "./ModelWallet.sol";

contract ReportWallet is ModelWallet {

  address user;
  address HRrep;
  //uint msgCount;

  // enum capture for Escrow state?

  event MessageEvent(address owner, bytes32 message, uint32 IPFShash);

  User[] users;
  Message[] messages;
  address walletAddress;

  struct User {
    address owner; /* This is an Ethereum Account Address - user must have keys and password */
    address walletAddress;
  }

  struct Message{
    address owner;
    bytes32 text;
    uint32 attachIPFS;
  }

  function ReportWallet(address[] _owners, uint _required)
        public
        ModelWallet(_owners, _required)
    {}

  function addMessage(address _sender, bytes32 _message, uint32 _attachIPFS) public {
        Message memory newMsg;

        _sender == msg.sender;
        newMsg.owner = _sender;
        newMsg.text = _message;
        newMsg.attachIPFS = _attachIPFS;
        messages.push(newMsg);
   }

   function getMessageLength() public constant returns (uint) {
        return messages.length;
   }

   function getMessage(uint i) public view returns (address, bytes32, uint32) {
        Message storage currMsg = messages[i];
        return(currMsg.owner,currMsg.text,currMsg.attachIPFS);
  }

   //function send funds to Escrow

   //modifiers to change states for Escrow

   //return funds from Escrow

   //modifier to change state of contract from in progress, under investigation, resolved, in dispute
}
