import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DB.js" as DB
import "../WishList.js" as WL
import "../Basket.js" as BS

Page {
    property var bookData: ({})
    property string bookId: ''
    property bool isInWishList: false

    id: pageInfo

    SilicaFlickable {
        Component.onCompleted: loadBookInfo()
        anchors.fill: parent
        contentHeight: contentColumn.visible ? (contentColumn.height + Theme.horizontalPageMargin * 2) : parent.height

        Column {
            visible: bookData.Title

            id: contentColumn
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin * 2
            spacing: 20

            PageHeader {
                title: bookData.Title
                Button {
                    id: wishButton
                    text: qsTr("<3")
                    y: -10
                    onClicked: toggleWish()
                }
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

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("В корзину")
                onClicked: addToBasket()
            }
        }

}
    function loadBookInfo() {
        DB.getBooks(function(books) {
            for (var i = 0; i < books.length; i++) {
                if (bookId == books[i].bookID)
                    bookData = books[i];
            }
        });
        if (bookId) {
            checkWish();
        }
    }

    function checkWish() {
        WL.isInWishList(bookId, function(wish) {
            isInWishList = wish;
        });
    }

    function toggleWish() {
        if (isInWishList) {
            WL.removeFromWish(bookId, checkWish);
        } else {
            WL.addToWish(bookId, bookData.Title,bookData.Price, checkWish);
        }
        WL.getWish(function(wish) {
            for (var i = 0; i < wish.length; i++)  {
                console.log(wish[i].Title);
            }
        });
    }
    function addToBasket() {
        var isIn;
        BS.isInBasket(bookId, function(res){isIn = res;})
        if (isIn) {
            var amount = 0;
            var price = 0;
            BS.getBasket(function(goods) {
                for( var i = 0; i < goods.length; i++) {
                    if(bookId == goods[i].ID) {
                        amount = goods[i].Amount;
                        price = goods[i].Price;
                        break;
                    }
                }});
            amount = (parseInt(amount) + 1).toString();
            price = (parseInt(price) + parseInt(bookData.Price)).toString();
            if(parseInt(amount) <= parseInt(bookData.Amount)) {
                BS.removeFromBasket(bookId, function(){console.log('Remove!')});
                BS.addToBasket(bookId, bookData.Title, price, amount, function(){});}
            } else {
            BS.addToBasket(bookId, bookData.Title, bookData.Price, '1', function() {
            console.log(bookData.Title)
            });

        }

    }


}
