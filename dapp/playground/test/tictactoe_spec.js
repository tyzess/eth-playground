var assert = require('assert');
var Embark = require('embark');
var EmbarkSpec = Embark.initTests();
var web3 = EmbarkSpec.web3;

describe("TicTacToe", function () {

    before(function (done) {
        this.timeout(0);
        EmbarkSpec.deployAll({}, done);
    });

    it("should call constructor", function (done) {
        TicTacToe.methods.MAX_PLAYERS().call()
            .then(function (value) {
                assert.equal(value.toNumber(), 2);
            })
            .catch(function (err) {
                assert.equal(err, undefined);
            });
        // TicTacToe.MAX_PLAYERS(function (err, result) {
        //     assert.equal(result.toNumber(), 2);
        //     done();
        // });
        //
        // TicTacToe.FIELD_SIZE(function (err, result) {
        //     assert.equal(result.toNumber(), 3);
        //     done();
        // });
        //
        // TicTacToe.currentTurn(function (err, result) {
        //     assert.equal(result.toNumber(), 0);
        //     done();
        // });
        //
        // TicTacToe.playerCount(function (err, result) {
        //     assert.equal(result.toNumber(), 0);
        //     done();
        // });
    });

    // it("set storage value", function (done) {
    //     SimpleStorage.set(150, function () {
    //         SimpleStorage.get(function (err, result) {
    //             assert.equal(result.toNumber(), 150);
    //             done();
    //         });
    //     });
    // });

});
