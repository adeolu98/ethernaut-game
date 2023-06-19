// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    //since bytecode is broken into initiliazation code and runtime code
    // initialiazation code
    // 1. 0x60 - PUSH1 --> PUSH(0x0a) --> 0x600a (`s=0x0a` or 10 bytes)
    // 2. 0x60 - PUSH1 --> PUSH(0x??) --> 0x60?? (`f` - This is not known yet) -this should be total byte size of initialization code
    // 3. 0x60 - PUSH1 --> PUSH(0x00) --> 0x6000 (`t=0x00` - arbitrary chosen memory location)
    // 4. 0x39 - CODECOPY --> CODECOPY --> 0x39 (Calling the CODECOPY with all the arguments)
    // 1. 0x60 - PUSH1 --> PUSH(0x0a) --> 0x600a (Size of opcode is 10 bytes)
    // 2. 0x60 - PUSH1 --> PUSH(0x00) --> 0x6000 (Value was stored in slot 0x00)
    // 3. 0xf3 - RETURN --> RETURN --> 0xf3 (Return value at p=0x00 slot and of size s=0x0a)
    // 600a60__6080396000a6000f3
    // 600a600c6080396000a6000f3
    // runtime code
    //  1. 0x60 - PUSH1 --> PUSH(0x2a) --> 0x602a (Pushing 0x2a or 42, 42 is the number to be returned by our contract)
    //  2. 0x60 - PUSH1 --> PUSH(0x80) --> 0x6080 (Pushing an arbitrary selected memory slot 80)
    //  3. 0x52 - MSTORE --> MSTORE --> 0x52 (Store value p=0x2a at position v=0x80 in memory)
    //  1. 0x60 - PUSH1 --> PUSH(0x20) --> 0x6020 (Size of value is 32 bytes)
    //  2. 0x60 - PUSH1 --> PUSH(0x80) --> 0x6080 (Value was stored in slot 0x80)
    //  3. 0xf3 - RETURN --> RETURN --> 0xf3 (Return value at p=0x80 slot and of size s=0x20)
    // 602a60805260206080f3
    
    MagicNum magicnum = MagicNum(0x4D5224A8e9c2FE5F3660f22341c70fCd899d8166);

    function setUp() public {
        vm.startBroadcast();
    }

    function run() external{
        //add inititaliazation and runtime bytecode together
        bytes memory bytecode = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solver;

        assembly {
            solver := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        magicnum.setSolver(solver);
        vm.stopBroadcast();
    }
}
