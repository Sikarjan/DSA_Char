import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id:root
    width: 400

    title: qsTr("Edit Skill")+" - "+talent.name

    standardButtons: Dialog.Ok | Dialog.Cancel

    property var talent: pageTalents.skillList.get(0)

    onVisibleChanged: {
        if(!visible){
            return
        }

        talent = pageTalents.skillList.get(pageTalents.activeSkill)
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
                text: qsTr("Skill mod")
            }
            SpinBox {
                id: skillMod
                from:-3
                to: 30
                value: talent.mod
            }
        }
        Row {
            Label {
                width: firstLabel.width
                text: qsTr("Comment")
            }
            TextField {
                id: skillComment
                text: talent.comment
                width: content.width - firstLabel.width - 25
            }
        }
    }
    onAccepted: {
        pageTalents.skillList.setProperty(pageTalents.activeSkill, "level", skillRate.value)
        pageTalents.skillList.setProperty(pageTalents.activeSkill, "mod", skillMod.value)
        pageTalents.skillList.setProperty(pageTalents.activeSkill, "comment", skillComment.text)
    }
}
