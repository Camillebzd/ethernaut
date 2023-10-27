// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal is to unlock the contract. As for Vault challenge we have to
/// retreive the data from the storage. Remember that for array the slot is
/// calculate with the hash of the slot number of the array + key.
/// You can use "script/FindPrivacyPassword.ts" or 
/// "await web3.eth.getStorageAt(contract.address, 5)" then take the first 16 bytes (32 char)
contract Privacy {
    bool public locked = true; // 0x0
    uint256 public ID = block.timestamp; // 0x1
    uint8 private flattening = 10; // 0x2
    uint8 private denomination = 255; // 0x2
    uint16 private awkwardness = uint16(block.timestamp); // 0x2
    bytes32[3] private data; // 0x3, 0x4, 0x5 -> need to get the last element at key 2 and take only half of it so half 0x5

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
        A bunch of super advanced solidity algorithms...

        ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
        .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
        *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
        `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
        ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
    */
}