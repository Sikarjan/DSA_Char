import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id:root
    width: 400

    title: qsTr("Edit Skill")+" - "+talent.name

    standardButtons: Dialog.Ok | Dialog.Cancel

    property var talent: {"name": "", "level": 0, "modAt":0, "modPa":0, "modHp":0, "notes": ""} //pageCombat.ctList.get(0)

    onVisibleChanged: {
        if(!visible){
            return
        }

        talent = pageCombat.ctList.get(pageCombat.activeSkill)
    }

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Row {
            Label {
                id: firstLabel
                width: 130
                text: qsTr("Skill rate")
            }
            SpinBox {
                id: skillRate
                from:-3
                to: 30
                value: talent.level
            }
        }
        Row {
            Label {
                width: firstLabel.width
                text: qsTr("AT mod")
            }
            SpinBox {
                id: atMod
                from:-3
                to: 30
                value: talent.modAt
            }
        }
        Row {
            Label {
                width: firstLabel.width
                text: qsTr("PA mod")
            }
            SpinBox {
                id: paMod
                from:-3
                to: 30
                value: talent.modPa
            }
        }
        Row {
            Label {
                width: firstLabel.width
                text: qsTr("HP mod")
            }
            SpinBox {
                id: hpMod
                from:-3
                to: 30
                value: talent.modHp
            }
        }
        Row {
            Label {
                width: firstLabel.width
                text: qsTr("Comment")
            }
            TextField {
                id: skillComment
                text: talent.notes
                width: content.width - firstLabel.width - 25
            }
        }
    }
    onAccepted: {
        pageCombat.ctList.setProperty(pageCombat.activeSkill, "level", skillRate.value)
        pageCombat.ctList.setProperty(pageCombat.activeSkill, "modAt", atMod.value)
        pageCombat.ctList.setProperty(pageCombat.activeSkill, "modPa", paMod.value)
        pageCombat.ctList.setProperty(pageCombat.activeSkill, "modHp", hpMod.value)
        pageCombat.ctList.setProperty(pageCombat.activeSkill, "notes", skillComment.text)
    }
}
