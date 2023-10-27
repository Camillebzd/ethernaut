// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleTrick {
    GatekeeperThree public target;
    address public trick;
    uint private password = block.timestamp;

    constructor (address payable _target) {
        target = GatekeeperThree(_target);
    }
        
    function checkPassword(uint _password) public returns (bool) {
        if (_password == password) {
            return true;
        }
        password = block.timestamp;
        return false;
    }
        
    function trickInit() public {
        trick = address(this);
    }
        
    function trickyTrick() public {
        if (address(this) == msg.sender && address(this) != trick) {
            target.getAllowance(password);
        }
    }
}

/// @dev The goal of this challenge is to set entrant to our address so we need to pass the 3 gates.
/// gate 1: the constructor is not well written so we can call it manually to set the attack contract then use it.
/// gate 2: need to set allowEntrance to true. Call checkPassword will reset the password to block.timestamp then call it back with
/// the same block.timestamp.
/// gate 3: the contract should have more than 0.001 ether et owner .send should failed so our contract should block the send...
contract GatekeeperThree {
    address public owner;       // 0x0000
    address public entrant;     // 0x0000
    bool public allowEntrance;  // false

    SimpleTrick public trick;

    function construct0r() public {
        owner = msg.sender;
    }

    modifier gateOne() {
        require(msg.sender == owner);
        require(tx.origin != owner);
        _;
    }

    modifier gateTwo() {
        require(allowEntrance == true);
        _;
    }

    modifier gateThree() {
        if (address(this).balance > 0.001 ether && payable(owner).send(0.001 ether) == false) {
            _;
        }
    }

    function getAllowance(uint _password) public {
        if (trick.checkPassword(_password)) {
            allowEntrance = true;
        }
    }

    function createTrick() public {
        trick = new SimpleTrick(payable(address(this)));
        trick.trickInit();
    }

    function enter() public gateOne gateTwo gateThree {
        entrant = tx.origin;
    }

    receive () external payable {}
}