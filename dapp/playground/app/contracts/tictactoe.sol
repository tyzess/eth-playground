pragma solidity ^0.4.7;


contract TicTacToe {

    address[] players = [0x0, 0x0];

    int8[][] board = [[- 1, - 1, - 1], [- 1, - 1, - 1], [- 1, - 1, - 1]];

    int8 currentTurn = - 1;

    uint8 playerCount = 0;

    uint8 MAX_PLAYERS = 2;

    uint256 price = 100;

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
            payOutWinner();
            resetGame();
        }
        else {
            nextTurn();
        }

    }

    function playerWon() private returns (bool){
        for (uint8 row = 0; row < 3; row++) {
            if (getPlayerTokenCountFromRow(row) == 3) {
                return true;
            }
        }

        for (uint8 col = 0; col < 3; col++) {
            if (getPlayerTokenCountFromCol(col) == 3) {
                return true;
            }
        }

        if (getPlayerTokenCountFromDiag1() == 3) {
            return true;
        }

        if (getPlayerTokenCountFromDiag2() == 3) {
            return true;
        }

        return false;
    }

    function getPlayerTokenCountFromRow(uint8 row) private returns (uint8){
        uint8 count = 0;
        if (isInBounds(row)) {
            for (uint col = 0; col < 3; col++) {
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
            for (uint row = 0; row < 3; row++) {
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

    function getToken(uint8 x, uint8 y) private returns (int8){
        if (!isInBounds(x) || !isInBounds(y)) {
            return - 1;
        }
        return board[x][y];
    }

    function resetGame() private {
        player1 = 0x0;
        player2 = 0x0;
        currentTurn = - 1;
        board = [[- 1, - 1, - 1], [- 1, - 1, - 1], [- 1, - 1, - 1]];
        players = [0x0, 0x0];
    }

    function isInBounds(uint8 x) private returns (bool) {
        return x >= 0 && x < 3;
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

