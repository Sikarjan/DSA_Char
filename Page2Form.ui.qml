import QtQuick 2.12
import QtQuick.Controls 2.12
import "components"

Page {
    width: 600
    height: 400

    header: Label {
        text: qsTr("Skills")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Column {
        id: column
        x: 28
        y: 14
        width: 197
        height: 292

        CharTalent {
            id: bodyControl
            talName: qsTr("Body Contol")
            prop1Name: hero.geText
            prop1Value: hero.geMod
            prop2Name: hero.geText
            prop2Value: hero.geMod
            prop3Name: hero.koText
            prop3Value: hero.koMod
            skill: "4"
        }
        CharTalent {
            id: carousing
            talName: qsTr("Carousing")
            prop1Name: hero.kkText
            prop1Value: hero.kkMod
            prop2Name: hero.kkText
            prop2Value: hero.kkMod
            prop3Name: hero.koText
            prop3Value: hero.koMod
            skill: "4"
        }
        CharTalent {
            id: climbing
            talName: qsTr("Climbing")
            prop1Name: hero.muText
            prop1Value: hero.muMod
            prop2Name: hero.geText
            prop2Value: hero.geMod
            prop3Name: hero.kkText
            prop3Value: hero.kkMod
            skill: "4"
        }
        CharTalent {
            id: dancing
            talName: qsTr("Dancing")
            prop1Name: hero.klText
            prop1Value: hero.klMod
            prop2Name: hero.chText
            prop2Value: hero.chMod
            prop3Name: hero.ffText
            prop3Value: hero.ffMod
            skill: "4"
        }
    }
}
