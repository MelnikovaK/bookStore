import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB

Page {

    property var searchList: []

    property var bookData: ({})
    property string bookId: ''

    PageHeader { title: qsTr("Добавление книги") }
    Column {
        anchors.centerIn: parent
        width: parent.width

        TextArea {
            id: textAreaAuthor
            width: parent.width
            placeholderText: qsTr("Введите фамилию автора")
            label: qsTr("Введите фамилию автора")
        }
        TextArea {
            id: textAreaTitle
            width: parent.width
            placeholderText: qsTr("Введите название")
            label: qsTr("Введите название")
        }
        TextArea {
            id: textAreaGenre
            width: parent.width
            placeholderText: qsTr("Введите жанр")
            label: qsTr("Введите жанр")
        }
        TextArea {
            id: textAreaPrice
            width: parent.width
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            placeholderText: qsTr("Введите цену")
            label: qsTr("Введите цену")
        }
        TextArea {
            id: textAreaAmount
            width: parent.width
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            placeholderText: qsTr("Введите количество")
            label: qsTr("Введите количество")
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Добавить книгу")
            onClicked: addBook() && pageStack.push(Qt.resolvedUrl("ShowBooks.qml"))
        }
    }
    function addBook() {
        DB.addToBooks(bookId, textAreaAuthor.text, textAreaTitle.text, textAreaGenre.text, textAreaPrice.text, textAreaAmount.text);
        DB.getBooks(function(favs) {
            searchList = favs;
                });
    }
}

