import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    property alias talName: talName.text
    property alias attr1Name: attr1.attr1Name
    property alias attr1Value: attr1.attr1Value
    property alias attr2Name: attr2.attr2Name
    property alias attr2Value: attr2.attr2Value
    property alias attr3Name: attr3.attr3Name
    property alias attr3Value: attr3.attr3Value
    property alias skill: skill.text
    property alias note: note.text

    width: 350
    height: 30

    Row {
        Label{
            id: talName
            width: 100
            font.pointSize: Qt.application.font.pixelSize -2

            MouseArea {
                id: mArea
                anchors.fill: parent
                hoverEnabled: true
            }
        }

        Label{
            id: attr1
            width: 25
            text: mArea.containsMouse ? attr1Value:attr1Name
            font.pointSize: talName.font.pointSize

            property string attr1Name
            property int attr1Value
        }
        Label{
            id: attr2
            width: 25
            text: mArea.containsMouse ? attr2Value:attr2Name
            font.pointSize: talName.font.pointSize

            property string attr2Name
            property int attr2Value
        }
        Label{
            id: attr3
            width: 25
            text: mArea.containsMouse ? attr3Value:attr3Name
            font.pointSize: talName.font.pointSize

            property string attr3Name
            property int attr3Value
        }
        Label{
            id: skill
            width: 25
            font.pointSize: talName.font.pointSize
        }

        Text{
            id: note
            width: 100
            font.pointSize: talName.font.pointSize -2
            wrapMode: Text.Wrap
        }

        Button {
            width: 50
            height: 30
            text: qsTr("roll")
            onClicked: {
                var res = hero.rollTalent(attr1Value, attr3Value, attr3Value, skill.text*1)
                console.log(res)
            }
        }
    }
}
