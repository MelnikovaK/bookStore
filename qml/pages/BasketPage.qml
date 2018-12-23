import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB
import "../WishList.js" as WL
import "../Basket.js" as BS

Page {
    property var basket: []

    id: pageBasket

    SilicaListView {
        onVisibleChanged: if (visible) { loadBasket() }
        id: listView
        model: basket
        anchors.fill: parent
        header: Column {
            width: parent.width
            PageHeader {
                title: qsTr("Корзина")
            }
        }
        delegate: BackgroundItem {
            id: delegate
            Item {
                anchors.fill: parent
                Label {
                    width: parent.width - priceLabel.width - Theme.horizontalPageMargin * 3
                    elide: "ElideRight"
                    x: Theme.horizontalPageMargin
                    text: modelData.Title
                    anchors.left: parent.left
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    id: priceLabel
                    text: modelData.Price + 'Р' + '   Кол-во:' + modelData.Amount
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: {
                        right: Theme.horizontalPageMargin
                    }
                }
                Button {
                    anchors.right: parent.right
                    width: parent.width/8
                    text: qsTr("X")
                    onClicked: delBasket(modelData)
                }
            }
        }
        VerticalScrollDecorator {}
    }
    function loadBasket() {
        BS.getBasket(function(goods) {
            basket = goods;
        });
    }

    function delBasket(modelData) {
        BS.removeFromBasket(modelData.ID, function(){});
        loadBasket();
    }
}
