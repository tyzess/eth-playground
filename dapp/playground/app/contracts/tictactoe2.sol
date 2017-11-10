pragma solidity ^0.4.0;


contract TicTacToe2 {

    uint8 public BOARD_SIZE = 3;

    uint8 public MAX_PLAYERS = 2;

    uint public PRIZE = 100;

    uint public playerCount = 0;

    enum Token {NONE, X, O}
    Token public currentToken = Token.NONE;

    mapping (uint8 => mapping (uint8 => Token)) board;

    mapping (uint => address) tokenToPlayer;

    function getPlayer1() public view returns (address){
        return tokenToPlayer[uint(Token.X)];
    }

    function getPlayer2() public view returns (address){
        return tokenToPlayer[uint(Token.O)];
    }


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

    function join() public payable returns (bool){
        if (msg.value != PRIZE || allPlayersJoined()) {
            return false;
        }

        playerCount++;
        tokenToPlayer[playerCount] = msg.sender;

        if (allPlayersJoined()) {
            currentToken = Token.X;
        }

        return true;
    }

    function allPlayersJoined() public view returns (bool) {
        return playerCount == MAX_PLAYERS;
    }

    //    function setToken(uint8 x, uint8 y) public returns (bool) {
    //
    //        if (!isInBounds(x) || !isInBounds(y)) {
    //            return false;
    //        }
    //
    //        if (isAlreadySet(x, y)) {
    //            return false;
    //        }
    //
    //        board[x][y] = currentTurn;
    //
    //        if (playerWon()) {
    //            payOutWinner(getCurrentPlayer());
    //            resetGame();
    //        }
    //        else {
    //            nextTurn();
    //        }
    //
    //        return true;
    //    }

}
