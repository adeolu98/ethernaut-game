// How has the swap method been modified?
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/ERC20.sol";
import 'openzeppelin/access/Ownable.sol';

contract NewAttackToken is ERC20 {

    constructor (address dex) ERC20('ATTACK TOKEN', 'ATT') public {
        _mint(dex, 100);
        _mint(msg.sender, 100);
    }
}