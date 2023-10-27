// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The recovery contract will be deployed and a contract token will be generated. The goal is to retreive the token contract
/// address and withdraw or destroy it. The address of a contract is deterministic in Solidity which means you can find what was
/// the address by calculating the keccak256 of the creator + nonce. Once the address calculated just call the destruction fct.
contract Recovery {

    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {

    string public name;
    mapping (address => uint) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint _amount) public { 
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}