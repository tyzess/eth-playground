pragma solidity ^0.4.7;


contract TicTacToe {

    address[] players = [0x0, 0x0];
    int8[][] board = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]];

    int8 currentTurn = -1;
    uint8 playerCount = 0;
    final uint8 MAX_PLAYERS = 2;
    uint256 price = 100;

    address owner;

    function TicTacToe(){
        owner = msg.sender;
    }

    function join() constant payable returns (bool){
        if (msg.value != price || allPlayersJoined()) {
            return false;
        }

	//TODO init a countdown and pay funds back if no other player joins

	players[playerCount] = msg.sender;
	playerCount++;
	if(allPlayersJoined()) {
	  currentTurn = 0;
	}
	return true;
    }

    function setToken(uint8 x, uint8 y) returns (bool) {
	if(getCurrentPlayer() != msg.sender) {
	    return false;	
	}

	if(!isInBounds(x) || !isInBounds(y)) {
	    return false;	
	}

	//TODO settoken
	board[x][y] = currentTurn;
	
	nextTurn();
    }

    function isInBounds(uint8 x) private returns () {
	return x >= 0 && x < 3; //TODO hardcoded
    }

    function allPlayersJoined() private returns (bool) {
	return playerCount >= MAX_PLAYERS
    }

    function getCurrentPlayer() private returns (address) {
	return players[currentTurn];
    }

    function nextTurn() private {
	currentTurn++;
	if(currentTurn >= MAX_PLAYERS) {
	   currentTurn = 0;
	}
    }

    function killTheBank() {
	kill(owner);
    }

}

