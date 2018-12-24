import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DG.js" as DG
import "../WishList.js" as WL
import "../Basket.js" as BS

Page {
    property var goodsData: ({})
    property string goodsId: ''
    property bool isInWishList: false

    id: pageInfo

    SilicaFlickable {
        Component.onCompleted: loadGoodsInfo()
        anchors.fill: parent
        contentHeight: contentColumn.visible ? (contentColumn.height + Theme.horizontalPageMargin * 2) : parent.height

        Column {
            //visible: GoodsData.Title

            id: contentColumn
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin * 2
            spacing: 20

            PageHeader {
                title: goodsData.Title
                Button {
                    id: wishButton
                    text: qsTr("<3")
                    y: -10
                    onClicked: toggleWish()
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text:'Цена: ' +  goodsData.Price
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text:'Количество : ' +  goodsData.Amount
            }

            Button {
//                color: Theme.highlightColor
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("В корзину")
                onClicked: addToBasket()
            }
        }

}
    function loadGoodsInfo() {
        DG.getGoods(function(goods) {
            for (var i = 0; i < goods.length; i++) {
                if (goodsId == goods[i].goodsID)
                    goodsData = goods[i];
            }
        });
        if (goodsId) {
            checkWish();
        }
    }

    function checkWish() {
        WL.isInWishList(goodsId, function(wish) {
            isInWishList = wish;
        });
    }

    function toggleWish() {
        if (isInWishList) {
            WL.removeFromWish(goodsId, checkWish);
        } else {
            WL.addToWish(goodsId, goodsData.Title,goodsData.Price, checkWish);
        }
        WL.getWish(function(wish) {
            for (var i = 0; i < wish.length; i++)  {
                console.log(wish[i].Title);
            }
        });
    }
    function addToBasket() {
        var isIn;
        BS.isInBasket(goodsId, function(res){isIn = res;})
        if (isIn) {
            var amount = 0;
            BS.getBasket(function(goods) {
                for( var i = 0; i < goods.length; i++) {
                    if(goodsId == goods[i].ID) {
                        amount = goods[i].Amount;
                        break;
                    }
                }});
            amount = (parseInt(amount) + 1).toString();
            if(amount<=goodsData.Amount) {
            BS.removeFromBasket(goodsId, function(){console.log('Remove!')});
            BS.addToBasket(goodsId, goodsData.Title, goodsData.Price,amount, function(){});}

        } else {
            BS.addToBasket(goodsId, goodsData.Title, goodsData.Price, '1', function() {
            console.log(goodsData.Title)
            });

        }

    }


}

