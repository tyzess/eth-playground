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

    function join() public payable {
        if (msg.value != PRIZE || allPlayersJoined()) {
            revert();
        }

        playerCount++;
        tokenToPlayer[playerCount] = msg.sender;

        if (allPlayersJoined()) {
            currentToken = Token.X;
        }
    }

    function allPlayersJoined() public view returns (bool) {
        return playerCount == MAX_PLAYERS;
    }

    function setToken(uint8 x, uint8 y) public returns (bool) {

        if (!isInBounds(x) || !isInBounds(y)) {
            return false;
        }

        if (isAlreadySet(x, y)) {
            return false;
        }

        board[x][y] = currentToken;

        nextTurn();


        return true;
    }

    function nextTurn() private {
        uint token = uint(currentToken);
        token++;
        if (token > MAX_PLAYERS) {
            token = uint(Token.X);
        }

        currentToken = Token(token);
    }

    function isInBounds(uint8 i) private returns (bool) {
        return i < BOARD_SIZE;
    }

    function isAlreadySet(uint8 x, uint8 y) private returns (bool){
        return board[x][y] != Token.NONE;
    }

    function getToken(uint8 x, uint8 y) public view returns (uint){
        if (!isInBounds(x) || !isInBounds(y)) {
            revert();
        }
        return uint(board[x][y]);
    }

    function getPlayerTokenCountFromRow(uint8 row) private returns (uint8){
        uint8 count = 0;
        if (isInBounds(row)) {
            for (uint8 col = 0; col < FIELD_SIZE; col++) {
                uint token = getToken(col, row);
                if (token == uint(currentToken)) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromCol(uint8 col) private returns (uint8){
        uint8 count = 0;
        if (isInBounds(col)) {
            for (uint8 row = 0; row < FIELD_SIZE; row++) {
                uint token = getToken(col, row);
                if (token == uint(currentToken)) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromDiag1() private returns (uint8){
        uint8 count = 0;

        uint token = getToken(0, 0);
        if (token == uint(currentToken)) {
            count++;
        }

        token = getToken(1, 1);
        if (token == uint(currentToken)) {
            count++;
        }

        token = getToken(2, 2);
        if (token == uint(currentToken)) {
            count++;
        }

        return count;
    }

    function getPlayerTokenCountFromDiag2() private returns (uint8){
        uint8 count = 0;

        uint token = getToken(2, 0);
        if (token == uint(currentToken)) {
            count++;
        }

        token = getToken(1, 1);
        if (token == uint(currentToken)) {
            count++;
        }

        token = getToken(0, 2);
        if (token == uint(currentToken)) {
            count++;
        }

        return count;
    }

}
