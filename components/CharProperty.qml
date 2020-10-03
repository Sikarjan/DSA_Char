import QtQuick 2.0

Item {
    width: 40
    height: 36

    property string propertyName: ""
    property int propValue: 0

    Rectangle {
        width: parent.width
        height: parent.height
        border.color: "black"
        border.width: 1

        Column {
            anchors.fill: parent
            anchors.margins: 3

            Text {
                text: propertyName
                font.pixelSize: fontSizeRegular
            }
            Text {
                width: parent.width -2*x
                text: propValue
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: fontSizeMedium
            }
        }
    }
}
