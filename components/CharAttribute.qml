import QtQuick 2.0

Item {
    width: 60
    height: 30

    property string attrName: ""
    property int attrValue: 8
    property int attrModValue: 8
    property alias attrColor: attribute.border.color

    Text {
        id: label
        text: attrName
        font.pointSize: Qt.application.font.pixelSize

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 3
    }

    Rectangle {
        id: attribute
        border.width: 2
        width: 25
        height: width
        anchors.top: parent.top
        anchors.left: label.right
        anchors.leftMargin: 3

        Text {
            text: attrValue
            anchors.centerIn: parent
            font.pointSize: Qt.application.font.pixelSize
        }
    }

    Text {
        text: attrModValue
        anchors.top: attribute.bottom
        anchors.left: attribute.left
        font.pointSize: Qt.application.font.pixelSize - 2
    }
}
