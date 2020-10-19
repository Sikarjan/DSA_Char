import QtQuick 2.15
import QtQuick.Layouts 1.3

Rectangle {
    height: content.contentHeight+2*content.padding+2
    color: highlight ? "#80d3d3d3":"transparent"

    property bool highlight: false
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
}
