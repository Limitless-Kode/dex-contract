//SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ClaverToken.sol";

contract EthSwap{
    error BelowMinimumError(string msg);

    address public owner;
    ClaverToken public token;
    uint rate = 100;
    uint minPurchasableTokens = 10;

    constructor(ClaverToken _token){
        owner = msg.sender;
        token = _token;
    }


    function buyTokens() public payable{
        uint numberOfTokens = msg.value * rate;

        // check if the number of tokens is more than the minimum purchasable tokens
        if(numberOfTokens < minPurchasableTokens){
            revert BelowMinimumError("Tokens to purchase too low");
        }

        // Check if EthSwap has enough tokens
        require(token.balanceOf(address(this)) >= numberOfTokens, "Insufficient tokens");

        // Transfer tokens to sender
        token.transfer(msg.sender, numberOfTokens);

        emit TokenPurchased(msg.sender, address(token), numberOfTokens, rate);
    }

    function sellTokens(uint _amount) public {
        uint etherAmount = _amount / rate;

        require(address(this).balance >= etherAmount, "Insufficient balance to perform transaction");

        token.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(etherAmount);

        emit TokenSold(msg.sender, address(token), _amount, rate);
    }

    event TokenPurchased(address buyer, address token, uint amount, uint rate);
    event TokenSold(address buyer, address token, uint amount, uint rate);
}