// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal here is to become the owner.
/// The only check that protect here is a small if statement checking
/// if the msg.sender is different from tx.origin.
/// The solution is easy, we just need to create an attacker contract
/// which will call the changeOwner so the tx.origin will be use and the
/// msg.sender will be the attacker contract
contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}