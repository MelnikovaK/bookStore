import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DG.js" as DG
import "../WishList.js" as WL
import "../Basket.js" as BS

Page {
    property var searchList: []

    id: page


    SilicaListView {
        onVisibleChanged: if (visible) { loadDataFromDG() }
        id: listView
        model: searchList
        anchors.fill: parent
        header: Column {
            width: parent.width
            PageHeader {
                title: qsTr("Список товаров")
            }
            Row {
                width: parent.width
                TextField {
                    id: searchTextField
                    width: parent.width - searchButton.width
                    placeholderText: "Найти товар..."
                }
                Button {
                    id: searchButton
                    text: qsTr("Поиск")
                    y: -10
                    onClicked: findGoods(searchTextField.text)
                }
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
                    onClicked: delGoods(modelData)
                }
            }
            onClicked: pageStack.push(Qt.resolvedUrl("GoodsInfo.qml"), { goodsId: modelData.goodsID})
        }
        VerticalScrollDecorator {}
    }

    function loadDataFromDG() {
        DG.getGoods(function(goods) {
            searchList = goods;
        });
    }

    function delGoods(modelData) {
        DG.removeFromGoods(modelData.goodsID);
        loadDataFromDG();
        WL.removeFromWish(modelData.goodsID, function(){});
        BS.removeFromBasket(modelData.goodsID, function(){});
    }

    function findGoods(name) {
        DB.getBooks(function(books) {
            searchList = searchList.filter(function(x) {if(x.Title == name) return x;});

        });
    }


}
