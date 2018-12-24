var db;

function initialiseDB() {
    db = LocalStorage.openDatabaseSync("BuyDatabase", "1.0", "Buy SQL Database");

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Buy(Id TEXT, titles TEXT, price TEXT, amount TEXT)');
        //console.log('Database initialized');
    });
}

function removeFromBuy(Id, callback) {
    if (!db) initialiseDB();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Buy WHERE Id=?', [Id]);
        callback();
    });
}

function addToBuy(Id, titles, price,amount,  callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Buy VALUES(?, ?, ?, ?)', [Id, titles, price, amount]);
        callback();
    });
}

function getBuy(callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Buy');
        var model = [];
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i);
            model.push({
                           ID: row.Id,
                           Titles: row.title,
                           Price: row.price,
                           Amount: row.amount
                       });
        }
        callback(model);
    });
}
