// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    function setUp() public {}

    //solveed by using the selfdestruct() to send ether to another contract
    function run() public {
        vm.startBroadcast();
        //using the passowrd value read at storage call the unlock function to unlock vault
        //await web3.eth.getStorageAt('0x6E2FE149DEe227A1ACB05c6c929789007e866609', 1) --> do in js
        bytes32 password = 0x412076657279207374726f6e67207365637265742070617373776f7264203a29;

        Vault vault = Vault(0x6E2FE149DEe227A1ACB05c6c929789007e866609);
        vault.unlock(password);
        
        console.log('variable locked is', vault.locked());
        vm.stopBroadcast();
    }
}
