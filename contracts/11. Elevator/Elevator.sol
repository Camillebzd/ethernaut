// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

/// @dev The goal here is to set the top value to true. We have to create the attacker contract
/// which implement the isLastFloor method and this method will be called twice during the transaction
/// and we need to first return false then return true. We have 3 choices:
/// 1. The attacker contract has a counter with return false and true every other time.
///    - This technic is valid because the interface above don't specify a view or pure modifier
/// 2. The attacker contract implement the method with a different imput data without realying on
///    state like the use of gasLeft()
///    - This technic will work even if the interface specified the view modifier!
/// 3. The attacker contract check the floor variable of this contract and when this is set to the first call
///    this means the you can return something else
///    - This technic will work even if the interface specified the view modifier!
contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (! building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}