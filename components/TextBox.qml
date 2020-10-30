import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    border.color: "black"
    border.width: 2
    radius: 5
    height: childrenRect.height+10

    property alias text: area.text
    property alias placeholderText: area.placeholderText
    property alias title: title.text

    Column {
        width: parent.width -10
        x:5
        y:5
        spacing: 2

        Label {
            id: title
        }
        TextArea {
            id: area
            width: parent.width
            selectByMouse: true
            selectByKeyboard: true
            textMargin: 2
            wrapMode: TextEdit.Wrap
            background: null
        }
    }
}
