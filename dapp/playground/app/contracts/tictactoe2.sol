pragma solidity ^0.4.0;


contract TicTacToe2 {

    uint8 BOARD_SIZE = 3;

    enum Token {NONE, X, O}
    Token currentToken = Token.NONE;

    mapping (uint8 => mapping (uint8 => Token)) board;


    function TicTacToe2() public {
        resetGame();
    }

    function resetGame() public {
        currentToken = Token.NONE;
        for (uint8 x = 0; x < BOARD_SIZE; x++) {
            for (uint8 y = 0; y < BOARD_SIZE; y++) {
                board[x][y] = Token.NONE;
            }
        }
    }

}
