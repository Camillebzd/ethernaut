// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal here is to become the ower. We will use the delegatecall vulnerability (use external fct but with internal modification).
/// NEVER STORE VARIABLE IN LIBS or at least respect the number and order of storage variables from
/// the original caller. Here as the storage variables are differents that will break the contract.
/// The first call to the lib will replace the address in timeZone1Library because the var modified in
/// the lib is on slot 0x1... So we need to:
/// 1. Create an attacker contract with the first 3 storage variables and create a setTime fct that will 
///    set the owner to the params passed
/// 2. Call setFirstTime on the Preservation contract with the address of the attacker contract -> this will set
///    the timeZone1Library to our new contract.
/// 3. Call setFirstTime once again with our address as parameter so this will set our address as owner!
contract Preservation {

    // public library contracts 
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 
    uint storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
        timeZone1Library = _timeZone1LibraryAddress; 
        timeZone2Library = _timeZone2LibraryAddress; 
        owner = msg.sender;
    }
    
    // set the time for timezone 1
    function setFirstTime(uint _timeStamp) public {
        timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }

    // set the time for timezone 2
    function setSecondTime(uint _timeStamp) public {
        timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }
}

// Simple library contract to set the time
contract LibraryContract {

    // stores a timestamp 
    uint storedTime;  

    function setTime(uint _time) public {
        storedTime = _time;
    }
}