// You've uncovered an Alien contract. Claim ownership to complete the level.

//   Things that might help

// Understanding how array storage works
// Understanding ABI specifications
// Using a very underhanded approach
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'openzeppelin/access/Ownable.sol';

contract AlienCodex is Ownable {

//this has a owner variable so owner, contact are in slot 0
  bool public contact;

  //slot 1-257 for codex
  bytes32[] public codex;

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function makeContact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }
}