import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB
import "../WishList.js" as WL
import "../Basket.js" as BS
import "../History.js" as HS

Page {
    property var buyList: []

    id: pageBuy

    SilicaListView {
        onVisibleChanged: if (visible) { loadBuy() }
        id: listView
        model: buyList
        anchors.fill: parent
        header: Column {
            width: parent.width
            PageHeader {
                title: qsTr("История покупок")
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
                    text: 'Title'
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
            }
        }

        VerticalScrollDecorator {}
    }
    function loadBuy() {
        HS.getBuy(function(goods) {
            buyList = goods;
        });
        console.log(sum);

    }
}
