// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Here the goal is to create a Solver contract that return 42 but with less than 10 opcode
/// so we will have to use Raw EVM bytecode to build the contract...
/// Use https://ethervm.io/ to see the opcode to store 42 and return it.
/// Remember that we can use a contract constructor and in the constructor just store the bitcode
/// and log the address deployed
contract MagicNum {

    address public solver;

    constructor() {}

    function setSolver(address _solver) public {
        solver = _solver;
    }

    /*
    ____________/\\\_______/\\\\\\\\\_____        
     __________/\\\\\_____/\\\///////\\\___       
      ________/\\\/\\\____\///______\//\\\__      
       ______/\\\/\/\\\______________/\\\/___     
        ____/\\\/__\/\\\___________/\\\//_____    
         __/\\\\\\\\\\\\\\\\_____/\\\//________   
          _\///////////\\\//____/\\\/___________  
           ___________\/\\\_____/\\\\\\\\\\\\\\\_ 
            ___________\///_____\///////////////__
    */
}