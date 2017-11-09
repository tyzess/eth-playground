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

        if (playerWon(x, y)) {
            payOutWinner(getCurrentPlayer());
            resetGame();
        }
        else {
            nextTurn();
        }

    }

    function playerWon(x, y) private returns (bool){

    }

    function getPlayerTokenCountFromRow(){

    }

    function payOutWinner(address winner) {
        winner.send(price * 2);
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

