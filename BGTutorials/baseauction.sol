pragma solidity ^0.4.0;

import "./auction.sol";

//interfaces can only provide set of function signatures
//abstract classes don't implement all of their fuctions, can extend to other classes, constructors, variables and fully implemented functions
contract RoseAuction is Auction {

    address public owner;

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    event AuctionComplete(address winner, uint bid);

    function RoseAuction() {
        owner = msg.sender;
    }


}
