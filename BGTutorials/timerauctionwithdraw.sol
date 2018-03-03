pragma solidity ^0.4.0;

import "./baseauction.sol";
import "./withdrawable.sol";

contract TimerAuction is BaseAuction, Withdrawable {

    string public item;
    uint public auctionEnd;
    address public maxBidder;
    uint public maxBid;
    bool public ended;

    event BidAccepted(address bidder, uint bid);

    function TimerAuction(uint _durationMinutes, string _item){
        item = _item;
        auctionEnd = now + (_durationMinutes * 1 minutes);
    }

       function bid() public payable {
        require(now < auctionEnd);
        require(msg.value > maxBid);

        if(maxBidder != 0){
            pendingWithdrawals[maxBidder] += maxBid;
        }


        maxBidder = msg.sender;
        maxBid = msg.value;
        BidAccepted(maxBidder, maxBid);
    }

    function end() public ownerOnly {
        //1) check conditions
        require(now >= auctionEnd);
        require(!ended);

        //2) update state
        ended = true;
        AuctionComplete(maxBidder, maxBid);

        //3) interact with address
        pendingWithdrawals[owner] += maxBid;
    }
}
