// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev The goal here is to successfully guess the good coin flip 10 times consecutively. This seems secure 
/// because an algo is hashing and factoring to find a "pseudo-random" value. Remember that "pseudo-random" 
/// can be reproducted if the algo is know which is the case here. So to hack the game you need to:
/// 1. Take the algo of calculation of the coin flip in the flip method
/// 2. Create another contract (attacker contract) and put inside a method the algo to do the exact same calcul in flip()
/// 3. At the end of the method call the flip method here with the result pre calculate and the fct will find the 
///    same result as you so you will win every time
/// 4. Send 10 transaction that trigger the attacker contract then it's done
contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}