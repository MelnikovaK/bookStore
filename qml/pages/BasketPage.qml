import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB
import "../WishList.js" as WL
import "../Basket.js" as BS
import "../History.js" as HS
import "../DG.js" as DG

Page {
    property var basket: []
    property real sum: 0

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
            Button {
                text: qsTr("Купить")
                onClicked: buy()
            }
        }

        Label {
            width: parent.width
            elide: "ElideRight"
            x: Theme.horizontalPageMargin
            text: 'Итого: ' + sum + 'Р'
            anchors.left: parent.left
        }

        VerticalScrollDecorator {}
    }
    function loadBasket() {
        BS.getBasket(function(goods) {
            basket = goods;
            for (var i = 0; i < goods.length; i++) {
                sum += goods[i].Price;
                console.log(goods[i].Price)
            }
        });

    }

    function delBasket(modelData) {
        sum -= modelData.Price;
        BS.removeFromBasket(modelData.ID, function(){});
        loadBasket();
    }

    function buy() {
         HS.addToBuy(bookId, bookData.Title, modelData.Price, modelData.Amount, function(){});
    }
}
