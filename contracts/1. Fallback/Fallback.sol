// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Here the goal is to become the owner of the contract deployed by ethernaut.
/// You need to see that the only way outside of the constructor to modify the owner is via the 
/// receive function but a require force you to first contribute. So the steps are:
/// 1. call the contribute methods and send 1 wei so you will be added to contributions map
/// 2. send a transaction WITHOUT ANY DATA BUT WITH 1 WEI, that will trigger the receive function and
///    set the owner to your address
contract Fallback {

    mapping(address => uint) public contributions;
    address public owner;

    constructor() {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if(contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}