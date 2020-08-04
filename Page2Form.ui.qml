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
            id: tal_4
            talName: qsTr("Body Contol")
            attr1Name: hero.geText
            attr1Value: hero.geMod
            attr2Name: hero.geText
            attr2Value: hero.geMod
            attr3Name: hero.koText
            attr3Value: hero.koMod
            skill: "4"
        }
        CharTalent {
            id: tal_14
            talName: qsTr("Carousing")
            attr1Name: hero.kkText
            attr1Value: hero.kkMod
            attr2Name: hero.kkText
            attr2Value: hero.kkMod
            attr3Name: hero.koText
            attr3Value: hero.koMod
            skill: "4"
        }
        CharTalent {
            id: tal_3
            talName: qsTr("Climbing")
            attr1Name: hero.muText
            attr1Value: hero.muMod
            attr2Name: hero.geText
            attr2Value: hero.geMod
            attr3Name: hero.kkText
            attr3Value: hero.kkMod
            skill: "4"
        }
        CharTalent {
            id: tal_11
            talName: qsTr("Dancing")
            attr1Name: hero.klText
            attr1Value: hero.klMod
            attr2Name: hero.chText
            attr2Value: hero.chMod
            attr3Name: hero.ffText
            attr3Value: hero.ffMod
            skill: "4"
        }
    }
}
