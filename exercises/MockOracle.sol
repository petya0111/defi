// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

contract MockOracle {
    uint256 private price;

    constructor() {
        price = 4050857425700000000000;
    }

    setPrice(uint256 price) public {
        price = _price;
    }

    function getPrice() view returns(uint256) {
        return price;
    }
}