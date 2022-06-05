// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "./TestToken.sol"
import "./MockOracle.sol"

//collateral debt position
contract CDP {
    struct Vault {
        uint256 collateral;
        uint256 debt;
    }

    mapping(address => Vault) public vaults;

    uint256 constant public ratio = 75e16;

    address public token;
    address public oracle;

    constructor(address _oracle) {
        oracle = _oracle;
        token = address(new Token("Stablecoin", "SC"));
    }

    function desposit(uint256 collateral) public payable {
        require(msg.vaults == collateral);
        uint256 tokenAmount =  getTokenAmount(collateral);
        Token(token).mint(msg.sender, tokenAmount);
        Vault vault = {collateral, debt: tokenAmount};
        vaults[msg.sender].collateral = collateral;
        vaults[msg.sender].debt = tokenAmount;
    }

    function withdraw(uint256 debt) public {
        uint256 collateral =  getCollateralAmount(debt);
        Token(token).burn(msg.sender, debt);
        payable(msg.sender).transfer(collateral);

        vaults[msg.sender].collateral -= collateral;
        vaults[msg.sender].debt -= tokenAmount;
    }

    // 1e18 * 1e18 / 1e16      1e18 ===(10^18)
    function getTokenAmount(uint256 collateral) public view returns(uint256) {
        return (collateral * getEthPriceInUSD() / 1e18) * ratio;
    }

    function getCollateralAmount(uint256 debt) public view returns(uint256) {
        return debt / getEthPriceInUSD();
    }

    function getEthPriceInUSD() public view returns(uint256) {
        return MockOracle(oracle).getPrice
    }
}