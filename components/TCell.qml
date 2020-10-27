import QtQuick 2.15
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    implicitHeight: content.implicitHeight +2
    Layout.alignment: Qt.AlignTop
    color: "transparent"

    property int bgHeight: 0
    property alias text: content.text
    property alias horizontalAlignment: content.horizontalAlignment

    Rectangle {
        width: parent.width
        height: 1
        color: "black"
        anchors.bottom: content.top
    }
    Text {
        id: content
        width: parent.width
        wrapMode: Text.WordWrap
        font.pixelSize: fontSizeRegular
        padding: 3
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        width: parent.width
        height: root.bgHeight
        visible: root.bgHeight >0
        color: "#80d3d3d3"
        z:-1
    }
}
