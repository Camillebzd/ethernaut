// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import '../helpers/Ownable-05.sol';

/// @dev The goal here is to get the ownership. As it is an old solidity version we can underflow.
/// if we call retract on an empty codex the length will underflow and codex will be 2 ** 256 - 1
/// size so all the storage will be accessible. Just after we found the right key and give as 
/// bytes our address.
/// slot on array -> the slot on codex 0x1 is the length of the array 
/// then h = keccak256(1)
/// slot h = codex[0]
/// slot h + 1 = codex[1] etc

/// Find i such that slot h + i = slot 0 (for the slot of owner)
/// i = slot 0 - h
/// 1. Call makeContact
/// 2. Call retract
/// 3. Calculate the slot which colide with the owner
/// 4. Call revise to set our address

contract AlienCodex is Ownable {

    bool public contact;
    bytes32[] public codex;

    modifier contacted() {
        assert(contact);
        _;
    }
    
    function makeContact() public {
        contact = true;
    }

    function record(bytes32 _content) contacted public {
        codex.push(_content);
    }

    function retract() contacted public {
        codex.length--;
    }

    function revise(uint i, bytes32 _content) contacted public {
        codex[i] = _content;
    }
}