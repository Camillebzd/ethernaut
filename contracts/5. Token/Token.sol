// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/// @dev The goal here to increase our own balance. Before version 0.8 the overflow and
/// underflow were not checked by default. The solution here is just to create an attacker
/// contract with 0 balance and call transfer, 0 - 1 will underflow and we win...
contract Token {

    mapping(address => uint) balances;
    uint public totalSupply;

    constructor(uint _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}