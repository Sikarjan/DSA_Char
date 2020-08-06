import QtQuick 2.12
import QtQuick.Controls 2.12
import "components"

Page {
    id: page
    width: 600
    height: 400

    header: Label {
        text: qsTr("Belongins")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Column {
        anchors.fill: parent
        anchors.margins: 5

        spacing: 5

        Label {
            text: qsTr("Places")
        }

        ListView {
            width: parent.width
            height: contentHeight
            model: bagList

            header: bagListHeader

            delegate: Row {
                spacing: 3

                Label {
                    text: model.bagName
                    width: 120
                }
                Label {
                    text: model.where
                    width: 40
                }
                Label {
                    text: model.fill + "/" + model.size
                    width: 40
                }
                Label {
                    text: model.weight
                    width: 40
                }
                Label {
                    text: model.price
                    width: 40
                }
            }
        }

        ListView {
            width: parent.width
            height: contentHeight
            model: itemList

            header: itemListHeader
            section.property: "where"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: parent.width
                height: childrenRect.height
                color: "lightsteelblue"

                property string section

                Text {
                    text: parent.section
                    font.bold: true
                }
            }

            delegate: itemListDelegate
        }
    }
}
