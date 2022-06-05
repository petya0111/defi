// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        // _mint(msg.sender, initialSupply);
    }

    // modifier onlyOwner_ {
    //     require(msg.sender === owner);
    //     _;
    //     // to not duplicate the code; check all methods with this modifier
    // }

    function mint(address account, uint256 amount) onlyOwner external returns(bool) {
        _mint(account, amount);
        return true;
    }

    function burn(address account, uint256 amount) onlyOwner external returns(bool) {
        _burn(account, amount);
        return true;
    }
}