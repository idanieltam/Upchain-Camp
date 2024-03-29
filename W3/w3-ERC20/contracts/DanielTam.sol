//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DanielTam is ERC20 {
    uint constant _initial_supply = 100000 * (10**18);
    constructor() ERC20("DanielTam", "DT") {
        _mint(msg.sender, _initial_supply);
    }
}