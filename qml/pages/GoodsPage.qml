import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../DG.js" as DG

Page {
    property var searchList: []

    property var goodsData: ({})
    property string goodsId: ''

    PageHeader { title: qsTr("Добавление товара") }
    Column {
        anchors.centerIn: parent
        width: parent.width

        TextArea {
            id: textAreaTitle
            width: parent.width
            placeholderText: qsTr("Введите название товара")
            label: qsTr("Введите название товара")
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
            text: qsTr("Добавить товар")
            onClicked: addGoods() && pageStack.push(Qt.resolvedUrl("ShowGoods.qml"))
        }
    }
    function addGoods() {
        DG.addToGoods(goodsId, textAreaTitle.text, textAreaPrice.text, textAreaAmount.text);
        DG.getGoods(function(favs) {
            searchList = favs;
                });
    }
}
