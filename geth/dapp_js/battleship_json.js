battleship_json={ "contract_name": "Battleship", "address": "0xcd0337671f347a5a795bdc305e9af90c298a12b8", "code": "60606040523415600e57600080fd5b603580601b6000396000f3006060604052600080fd00a165627a7a723058203dedf34a7b51e13b7a98210fc61543f1614ebc2f156d95c46cdd79876b0eeea00029", "runtime_bytecode": "6060604052600080fd00a165627a7a723058203dedf34a7b51e13b7a98210fc61543f1614ebc2f156d95c46cdd79876b0eeea00029", "real_runtime_bytecode": "6060604052600080fd00a165627a7a723058203dedf34a7b51e13b7a98210fc61543f1614ebc2f156d95c46cdd79876b0eeea00029", "swarm_hash": "3dedf34a7b51e13b7a98210fc61543f1614ebc2f156d95c46cdd79876b0eeea0", "gas_estimates": { "creation": [ 61, 10600 ], "external": {}, "internal": {} }, "function_hashes": {}, "abi": [] } ; battleship=eth.contract(battleship_json.abi).at(battleship_json.address);