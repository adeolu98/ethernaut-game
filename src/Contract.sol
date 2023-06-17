// Make it past the gatekeeper and register as an entrant to pass this level.

// Things that might help:
// Remember what you've learned from the Telephone and Token levels.
// You can learn more about the special function gasleft(), in Solidity's documentation (see here and here).
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {
    address public entrant;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier gateOne() {
        require(msg.sender != tx.origin, "not origin");
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0, "check gas");
        _;
    }

    //to pass this since my player (caller) is 0x80805ae3cbE23715C1f1807A03C5fb669541C2A9
    //break the 20 bytes address to smaller bytes equal to the uint types, when reducing bytes start counting bytes from the back(right) (loweest bytes start from the right), when increasing pad from the front(left)

    // uint16(uint160(tx.origin)) = 0xC2A9
    //uint32(uint64(_gateKey)) = 0x0000C2A9
    //uint16(uint64(_gateKey)) = 0xC2A9
    //since we dont want uint64(_gatekey) to be same as //uint32(uint64(_gateKey)) = 0x0000C2A9, we can increase uint32(uint64(_gateKey)) = 0x0000C2A9 with non zero values to pad it up to uint64, thus adding 4 more bytes
    //uint64(_gatekey) = 0x808000000000C2A9

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(
        bytes8 _gateKey
    ) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
