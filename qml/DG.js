var db;
var id = 2222

function initialiseDB() {
    db = LocalStorage.openDatabaseSync("GoodsDatabase", "1.0", "Goods SQL Database");

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Goods(goodsId TEXT, goodsTitle TEXT, goodsPrice TEXT, goodsAmount TEXT )');
        console.log('Database initialized');
    });
}

function removeFromGoods(goodsId) {
    if (!db) initialiseDB();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Goods WHERE goodsId=?', [goodsId]);
    });
}

function addToGoods(goodsId, goodsTitle, goodsPrice, goodsAmount) {
    if (!db) initialiseDB();
     goodsId = (Math.random() * 10).toString();

    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Goods VALUES(?, ?, ?, ?)', [goodsId, goodsTitle, goodsPrice, goodsAmount]);
    });
}


function getGoods(callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Goods');
        var model = [];
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i);
            model.push({
                           goodsID: row.goodsId,
                           Title: row.goodsTitle,
                           Price: row.goodsPrice,
                           Amount: row.goodsAmount
                       });
        }
        callback(model);
    });
}
