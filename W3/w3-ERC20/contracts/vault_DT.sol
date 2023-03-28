//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface TokenRecipient {
    function tokensReceived(address sender, uint amount) external returns (bool);
}

contract vault_DT is TokenRecipient{
    mapping(address => uint) public deposited;
    address public immutable token;
    constructor(address _token) {
        token = _token;
    }

    function deposit(address user, uint amount) public {
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "transfer failed");
        deposited[user] += amount;
    }

    function permitDeposit(address user, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        IERC20Permit(token).permit(msg.sender, address(this), amount, deadline, v, r, s);
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "transfer failed");
        deposited[user] += amount;
    }

    function withdraw(uint amount) public {
        require(deposited[msg.sender] >= amount, "insufficient balance");
        deposited[msg.sender] -= amount;
        require(IERC20(token).transfer(msg.sender, amount), "transfer failed");
    }

    function tokensReceived(
        address operator,
        address from,
        address to,
        uint amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external {
        require(msg.sender == token, "invalid token");
        deposited[from] += amount;
    }

    function tokensReceived(address sender, uint amount) external returns (bool) {
        require(msg.sender == token, "invalid");
        deposited[sender] += amount;
        return true;
    }

}