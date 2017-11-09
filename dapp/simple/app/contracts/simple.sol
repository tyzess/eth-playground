pragma solidity ^0.4.7;


contract Simple {

    uint256 balance = 0;

    function getBalance() public returns (uint256) {
        return balance;
    }

    function deposit() public payable {
        balance += msg.value;
    }

    function withdrawAll() public payable {
        msg.sender.transfer(balance);
    }


}