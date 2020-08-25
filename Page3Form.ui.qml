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
        Layout.margins: 5

        Label {
            text: qsTr("Belongins")
            font.pixelSize: Qt.application.font.pixelSize * 2
        }

        Label {
            text: qsTr("Total weight: ") + hero.currentLoad.toFixed(3)
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
        }
        Label {
            text: qsTr("Burden by weight: ") + hero.weightBurden
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 5

        spacing: 5

        Label {
            id: colheader
            text: qsTr("Location")
        }

        ListView {
            id: bagListView
            width: parent.width
            height: contentHeight
            model: bagList

            header: bagListHeader

            delegate: bagListDelegate
        }

        ListView {
            id: itemListView
            width: parent.width
            height: parent.height - bagListView.height - colheader.height - 2*parent.spacing
            spacing: 2
            model: itemList
            clip: true

            header: itemListHeader
            section.property: "where"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: parent.width
                height: childrenRect.height
                color: "lightsteelblue"

                required property string section

                Text {
                    text: parent.section
                    font.bold: true
                    font.pixelSize: Qt.application.font.pixelSize+3
                }
            }

            delegate: itemListDelegate

            ScrollBar.vertical: ScrollBar {
                active: true
            }
        }
    }
}
