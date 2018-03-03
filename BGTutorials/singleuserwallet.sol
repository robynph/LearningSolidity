pragma solidity ^0.4.2;

contract SimpleWallet {

        address public owner;

        modifier ownerOnly() {
            //revert throws exception without consuming all of the transaction gas
            if(msg.sender != owner) revert();
            _;
        }

    function SimpleWallet() {
        owner = msg.sender;
    }

    function getBalance() constant returns (uint) {
        return this.balance;
    }

    function withdraw(uint amount) ownerOnly {
        if(amount > this.balance) revert();

        owner.transfer(amount);
    }

    funciton deposit() ownerOnly payable {
        // amount of ether sent in msg.value is added to SimpleWallet
    }

}
