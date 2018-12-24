var db;

function initialiseDB() {
    db = LocalStorage.openDatabaseSync("WishDatabase", "1.0", "Wish SQL Database");

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Wish(Id TEXT, title TEXT, price TEXT)');
        //console.log('Database initialized');
    });
}

function removeFromWish(Id, callback) {
    if (!db) initialiseDB();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Wish WHERE Id=?', [Id]);
        callback();
    });
}

function isInWishList(Id, callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Wish WHERE Id=?', [Id]);
        callback(rs.rows.length > 0);
    });
}

function addToWish(Id, title, price, callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Wish VALUES(?, ?, ?)', [Id, title, price]);
        callback();
    });
}

function getWish(callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Wish');
        var model = [];
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i);
            model.push({
                           ID: row.Id,
                           Title: row.title,
                           Price: row.price
                       });
        }
        callback(model);
    });
}
