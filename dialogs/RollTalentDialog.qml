import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Dialog {
    width: 400

    title: qsTr("Check a telent") + " - " + tal

    standardButtons: Dialog.Ok

    property string tal: ""
    property var talent: page2.skillList.get(0)

    onVisibleChanged: {
        talent = page2.skillList.get(page2.activeSkill)
        tal = talent.name

        var attrTest = talent.check.split(",")
        var attrName = {
            mu: hero.muText,
            kl: hero.klText,
            in: hero.inText,
            ch: hero.chText,
            ff: hero.ffText,
            ge: hero.geText,
            ko: hero.koText,
            kk: hero.kkText
        }
        talCheck.text = qsTr("Check against: ")+ attrName[attrTest[0]]+"/"+attrName[attrTest[1]]+"/"+attrName[attrTest[2]]

    }

    Column {
        anchors.fill: parent
        spacing: 5

        Label {
           text: tal
           font.pixelSize: Qt.application.font.pixelSize * 1.5
        }
        Label {
            id: talCheck
        }
        Label {
            text: qsTr("Current Skill: ") + talent.level
        }

        Button {
            width: parent.width - 20
            x:10
            text: qsTr("Check Talent")

            onClicked: checkResult.text = hero.rollTalent(talent)
        }
        Text {
            id: checkResult
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: Qt.application.font.pixelSize + 2
        }
    }

    onAccepted: {
        checkResult.text = ""
    }
}
