pragma solidity ^0.4.7;


contract Bank {

    mapping (address => uint256) deposits;

    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }

    function withdraw(uint256 value) public payable {
        if (value <= deposits[msg.sender]) {
            msg.sender.transfer(value);
        }
    }

    function balance() public returns (uint256) {
        return deposits[msg.sender];
    }

}