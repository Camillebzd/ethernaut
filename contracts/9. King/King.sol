// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal here is to block the system of "receive". The "transfer" method will revert
/// if the transaction fail. So the block we have to:
/// 1. Create an attacker contract without any fallback and payable methods
/// 2. Initiate a call message with eth inside from the attacker to the King contract
/// The King contract will remains blocked because when somebody else will come to found it
/// the contract will try to send the ether to the attacker contract but this will revert forever...
contract King {
    address king;
    uint public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;  
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}