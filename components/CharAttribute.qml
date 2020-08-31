import QtQuick 2.0

Item {
    width: 60
    height: 30

    property string propName: ""
    property int propValue: 8
    property int propModValue: 8
    property alias propColor: prop.border.color

    Text {
        id: label
        text: propName
        font.pointSize: Qt.application.font.pixelSize

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 3
    }

    Rectangle {
        id: prop
        border.width: 2
        width: 25
        height: width
        anchors.top: parent.top
        anchors.left: label.right
        anchors.leftMargin: 3

        Text {
            text: propValue
            anchors.centerIn: parent
            font.pointSize: Qt.application.font.pixelSize
        }
    }

    Text {
        text: propModValue
        anchors.top: prop.bottom
        anchors.left: prop.left
        font.pointSize: Qt.application.font.pixelSize - 2
    }
}
