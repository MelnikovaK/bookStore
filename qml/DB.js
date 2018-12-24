var db;
var id = 1111;

function initialiseDB() {
    db = LocalStorage.openDatabaseSync("BookDatabase", "1.0", "Book SQL Database");

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Books(bookId TEXT, bookAuthor TEXT, bookTitle TEXT, bookGenre TEXT, bookPrice TEXT, bookAmount TEXT)');
        //console.log('Database initialized');
    });
}

function removeFromBooks(bookId) {
    if (!db) initialiseDB();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Books WHERE bookId=?', [bookId]);
    });

}

function addToBooks(bookId, bookAuthor, bookTitle, bookGenre, bookPrice, bookAmount) {
    if (!db) initialiseDB();
     bookId = (Math.random() * 10).toString();

    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Books VALUES(?, ?, ?, ?, ?, ?)', [bookId, bookAuthor, bookTitle, bookGenre, bookPrice, bookAmount]);
    });
}

function getBooks(callback) {
    if (!db) initialiseDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Books');
        var model = [];
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i);
            model.push({
                           bookID: row.bookId,
                           Author: row.bookAuthor,
                           Title: row.bookTitle,
                           Genre: row.bookGenre,
                           Price: row.bookPrice,
                           Amount: row.bookAmount
                       });
        }
        callback(model);
    });
}
