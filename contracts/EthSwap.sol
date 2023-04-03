//SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ClaverToken.sol";

contract EthSwap{
    address public owner;
    ClaverToken public token;

    constructor(ClaverToken _token){
        owner = msg.sender;
        token = _token;
    }


    modifier isOwner{
        require(msg.sender == owner, "Insufficient permissions");
        _;
    }
}