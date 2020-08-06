import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "components"

Page {
    id: page
    width: 600
    height: 400

    header: RowLayout {
        spacing: 5
        Label {
            text: qsTr("Belongins")
            font.pixelSize: Qt.application.font.pixelSize * 2
            padding: 10
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Label {
            anchors.bottom: parent.bottom
            text: qsTr("Carrying Capacity STRx2: ")+hero.kk*2
        }
        Label {
            anchors.bottom: parent.bottom
            text: qsTr("Total weight: ")+bagList.fill
        }
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
                    width: 140
                }
                Label {
                    text: model.where
                    width: 50
                }
                Label {
                    text: model.fill + "/" + model.size
                    width: 50
                }
                Label {
                    text: model.weight
                    width: 50
                }
                Label {
                    text: model.price
                    width: 50
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
