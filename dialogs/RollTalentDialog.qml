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
        talCheck.text = attrName[attrTest[0]]+"/"+attrName[attrTest[1]]+"/"+attrName[attrTest[2]]

        var attrValue = {
            mu: hero.mu,
            kl: hero.kl,
            in: hero.intu,
            ch: hero.ch,
            ff: hero.ff,
            ge: hero.ge,
            ko: hero.ko,
            kk: hero.kk
        }
        t.text = attrValue[attrTest[0]]+"/"+attrValue[attrTest[1]]+"/"+attrValue[attrTest[2]]

        var attrMod = {
            mu: hero.muMod,
            kl: hero.klMod,
            in: hero.inMod,
            ch: hero.chMod,
            ff: hero.ffMod,
            ge: hero.geMod,
            ko: hero.koMod,
            kk: hero.kkMod
        }
        ta.text = attrMod[attrTest[0]]+"/"+attrMod[attrTest[1]]+"/"+attrMod[attrTest[2]]
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
                    checkResult.text = hero.rollTalent(talent, 0, "attr")
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
                text: qsTr("Obstacle")
            }
            SpinBox {
                id: obstacle
                from:-10
                to:10
                value: 0
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

            onClicked: checkResult.text = hero.rollTalent(talent, obstacle.value)
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
