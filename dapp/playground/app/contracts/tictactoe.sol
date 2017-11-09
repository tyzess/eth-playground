pragma solidity ^0.4.7;


contract TicTacToe {

    int8 version = 1;

    address[] players = [0x0, 0x0];

    uint8[][] board = new uint8[][](3);

    uint8 public MAX_PLAYERS = 2;

    uint8 public FIELD_SIZE = 3;

    uint8 public currentTurn = 0;

    uint8 public playerCount = 0;

    uint256 public price = 100;

    address public owner;

    event NewPlayer(string name, address newPlayer);

    function TicTacToe() public {
        owner = msg.sender;
        resetGame();
    }

    function join() public payable returns (bool){
        if (msg.value != price || allPlayersJoined()) {
            return false;
        }

        players[playerCount] = msg.sender;
        playerCount++;
        if (allPlayersJoined()) {
            currentTurn = 1;
        }
        NewPlayer('player', msg.sender);
        return true;
    }

    function setToken(uint8 x, uint8 y) public returns (bool) {
        if (getCurrentPlayer() != msg.sender) {
            return false;
        }

        if (!isInBounds(x) || !isInBounds(y)) {
            return false;
        }

        if (isAlreadySet(x, y)) {
            return false;
        }

        board[x][y] = currentTurn;

        if (playerWon()) {
            payOutWinner(getCurrentPlayer());
            resetGame();
        }
        else {
            nextTurn();
        }

        return true;
    }

    function playerWon() private view returns (bool){
        for (uint8 row = 0; row < FIELD_SIZE; row++) {
            if (isNeededAmountOfTokensToWin(getPlayerTokenCountFromRow(row))) {
                return true;
            }
        }

        for (uint8 col = 0; col < FIELD_SIZE; col++) {
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

    function getPlayerTokenCountFromRow(uint8 row) private view returns (uint8){
        uint8 count = 0;
        if (isInBounds(row)) {
            for (uint8 col = 0; col < FIELD_SIZE; col++) {
                uint8 token = getToken(col, row);
                if (token == currentTurn) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromCol(uint8 col) private view returns (uint8){
        uint8 count = 0;
        if (isInBounds(col)) {
            for (uint8 row = 0; row < FIELD_SIZE; row++) {
                uint8 token = getToken(col, row);
                if (token == currentTurn) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromDiag1() private view returns (uint8){
        uint8 count = 0;

        uint8 token = getToken(0, 0);
        if (token == currentTurn) {
            count++;
        }

        token = getToken(1, 1);
        if (token == currentTurn) {
            count++;
        }

        token = getToken(2, 2);
        if (token == currentTurn) {
            count++;
        }

        return count;
    }

    function getPlayerTokenCountFromDiag2() private view returns (uint8){
        uint8 count = 0;

        uint8 token = getToken(2, 0);
        if (token == currentTurn) {
            count++;
        }

        token = getToken(1, 1);
        if (token == currentTurn) {
            count++;
        }

        token = getToken(0, 2);
        if (token == currentTurn) {
            count++;
        }

        return count;
    }

    function isNeededAmountOfTokensToWin(uint8 amountOfTokens) private view returns (bool){
        return amountOfTokens == FIELD_SIZE;
    }

    function getToken(uint8 x, uint8 y) public constant returns (uint8){
        if (!isInBounds(x) || !isInBounds(y)) {
            revert();
        }
        return board[x][y];
    }

    function payOutWinner(address winner) private {
        winner.transfer(price * 2);
    }

    function resetGame() private {
        currentTurn = 0;
        players = [0x0, 0x0];
        for (uint i = 0; i < board.length; i++) {
            board[i] = new uint8[](3);
        }
    }

    function isInBounds(uint8 x) private view returns (bool) {
        return x >= 0 && x < FIELD_SIZE;
        //TODO hardcoded
    }

    function isAlreadySet(uint8 x, uint8 y) private view returns (bool){
        return board[x][y] != 0;
    }

    function allPlayersJoined() public constant returns (bool) {
        return playerCount == MAX_PLAYERS;
    }

    function getCurrentPlayer() public constant returns (address) {
        return players[currentTurn];
    }

    function nextTurn() private {
        currentTurn++;
        if (currentTurn > MAX_PLAYERS) {
            currentTurn = 0;
        }
    }

    function killTheBank() public {
        if (msg.sender != owner) {
            revert();
        }
        selfdestruct(owner);
    }

}

