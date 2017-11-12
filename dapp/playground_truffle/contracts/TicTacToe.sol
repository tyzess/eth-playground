pragma solidity ^0.4.0;


contract TicTacToe {

    uint8 public BOARD_SIZE = 3;

    uint8 public MAX_PLAYERS = 2;

    uint public PRIZE = 100;

    uint public playerCount = 0;

    uint public gameNumber = 0;

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


    function TicTacToe() public {
        resetGame();
    }

    function resetGame() public {
        currentToken = Token.NONE;
        for (uint8 x = 0; x < BOARD_SIZE; x++) {
            for (uint8 y = 0; y < BOARD_SIZE; y++) {
                board[x][y] = Token.NONE;
            }
        }
        playerCount = 0;
        tokenToPlayer[uint(Token.X)] = 0x0;
        tokenToPlayer[uint(Token.O)] = 0x0;
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

        if (playerWon()) {
            payOutWinner(getCurrentPlayer());
            resetGame();}
        else {
            nextTurn();
        }


        return true;
    }

    function getCurrentPlayer() public constant returns (address) {
        return tokenToPlayer[uint(currentToken)];
    }

    function nextTurn() private {
        uint token = uint(currentToken);
        token++;
        if (token > MAX_PLAYERS) {
            token = uint(Token.X);
        }

        currentToken = Token(token);
    }

    function isInBounds(uint8 i) private view returns (bool) {
        return i < BOARD_SIZE;
    }

    function isAlreadySet(uint8 x, uint8 y) private view returns (bool){
        return board[x][y] != Token.NONE;
    }

    function getToken(uint8 x, uint8 y) public view returns (uint){
        if (!isInBounds(x) || !isInBounds(y)) {
            return uint(Token.NONE);
        }
        return uint(board[x][y]);
    }

    function getPlayerTokenCountFromRow(uint8 row) private view returns (uint8){
        uint8 count = 0;
        if (isInBounds(row)) {
            for (uint8 col = 0; col < BOARD_SIZE; col++) {
                uint token = getToken(col, row);
                if (isTokenValueEqualsCurrentToken(token)) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromCol(uint8 col) private view returns (uint8){
        uint8 count = 0;
        if (isInBounds(col)) {
            for (uint8 row = 0; row < BOARD_SIZE; row++) {
                uint token = getToken(col, row);
                if (isTokenValueEqualsCurrentToken(token)) {
                    count++;
                }
            }
        }
        return count;
    }

    function isTokenValueEqualsCurrentToken(uint token) private view returns (bool){
        return token == uint(currentToken);
    }

    function getPlayerTokenCountFromDiag1() private view returns (uint8){
        uint8 count = 0;

        if (isTokenValueEqualsCurrentToken(getToken(0, 0))) {
            count++;
        }

        if (isTokenValueEqualsCurrentToken(getToken(1, 1))) {
            count++;
        }

        if (isTokenValueEqualsCurrentToken(getToken(2, 2))) {
            count++;
        }

        return count;
    }

    function getPlayerTokenCountFromDiag2() private view returns (uint8){
        uint8 count = 0;

        if (isTokenValueEqualsCurrentToken(getToken(2, 0))) {
            count++;
        }

        if (isTokenValueEqualsCurrentToken(getToken(1, 1))) {
            count++;
        }


        if (isTokenValueEqualsCurrentToken(getToken(0, 2))) {
            count++;
        }

        return count;
    }

    function playerWon() private view returns (bool){
        for (uint8 row = 0; row < BOARD_SIZE; row++) {
            if (isNeededAmountOfTokensToWin(getPlayerTokenCountFromRow(row))) {
                return true;
            }
        }

        for (uint8 col = 0; col < BOARD_SIZE; col++) {
            if (isNeededAmountOfTokensToWin(getPlayerTokenCountFromCol(col))) {
                return true;
            }
        }

        if (isNeededAmountOfTokensToWin(getPlayerTokenCountFromDiag1())) {
            return true;
        }

        if (isNeededAmountOfTokensToWin(getPlayerTokenCountFromDiag2())) {
            return true;
        }

        return false;
    }

    function isNeededAmountOfTokensToWin(uint8 amountOfTokens) private view returns (bool){
        return amountOfTokens == BOARD_SIZE;
    }

    function payOutWinner(address winner) private {
        gameNumber++;
        winner.transfer(PRIZE * 2);
    }

}
