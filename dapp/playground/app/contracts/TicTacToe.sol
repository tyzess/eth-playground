pragma solidity ^0.4.7;


contract TicTacToe {

    address player1;
    address player2;

    uint256 price = 100;

    address owner;

    function TicTacToe(){
        owner = msg.sender;
    }

    function join() constant payable returns (bool){
        if (msg.value != price) {
            return false;
        }

        if (player1 == 0) {
            player1 = msg.sender();
        }
        else if (player2 == 0) {

        }
    }

}

