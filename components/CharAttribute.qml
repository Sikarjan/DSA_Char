import QtQuick 2.0

Item {
    id: root
    width: 60 * root.height/30
    height: 30

    property string attrName: ""
    property int attrValue: 8
    property int attrModValue: 8
    property alias attrColor: attribute.border.color

    Text {
        id: label
        text: attrName
        font.pointSize: Qt.application.font.pixelSize * root.height/30

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 3
    }

    Rectangle {
        id: attribute
        border.width: 2
        width: 25 * root.height/30
        height: width
        anchors.top: parent.top
        anchors.left: label.right
        anchors.leftMargin: 3

        Text {
            text: attrValue
            anchors.centerIn: parent
            font.pointSize: Qt.application.font.pixelSize * root.height/30
        }
    }

    Text {
        text: attrModValue
        anchors.top: attribute.bottom
        anchors.left: attribute.left
        font.pointSize: (Qt.application.font.pixelSize - 2) * root.height/30
    }
}
