// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract OpenEye is ERC20, ERC20Burnable, Ownable {
    uint256 private maketCap = 10_000_000_000 *10 **uint256(18);

    constructor (address initOwner)
                ERC20("OpenEye", "OPE")
                Ownable(initOwner)
    {
        _mint(msg.sender, maketCap);
        _transferOwnership(msg.sender);
    }
}