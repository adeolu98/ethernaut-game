// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import {console2} from "forge-std/console2.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import "forge-std/Test.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract AttackTest is StdCheats, Test {
    /// @dev A function invoked before each test case is run.
    GatekeeperOne gatekeeper;
    Attacker attacker;
    address alice = 0x80805ae3cbE23715C1f1807A03C5fb669541C2A9;

    function setUp() public virtual {
        // Instantiate the contract-under-test.
        vm.prank(alice);
         gatekeeper = new GatekeeperOne();
         attacker = new Attacker(gatekeeper);
        console.log(gatekeeper.owner());
    }

    function testAttack() public {
        bytes8 gatekey = 0x808000000000C2A9;

        vm.prank(alice);
        
       attacker.attack(gatekey);
    }
}
