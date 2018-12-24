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
                Button {
                    width: parent.width/5
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Купить")
                    onClicked: buy()
                }
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
                sum += parseInt(goods[i].Price);
                console.log(goods[i].Title)
            }
        });

    }

    function delBasket(modelData) {
        BS.removeFromBasket(modelData.ID, function(){});
        sum = 0;
        loadBasket();
    }

    function buy() {
        var ids = [];
        var amounts = [];
        var elems = [];
        BS.getBasket(function(goods) {
            elems = goods;
            for (var i = 0; i < goods.length; i++) {
               HS.addToBuy(goods[i].ID, goods[i].Title, goods[i].Price, goods[i].Amount, function(){});
                ids.push(goods[i].ID);
                amounts.push(goods[i].Amount);
            }
        });
        for (var i = 0; i < ids.length; i++) {
            var fl = false;
            DB.getBooks(function(books) {
                for ( var j = 0; j < books.length; j++) {
                    if (books[j].bookID == ids[i]) {
                        console.log('ffff')
                        fl = true;
                        var amount = books[j].Amount;
                        DB.removeFromBooks(ids[i]);
                        amount = parseInt(amount) - parseInt(amounts[i]);
                        if (amount > 0) {
                            DB.addToBooks(elems[i].bookID, elems[i].Author, elems[i].Title, elems[i].Genre, elems[i].Price, amount.toString());
                        }
                    }
                }
            });
        }

        //BS.removeFromBasket(modelData.ID, function(){});
    }
}
