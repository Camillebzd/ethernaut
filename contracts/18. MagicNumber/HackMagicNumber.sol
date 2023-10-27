// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Create the bytecode to return 42 from the constructor (the constructor itself
/// it not added in the bytecode).

/// -- Runtime code -- (return 42)

// - Store 42 at an address in the contract
// PUSH1 0x2a -> Put in stack 42
// PUSH1 0     -> Put in stack 0
// MSTORE      -> mstore(p, v) - store v at memory p to p + 32
// - bytecode: 602a600052

// - Return 32 bytes from memory
// PUSH1 0x20  -> Put in stack 32
// PUSH1 0     -> Put in stack 0
// RETURN      -> return(p, s) - end execution and return data from memory p to p + s
// - bytecode: 60206000f3

// - runtime full bytecode: 602a60005260206000f3
//   in hexa on 32 bytes: 0x00000000000000000000000000000000000000000000602a60005260206000f3

/// -- Creation code -- (bytecode run during the creation and return the runtime code)

// -Store the runtime code to memory 
// PUSH10 0x602a60005260206000f3 -> Put in stack 20 bytes (our runtime bytecode)
// PUSH1 0                       -> Put in stack 0
// MSTORE                        -> mstore(p, v) - store v at memory p to p + 32
// - bytecode: 69602a60005260206000f3600052

// - Return 10 bytes from memory starting at offset 22 (cause 32 bytes used and only 10 last bytes are the runtime bytecode)
// PUSH1 0x0a  -> Put in stack 10
// PUSH1 0x16  -> Put in stack 22
// RETURN      -> return(p, s) - end execution and return data from memory p to p + s
// - bytecode: 600a6016f3

// - creation code (that will store the runtime code): 69602a60005260206000f3600052600a6016f3

import "./MagicNumber.sol";

contract HackMagicNum {
    event Created(address addr);

    constructor(MagicNum target) {
        address addr;
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";

        assembly {
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x13)
        }
        require(addr != address(0), "contract creation failed");
        target.setSolver(addr);
        emit Created(addr);
    }
}