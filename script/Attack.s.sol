// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    GatekeeperTwo gatekeeper = 
        GatekeeperTwo(0x4EC09e9168b33E4616Ec502944c9ef311e267ba3);
    Attacker attacker;

    function setUp() public {
        vm.startBroadcast();
        attacker = new Attacker(gatekeeper);
    }

    function run() public{
        
    }
}
