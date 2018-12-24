import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB
import "../WishList.js" as WL
import "../Basket.js" as BS
import "../DG.js" as DG

Page {
    property var allList: []

    id: page


    SilicaListView {
        onVisibleChanged: if (visible) { loadData() }
        id: listView
        model: allList
        anchors.fill: parent
        header: Column {
            width: parent.width
            PageHeader {
                title: qsTr("Все товары")
            }
        }
        delegate: BackgroundItem {
            id: delegate
            Item {
                anchors.fill: parent
                Label {
                    width: parent.width - yearLabel.width - Theme.horizontalPageMargin * 3
                    elide: "ElideRight"
                    x: Theme.horizontalPageMargin
                    text: modelData.Title
                    anchors.left: parent.left
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    id: yearLabel
                    text: modelData.Price + 'Р'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: {
                        right: Theme.horizontalPageMargin
                    }
                }
                Button {
                    anchors.right: parent.right
                    width: parent.width/5
                    text: qsTr("Удалить")
                    onClicked: delBook(modelData)
                }
            }
            onClicked: pageStack.push(Qt.resolvedUrl("BookInfo.qml"), { bookId: modelData.bookID})
        }
        VerticalScrollDecorator {}
    }

    function loadData() {
        DB.getBooks(function(books) {
            DG.getGoods(function(goods) {
                allList = books.concat(goods);
            });
        });
    }

    function delBook(modelData) {
        DB.removeFromBooks(modelData.bookID);
        loadDataFromDB();
        WL.removeFromWish(modelData.bookID, function(){});
        BS.removeFromBasket(modelData.bookID, function(){});
    }


}
