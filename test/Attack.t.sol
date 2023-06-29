// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.2;
pragma experimental ABIEncoderV2;

import {console2} from "forge-std/console2.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import "forge-std/Test.sol";
import "../src/Attacker.sol";
//import "../src/Contract.sol";
import "forge-std/console.sol";

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract AttackTest is StdCheats, Test {
    /// @dev A function invoked before each test case is run.

    address alice = 0x80805ae3cbE23715C1f1807A03C5fb669541C2A9;
    Attacker attacker;
    DexTwo dex = DexTwo(0x88d6cdfC4388d080099cBF8dA3032F29D7BDE187);

    function setUp() public virtual {
        // Instantiate the contract-under-test.
        vm.prank(alice);

        attacker = new Attacker();
    }

    function testAttack() public {
        vm.startPrank(alice);

        //send tokens to attacker
        IERC20(dex.token1()).transfer(address(attacker), 10);
        IERC20(dex.token2()).transfer(address(attacker), 10);

        attacker.attack();

        console.log(
            IERC20(dex.token1()).balanceOf(address(dex)),
            "dex token 1 bal"
        );
        console.log(
            IERC20(dex.token2()).balanceOf(address(dex)),
            "dex token 2 bal"
        );

        assertEq(IERC20(dex.token1()).balanceOf(address(dex)), 0);
        assertEq(IERC20(dex.token2()).balanceOf(address(dex)), 0);
    }
}
