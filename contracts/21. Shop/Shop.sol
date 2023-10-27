// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint);
}

/// @dev The goal here is to buy with a cheaper price. This is the same exact system as Elevator challenge but this time
/// as the method is view we can't use a storage variable. What we can do is to use gasleft() to change the return price and
/// set a fixed gas amount during the attack to know when the contract ask the price for the second time...
/// You can also check for isSold == true maybe this is easier... (yea I found this one after)
contract Shop {
    uint public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}