pragma solidity ^0.4.7;


contract TicTacToe {

    int8 public version = 77;

    address[] players = [0x0, 0x0];

    //uint8[][] board = new uint8[][](3);
    mapping (uint8 => mapping (uint8 => uint8)) board;

    uint8 public MAX_PLAYERS = 2;
    uint8 public FIELD_SIZE = 3;
    uint256 public PRICE = 100;

    uint8 public currentTurn;
    uint8 public playerCount;

    string public errMessage;

    address public owner;

    function clearMessage() public {
        errMessage = "----";
    }

    function TicTacToe() public {
        owner = msg.sender;
        resetGame();
    }

    function join() public payable returns (bool){
        if (msg.value != PRICE || allPlayersJoined()) {
            errMessage = "could not join";
            return false;
        }

        players[playerCount] = msg.sender;
        playerCount++;
        errMessage = "joined!";
        if (allPlayersJoined()) {
            currentTurn = 1;
        }
        return true;
    }

    function setToken(uint8 x, uint8 y) public returns (bool) {
        if (getCurrentPlayer() != msg.sender) {
            errMessage = "Not current player";
            return false;
        }

        if (!isInBounds(x) || !isInBounds(y)) {
            errMessage = "not in bound";
            return false;
        }

        if (isAlreadySet(x, y)) {
            errMessage = "already set";
            return false;
        }

        board[x][y] = currentTurn;
        errMessage = "board set";

        if (false) {// (playerWon()) {
            errMessage = "won";
            payOutWinner(getCurrentPlayer());
            resetGame();
        }
        else {
            errMessage = "next turn";
            nextTurn();
        }

        return true;
    }

    function playerWon() private view returns (bool){
        for (uint8 i = 0; i < FIELD_SIZE; i++) {
            uint8 countRow = 0;
            uint8 countColumn = 0;
            for (uint8 j = 0; j < FIELD_SIZE; j++) {
                if (getToken(i, j) == currentTurn) {
                    countRow++;
                }
                if (getToken(j, i) == currentTurn) {
                    countColumn++;
                }
                if(countRow >= FIELD_SIZE || countColumn >= FIELD_SIZE) {
                    return true;
                }
            }
        }

        if(getToken(0, 0) == currentTurn && getToken(1, 1) == currentTurn && getToken(2, 2) == currentTurn) {
            return true;
        }

        if(getToken(2, 0) == currentTurn && getToken(1, 1) == currentTurn && getToken(0, 2) == currentTurn) {
            return true;
        }

        return false;
    }

    function getToken(uint8 x, uint8 y) public constant returns (uint8){
        if (!isInBounds(x) || !isInBounds(y)) {
            revert();
        }
        return board[x][y];
    }

    function payOutWinner(address winner) private {
        winner.transfer(PRICE * 2);
    }

    function resetGame() public {
        currentTurn = 0;
        playerCount = 0;
        players = [0x0, 0x0];
        for (uint i = 0; i < FIELD_SIZE; i++) {
            for (uint j = 0; j < FIELD_SIZE; j++) {
                board[i][j] = 0;
            }
        }
    }

    function isInBounds(uint8 x) private view returns (bool) {
        return x >= 0 && x < FIELD_SIZE;
    }

    function isAlreadySet(uint8 x, uint8 y) private view returns (bool){
        return board[x][y] != 0;
    }

    function allPlayersJoined() public view returns (bool) {
        return playerCount == MAX_PLAYERS;
    }

    function getCurrentPlayer() public view returns (address) {
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

