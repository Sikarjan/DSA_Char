import QtQuick 2.0

Item {
    width: height
    height: 30

    property string propertyName: ""
    property int propValue: 0

    Rectangle {
        width: parent.width
        height: parent.height
        border.color: "black"
        border.width: 2

        Column {
            anchors.fill: parent
            spacing: 2
            x: 1

            Text {
                text: propertyName
                font.pixelSize: fontSizeSmall
            }
            Text {
                width: parent.width -2*x
                text: propValue
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
