import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB

Page {
    property var bookData: ({})
    property string bookId: ''
    property bool isFavorited: false

    id: pageInfo

    SilicaFlickable {
        Component.onCompleted: loadBookInfo()
        anchors.fill: parent
        contentHeight: contentColumn.visible ? (contentColumn.height + Theme.horizontalPageMargin * 2) : parent.height

        Column {
            visible: !!bookData.Title

            id: contentColumn
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin * 2
            spacing: 20

            PageHeader {
                title: bookData.Title
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text:'Автор: ' +  bookData.Author
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text:'Жанр: ' +  bookData.Genre
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text:'Цена: ' +  bookData.Price
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text:'Количество : ' +  bookData.Amount
            }
        }

}
    function loadBookInfo() {
        DB.getBooks(function(books) {
            for (var i = 0; i < books.length; i++) {
                console.log(bookId);
                console.log(books[i].bookID)
                console.log(books[i].Title)
                if (bookId == books[i].bookID)
                    bookData = books[i];
            }
            console.log(bookData.Title);
        });
    }
}
