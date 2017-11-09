describe("TicTacToe", function () {

    before(function (done) {
        this.timeout(0);
        EmbarkSpec.deployAll({}, done);
    });

    it("should call constructor", function (done) {

        TicTagToe.MAX_PLAYERS(function (err, result) {
            assert.equal(result.toNumber(), 2);
            done();
        });

        TicTagToe.FIELD_SIZE(function (err, result) {
            assert.equal(result.toNumber(), 3);
            done();
        });

        TicTagToe.currentTurn(function (err, result) {
            assert.equal(result.toNumber(), 0);
            done();
        });

        TicTagToe.playerCount(function (err, result) {
            assert.equal(result.toNumber(), 0);
            done();
        });
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
