var db;

function initialiseDB() {
    db = LocalStorage.openDatabaseSync("BaskDatabase", "1.0", "Bask SQL Database");

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Basket(Id TEXT, title TEXT, price TEXT, amount Text)');
        console.log('Database initialized');
    });
}

function removeFromBasket(Id, callback) {
    if (!db) initialiseDB();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Basket WHERE Id=?', [Id]);
        callback();
    });
}

function isInBasket(Id, callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Basket WHERE Id=?', [Id]);
        callback(rs.rows.length > 0);
    });
}

function addToBasket(Id, title, price, amount, callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Basket VALUES(?, ?, ?, ?)', [Id, title, price, amount]);
        callback();
    });
}

function getBasket(callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Basket');
        var model = [];
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i);
            model.push({
                           ID: row.Id,
                           Title: row.title,
                           Price: row.price,
                           Amount: row.amount
                       });
        }
        callback(model);
    });
}
