// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "forge-std/console.sol";

contract AttackScript is Script {

Attacker attackerContract;
    function setUp() public {
              vm.startBroadcast();
     attackerContract = new Attacker();
       vm.stopBroadcast();
     
    }

    function run() public {

        vm.startBroadcast();

        attackerContract.attack();

        vm.stopBroadcast();
    }
}
