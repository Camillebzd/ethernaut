// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal is to increase the balance of this contract even if 
/// it doesn't have any fallback or payable methods.
/// The solution is to create an attacker contract with a small balance
/// and then self destruct it with this contract as target. This will work
/// because the opcode used for self destruct can't be reverted or stoped.
contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}