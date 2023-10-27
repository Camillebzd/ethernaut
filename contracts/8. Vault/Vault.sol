// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Here the goal is to set the locked variable to false so we have to find
/// what the password is. The trick here is to retreive the password from the storage directly.
/// On the blockchain no data can be "private" or "secret", the private word only mean this variable can't 
/// be use in other smart contract in the EVM but it doesn't means nobody can retreive it.
/// Just create a script that read the second slot of the smart contract and you find the password:
/// in this repo this is "script/FindVaultPassword.ts" or use "await web3.eth.getStorageAt(contract.address, 1)"
contract Vault {
    bool public locked;
    bytes32 private password;

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}