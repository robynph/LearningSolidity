pragma solidity ^0.4.19;

import "./escrowSimple.sol";
import "./factory.sol";
import "./ModelWallet.sol";

contract ReportRepo is Factory{

  address user;
  address HRrep;
  
  // enum capture for Escrow state?
  
  User[] users;
  Message[] messages;
  
  struct User {
        address owner; /* This is an Ethereum Account Address - user must have keys and password */
        address walletAddress;
  }

  struct Message{
        address owner;
        string message;
        uint32 attachIPFS;
  }

  function createReportWallet(address[] _users, uint _required) public returns (address wallet) {
    wallet = new ModelWallet(_users, _required);
    register(wallet);
  }
  
  function addMessage(address _sender, string _message, uint32 _attachIPFS) public {
        Message memory newMsg;
        
        _sender == msg.sender;
        newMsg.owner = _sender;  
        newMsg.message = _message;
        newMsg.attachIPFS = _attachIPFS;
        messages.push(newMsg);
        
   }
      
   //function send funds to Escrow
   
   //modifiers to change states for Escrow 
   
   //return funds from Escrow
   
   //modifier to change state of contract from in progress, under investigation, resolved, in dispute
   
   
}




