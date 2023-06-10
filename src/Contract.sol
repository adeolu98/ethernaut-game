//Unlock the vault to pass the level!

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
  bool public locked;

  //this level should be passed if we can somehow read the state of this private variable
  //even private varibales can be read indirectly with web3.eth


  //we can do this by using the web3.eth function --> web3.eth.getStorageAt('contract addr', storage slot of the variable)
  //await web3.eth.getStorageAt('0x6E2FE149DEe227A1ACB05c6c929789007e866609', 1), where 0x6E2FE149DEe227A1ACB05c6c929789007e866609 is the level address and 1 is the storage slot for the password
  //each slot comtains max 32 bytes 
  //varibale locked is bool so has one byte
  //password variable is bytes32 so contains 32 bytes by default
  //ranking them in order of appearance in code locked takes slot 0. 
  //since slot 0 now has lefdt 31 bytes and this is not enough for password(32 bytes), it is pushed to slot 0
  bytes32 private password;

  constructor(bytes32 _password) {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}