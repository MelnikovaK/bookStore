import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0


Page {
    id: mainpage
    SilicaListView {
        header: PageHeader { title: qsTr("Main Page") }
        anchors.fill: parent
        delegate: ListItem {
            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.name
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl(model.page + ".qml"));
            }
        }
        section {
            criteria: ViewSection.FullString
            delegate: SectionHeader { text: section }
        }
        model: ListModel {
            ListElement {
                name: qsTr("Посмореть товары")
                page: "ShowGoods"
            }
            ListElement {
                name: qsTr("Добавить книгу")
                page: "BookPage"
            }
            ListElement {
                name: qsTr("Добавить товар")
                page: "GoodsPage"
            }

            ListElement {
                name: qsTr("Все товары")
                page: "AllGoodsPage"
            }

            ListElement {
                name: qsTr("Корзина")
                page: "BasketPage"
            }

        }
        VerticalScrollDecorator { }
    }
}
