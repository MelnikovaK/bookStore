import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
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
            onClicked: console.log("Button clicked")
        }
    }
}
