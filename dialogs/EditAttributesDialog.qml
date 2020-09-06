import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    width: 400

    title: qsTr("Edit Attribute Values")

    standardButtons: Dialog.Ok | Dialog.Cancel

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Grid {
            columns: 2
            spacing: 5

            Label {     text: hero.muText }
            SpinBox {   id: muBox; value: hero.mu }
            Label {     text: hero.klText }
            SpinBox {   id: klBox; value: hero.kl }
            Label {     text: hero.chText }
            SpinBox {   id: chBox; value: hero.ch }
            Label {     text: hero.inText }
            SpinBox {   id: inBox; value: hero.intu }
            Label {     text: hero.ffText }
            SpinBox {   id: ffBox; value: hero.ff }
            Label {     text: hero.geText }
            SpinBox {   id: geBox; value: hero.ge }
            Label {     text: hero.koText }
            SpinBox {   id: koBox; value: hero.ko }
            Label {     text: hero.kkText }
            SpinBox {   id: kkBox; value: hero.kk }
        }
    }

    onAccepted: {
        hero.mu = muBox.value
        hero.kl = klBox.value
        hero.ch = chBox.value
        hero.intu = inBox.value
        hero.ff = ffBox.value
        hero.ge = geBox.value
        hero.ko = koBox.value
        hero.kk = kkBox.value
    }
}
