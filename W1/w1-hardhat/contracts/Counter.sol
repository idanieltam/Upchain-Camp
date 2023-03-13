// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";

contract Counter {
    uint public counter;
    address owner;

    constructor() {
        counter = 0;
        owner = msg.sender;
    }
    // Function to get the current count
    function get() public view returns (uint) {
        return counter;
    }

    // Function to increment count by 1
    function inc() public {
        counter += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        // This function will fail if count = 0
        counter -= 1;
    }

    function count() public {
        require(msg.sender == owner, "Invalid caller");
        counter = counter + 1;
        console.log(counter);
    }
}