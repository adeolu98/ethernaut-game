// The creator of this contract was careful enough to protect the sensitive areas of its storage.

// Unlock this contract to beat the level.

// Things that might help:

// Understanding how storage works
// Understanding how parameter parsing works
// Understanding how casting works
// Tips:

// Remember that metamask is just a commodity. Use another tool if it is presenting problems. Advanced gameplay could involve using remix, or your own web3 provider.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {

//storage slot 0
  bool public locked = true;

  //storage slot 1
  uint256 public ID = block.timestamp;

  //storage slot 2
  uint8 private flattening = 10;
  uint8 private denomination = 255;
  uint16 private awkwardness = uint16(block.timestamp);

  //takes storage slot 3 to 5
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    //valid _key is in storage slot 5
    //read it via await web3.eth.getStorageAt('0x42d456038445cA6bdA8E1C8f95E3212FA81E5763', 5)
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}