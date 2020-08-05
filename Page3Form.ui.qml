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
            text: qsTr("Containers")
        }

        ListView {
            width: parent.width
            height: contentHeight
            model: bagList

            delegate: Row {
                spacing: 3

                Label {
                    text: model.bagName
                }
                Label {
                    text: model.where
                }
                Label {
                    text: model.fill
                }
                Label {
                    text: model.weight
                }
                Label {
                    text: model.price
                }
            }
        }
    }
}
