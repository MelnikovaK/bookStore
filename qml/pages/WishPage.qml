import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB
import "../WishList.js" as WL

Page {
    property var goodsWishList: []

    id: pageWish

    SilicaListView {
        onVisibleChanged: if (visible) { loadWish() }
        id: listView
        model: goodsWishList
        anchors.fill: parent
        header: Column {
            width: parent.width
            PageHeader {
                title: qsTr("Список желаний")
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
                    text: qsTr("X")
                    onClicked: delWish(modelData)
                }
            }
            onClicked: pageStack.push(Qt.resolvedUrl("BookInfo.qml"), { bookId: modelData.ID})
        }
        VerticalScrollDecorator {}
    }
    function loadWish() {
        WL.getWish(function(wish) {
            goodsWishList = wish;
        });
    }

    function delWish(modelData) {
        WL.removeFromWish(modelData.ID, function(){});
        loadWish();
    }
}
