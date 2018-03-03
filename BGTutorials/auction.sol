pragma solidity ^0.4.0;

// contract allows anyone to bid on an item
// declare an interface b/c cannot provide any sort of function/constructors/variables, can only declare are set function signatures
interface Auction {

    function bid() payable;

    function end();

}
