pragma solidity ^0.4.7;


contract Suicide {

    address public owner;

    function Suicide() public {
        owner = msg.sender;
    }

    function kill() onlyByOwner() public {
        selfdestruct(owner);
    }

    modifier onlyByOwner(){
        require(owner == msg.sender);
        _;
    }

}