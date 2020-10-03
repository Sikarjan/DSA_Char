import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Dialog {
    id: root
    width: 400

    title: qsTr("Check a telent") + " - " + tal

    standardButtons: Dialog.Ok

    property string tal: ""
    property var talent: page2.skillList.get(0)
    property int labelWidth: 130

    onVisibleChanged: {
        if(!visible){
            return
        }

        talent = page2.skillList.get(page2.activeSkill)
        tal = talent.name

        talCheck.text = hero.getAttr(talent.check)
        ta.text = hero.getAttr(talent.check,2,talent.burden,talent.paralys)
        t.text = hero.getAttr(talent.check,1)

        obstacle.value = hero.getAttr("in",2,talent.burden,talent.paralys)-hero.getAttr("in",1)
    }

    Column {
        anchors.fill: parent
        spacing: 5

        Label {
           text: tal
           font.pixelSize: Qt.application.font.pixelSize * 1.5
        }
        Row {
            spacing: 5
            Label {
                width: root.labelWidth
                text: qsTr("Checking against")
            }
            Label {
                id: talCheck
            }
            Label {
                text: qsTr("ENC: ")+(talent.burden === 0 ? qsTr("No"):(talent.burden === 1 ? qsTr("Yes"):qsTr("maybe")))
            }
            Label {
                text: qsTr("Par: ")+(talent.papralys === 0 ? qsTr("No"):qsTr("Yes"))
            }
        }
        Row {
            spacing: 5
            Label {
                width: root.labelWidth
                text: qsTr("Attribute values")
            }
            Label {
                id: t
            }
            Button {
                anchors.verticalCenter: parent.verticalCenter
                width: t.height -2
                height: width

                Image {
                    anchors.fill: parent
                    source: "qrc:/img/img/dice.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    checkResult.text = hero.rollTalent(talent)
                }
            }
        }
        Row {
            spacing: 5
            Label {
                width: root.labelWidth
                text: qsTr("With current Mods")
            }
            Label {
                id: ta
            }
        }
        Row {
            spacing: 5
            Label {
                width: root.labelWidth
                text: qsTr("Current Skill: ")
            }
            Label {
                text: talent.level
            }
        }
        Row {
            spacing: 5
            Label {
                width: root.labelWidth
                text: qsTr("Skill mod")
            }
            SpinBox {
                id: skillMod
                from: -10
                to: 10
                value: talent.mod
            }
        }

        Row {
            spacing: 5
            Label {
                width: root.labelWidth
                text: qsTr("Obstacle")
            }
            SpinBox {
                id: obstacle
                from:-10
                to:10
                editable: true
            }
            Label {
                text: obstacle.value < 0 ? qsTr("Harder"):obstacle.value > 0 ? qsTr("Easier"):""
            }
        }

        Button {
            width: parent.width - 20
            x:10
            text: qsTr("Check Talent with mods")

            onClicked: checkResult.text = hero.rollTalent(talent, obstacle.value, skillMod.value)
        }
        Text {
            id: checkResult
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize + 2
        }
        Text {
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize + 2
            visible: checkResult.text === ""
            text: qsTr("The obstacle value is added to the modified attribute values.")
        }
    }

    onAccepted: {
        checkResult.text = ""
    }
}
