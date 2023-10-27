// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev the goal here is to set our address in the entrant storage variable and we need to pass all the modifiers
/// 1. the first gate is easy, we just have to use an intermediary contract
/// 2. for the second one we need spcesify a certain amount of gas in the transaction (calculate with foundry)
/// 3. calculate the good number
contract GatekeeperOne {

    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}