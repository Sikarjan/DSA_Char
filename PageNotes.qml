import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 600
    height: 400

    header: Label {
        text: qsTr("Notes")
    }

    Column{
        anchors.fill: parent
        spacing: 5

        Row {
            id: menuRow
            spacing: 3

            Button {
                text: qsTr("Save")
            }
            Button {
                text: qsTr("Load")
            }
            Button {
                text: qsTr("Bold")
                onClicked: {
                    note.selectedText
                }
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height-menuRow.height - parent.spacing

            TextArea {
                id: note

                wrapMode: TextEdit.Wrap
                textFormat: TextEdit.RichText
                selectByMouse: true
                persistentSelection: true
            }
        }
    }
}
