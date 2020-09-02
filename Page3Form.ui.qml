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
            Layout.rightMargin: 5
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
        }
    }

    Column {
        id: col
        anchors.fill: parent
        anchors.margins: 5

        spacing: 5

        Row {
            spacing: 3
            Label { text: qsTr("Location"); width: 240 }
            Label { text: qsTr("Where"); width: 50 }
            Label { text: qsTr("Level"); width: 100 }
            Label { text: qsTr("Weight"); width: 60 }
            Label { text: qsTr("Price"); width: 50 }
            Label { text: qsTr("Dropped"); width: 50 }
        }
        ListView {
            id: bagListView
            width: parent.width
            height: contentHeight > col.height/2 ? col.height/2:contentHeight
            model: bagList

            delegate: bagListDelegate

            ScrollBar.vertical: ScrollBar {
                active: true
            }
        }

        Rectangle {
            width: parent.width
            height: 2
            color: "darkgray"
        }

        Row {
            spacing: 3
            Label { text: qsTr("Item"); width: 240 }
            Label { text: qsTr("Amount"); width: 80 }
            Label { text: qsTr("Weight"); width: 60 }
            Label { text: qsTr("Price"); width: 50 }
        }
        ListView {
            id: itemListView
            width: parent.width
            height: parent.height - bagListView.height - 2 * parent.spacing - tabBar.height
            spacing: 2
            model: itemList
            clip: true

            section.property: "whereId"
            section.criteria: ViewSection.FullString
            section.delegate: itemListSectionDelegate

            delegate: itemListDelegate

            ScrollBar.vertical: ScrollBar {
                active: true
            }
        }
    }
}
