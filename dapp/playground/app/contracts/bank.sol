pragma solidity ^0.4.7;


contract Bank {

    mapping (address => uint256) deposits;

    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }

    function withdraw(uint256 value) public {
        msg.sender.send(deposits[msg.sender]);
    }

}