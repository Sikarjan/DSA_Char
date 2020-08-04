import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    property alias talName: talName.text
    property alias prop1Name: prop1.prop1Name
    property alias prop1Value: prop1.prop1Value
    property alias prop2Name: prop2.prop2Name
    property alias prop2Value: prop2.prop2Value
    property alias prop3Name: prop3.prop3Name
    property alias prop3Value: prop3.prop3Value
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
            id: prop1
            width: 25
            text: mArea.containsMouse ? prop1Value:prop1Name
            font.pointSize: talName.font.pointSize

            property string prop1Name
            property int prop1Value
        }
        Label{
            id: prop2
            width: 25
            text: mArea.containsMouse ? prop2Value:prop2Name
            font.pointSize: talName.font.pointSize

            property string prop2Name
            property int prop2Value
        }
        Label{
            id: prop3
            width: 25
            text: mArea.containsMouse ? prop3Value:prop3Name
            font.pointSize: talName.font.pointSize

            property string prop3Name
            property int prop3Value
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
                var res = hero.rollTalent(prop1Value, prop3Value, prop3Value, skill.text*1)
                console.log(res)
            }
        }
    }
}
