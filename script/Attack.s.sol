// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    function setUp() public {}

    //solveed by using the selfdestruct() to send ether to another contract
    function run() public {
        vm.startBroadcast();
        address Elevator  = 0x2545C0d2473F1fe418d38dd0E4c2FC8E8a8D6BDe;
        Attacker attacker = new Attacker(Elevator);

        attacker.attack();
        vm.stopBroadcast();
    }
}
