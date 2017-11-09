pragma solidity ^0.4.7;


contract TicTacToeTest {

    address[] players = [0x0, 0x0];

    uint8[3][] board = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];

    uint8 currentTurn = 0;

    uint8 playerCount = 0;

    uint8 MAX_PLAYERS = 2;

    uint256 price = 100;

    uint8 FIELD_SIZE = 3;

    address owner;

    function TicTacToeTest() public {
        owner = msg.sender;
    }

}

