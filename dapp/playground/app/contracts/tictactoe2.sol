pragma solidity ^0.4.0;


contract TicTacToe2 {

    enum Token {NONE, X, O}
    Token currentToken = Token.NONE;

    mapping (uint8 => mapping (uint8 => Token)) board;


    function TicTacToe2() public {
        resetGame();
    }

    function resetGame() public {
        currentToken = Token.NONE;
        for (uint x = 0; x < board.length; x++) {
            for (uint y = 0; y < board.length; y++) {
                board[x][y] = Token.NONE;
            }
        }
    }

}
