// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Bank {
    
    address public owner;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
        
    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    function myBalancec() public view returns(uint) {
        return balances[msg.sender];
    }

    function withdraw() public {
        (bool s, ) = payable(msg.sender).call{value: balances[msg.sender]}("");
        require(s, "Failed to send Ether");
        balances[msg.sender] = 0;
    }

    function withdrawAll() public onlyOwner {
        (bool s, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(s, "Failed to withdraw all");
    }
}
