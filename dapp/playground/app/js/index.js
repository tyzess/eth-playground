/*globals $, SimpleStorage, document*/

// var addToLog = function(id, txt) {
//   $(id + " .logs").append("<br>" + txt);
// };

// ===========================
// Blockchain example
// ===========================
$(document).ready(function() {

  $("#blockchain button.set").click(function() {
    // var value = parseInt($("#blockchain input.text").val(), 10);

    // If web3.js 1.0 is being used
    // if (EmbarkJS.isNewWeb3()) {
    //   SimpleStorage.methods.set(value).send({from: web3.eth.defaultAccount});
    //   addToLog("#blockchain", "SimpleStorage.methods.set(value).send({from: web3.eth.defaultAccount})");
    // } else {
    //   SimpleStorage.set(value);
    //   addToLog("#blockchain", "SimpleStorage.set(" + value + ")");
    // }



      // console.log("button set clicked!");
      // if (typeof web3 !== 'undefined') {
      //     web3 = new Web3(web3.currentProvider);
      // } else {
      //     web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8000"));
      // }
      //
      // console.log("web3 is:" + web3);
      // web3.eth.defaultAccount = web3.eth.accounts[0];
      //
      // var abi = JSON.parse('[ { "constant": false, "inputs": [], "name": "killTheBank", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "playerCount", "outputs": [ { "name": "", "type": "uint8" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "FIELD_SIZE", "outputs": [ { "name": "", "type": "uint8" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "MAX_PLAYERS", "outputs": [ { "name": "", "type": "uint8" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getCurrentPlayer", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "owner", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "price", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [], "name": "join", "outputs": [ { "name": "", "type": "bool" } ], "payable": true, "stateMutability": "payable", "type": "function" }, { "constant": false, "inputs": [ { "name": "x", "type": "uint8" }, { "name": "y", "type": "uint8" } ], "name": "setToken", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "allPlayersJoined", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [ { "name": "x", "type": "uint8" }, { "name": "y", "type": "uint8" } ], "name": "getToken", "outputs": [ { "name": "", "type": "uint8" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "currentTurn", "outputs": [ { "name": "", "type": "uint8" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "inputs": [], "payable": false, "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "name", "type": "string" }, { "indexed": false, "name": "newPlayer", "type": "address" } ], "name": "NewPlayer", "type": "event" } ]');
      // var TicTacToe = new web3.eth.Contract(abi);
      // TicTacToe.options.address.set('0xe6cb4ad4fc6def0d9da5f2d8154ccb91684b45b9');
      //
      // console.log("TicTacToe is:" + TicTacToe);
      // TicTacToe.events.NewPlayer(function(error, result) {
      //     if (!error) {
      //         console.log(result);
      //         $("#playerjoined").html(result[0]+' ('+result[1]+' years old)');
      //     } else
      //         console.log(error);
      // });

      TicTacToe.events.NewPlayer(function(error, result) {
              if (!error) {
                  console.log(result);
                  $("#playerjoined").html(result[0]+' ('+result[1]+' years old)');
              } else
                  console.log(error);
          });
  });

  // $("#blockchain button.get").click(function() {
  //   // If web3.js 1.0 is being used
  //   if (EmbarkJS.isNewWeb3()) {
  //     SimpleStorage.methods.get().call(function(err, value) {
  //       $("#blockchain .value").html(value);
  //     });
  //     addToLog("#blockchain", "SimpleStorage.methods.get(console.log)");
  //   } else {
  //     SimpleStorage.get().then(function(value) {
  //       $("#blockchain .value").html(value.toNumber());
  //     });
  //     addToLog("#blockchain", "SimpleStorage.get()");
  //   }
  // });

});
