// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev As in Gatekeeper One we need to set entrant. For the gate:
/// 1. This one is same as previous, just create an attacker smart contract
/// 2. This one check in assembly if the msg.sender as no code in it (so if it's a smart contract or not).
///    As we need to use a smart contract we will do everything in the constructor because during the constructor
///    execution the code of the contract is not set in the storage yet so this gate will be bypassed
/// 3. This one we need to take the hash of msg.sender and then apply a byte mask on it so the xor of this
///    value is the max of an uint64. If you apply not opp (~) on it you will have all the opposite of the base so
///    when you will xor both you will each time have 1 and 0 so equal 1 and a full 1 give the max number...
contract GatekeeperTwo {

    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint x;
        assembly { x := extcodesize(caller()) }
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
