// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import 'openzeppelin-contracts-06/math/SafeMath.sol';

/// @dev In old solidity version the constructor was the name of the contract. The problem is if you change
/// the name of the contract and make a fault in the name of the function then the "constructor" is not called.
/// Here the constructor is not well written: we just have to call it manually and this contract is hacked...
contract Fallout {
  
    using SafeMath for uint256;
    mapping (address => uint) allocations;
    address payable public owner;


    /* constructor */
    function Fal1out() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

    function allocate() public payable {
        allocations[msg.sender] = allocations[msg.sender].add(msg.value);
    }

    function sendAllocation(address payable allocator) public {
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function allocatorBalance(address allocator) public view returns (uint) {
        return allocations[allocator];
    }
}