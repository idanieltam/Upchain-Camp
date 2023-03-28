//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

interface TokenRecipient {
    function tokensReceived(address sender, uint256 amount) external returns (bool);
}

contract DanielTamV2 is ERC20Upgradeable {
    using AddressUpgradeable for address;

    function transferWithCallback(address recipient, uint256 amount) public returns (bool){
        _transfer(msg.sender, recipient, amount);
        if (recipient.isContract()) {
            bool s = TokenRecipient(recipient).tokensReceived(msg.sender, amount);
            require(s, "Transfer failed");
        }
        return true;
    }

}