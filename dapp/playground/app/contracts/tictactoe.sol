pragma solidity ^0.4.7;


contract TicTacToe {

    address[] players = [0x0, 0x0];

    int8[][] board = [[- 1, - 1, - 1], [- 1, - 1, - 1], [- 1, - 1, - 1]];

    int8 currentTurn = - 1;

    uint8 playerCount = 0;

    uint8 MAX_PLAYERS = 2;

    uint256 price = 100;

    uint8 FIELD_SIZE = 3;

    address owner;

    function TicTacToe(){
        owner = msg.sender;
    }

    function join() payable returns (bool){
        if (msg.value != price || allPlayersJoined()) {
            return false;
        }

        players[playerCount] = msg.sender;
        playerCount++;
        if (allPlayersJoined()) {
            currentTurn = 0;
        }
        return true;
    }

    function setToken(uint8 x, uint8 y) returns (bool) {
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

    }

    function playerWon() private returns (bool){
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

    function getPlayerTokenCountFromRow(uint8 row) private returns (uint8){
        uint8 count = 0;
        if (isInBounds(row)) {
            for (uint col = 0; col < FIELD_SIZE; col++) {
                int8 token = getToken(col, row);
                if (token == currentTurn) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromCol(uint8 col) private returns (uint8){
        uint8 count = 0;
        if (isInBounds(col)) {
            for (uint row = 0; row < FIELD_SIZE; row++) {
                int8 token = getToken(col, row);
                if (token == currentTurn) {
                    count++;
                }
            }
        }
        return count;
    }

    function getPlayerTokenCountFromDiag1() private returns (uint8){
        uint8 count = 0;

        int8 token = getToken(0, 0);
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

    function getPlayerTokenCountFromDiag2() private returns (uint8){
        uint8 count = 0;

        int8 token = getToken(2, 0);
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

    function isNeededAmountOfTokensToWin(uint8 amountOfTokens) private returns (bool){
        return amountOfTokens == FIELD_SIZE;
    }

    function getToken(uint8 x, uint8 y) private returns (int8){
        if (!isInBounds(x) || !isInBounds(y)) {
            return - 1;
        }
        return board[x][y];
    }

    function payOutWinner(address winner) {
        winner.send(price * 2);
    }

    function resetGame() private {
        currentTurn = - 1;
        board = [[- 1, - 1, - 1], [- 1, - 1, - 1], [- 1, - 1, - 1]];
        players = [0x0, 0x0];
    }

    function isInBounds(uint8 x) private returns (bool) {
        return x >= 0 && x < FIELD_SIZE;
        //TODO hardcoded
    }

    function isAlreadySet(uint x, uint y) private returns (bool){
        return board[x][y] == - 1;
    }

    function allPlayersJoined() private returns (bool) {
        return playerCount >= MAX_PLAYERS;
    }

    function getCurrentPlayer() private returns (address) {
        return players[currentTurn];
    }

    function nextTurn() private {
        currentTurn++;
        if (currentTurn >= MAX_PLAYERS) {
            currentTurn = 0;
        }
    }

    function killTheBank() public {
        if (msg.sender != owner) {
            throw;
        }
        selfdestruct(owner);
    }

}

