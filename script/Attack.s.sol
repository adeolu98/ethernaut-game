// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
//import "../src/Contract.sol";
import "forge-std/console.sol";


contract AttackScript is Script {
    Attacker attacker;

    function setUp() public {
        vm.startBroadcast();

        attacker = new Attacker ();
    }

    function run() external {
        attacker.attack();

        vm.stopBroadcast();
    }
}
