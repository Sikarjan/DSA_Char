import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id: addItemDialog
    width: 400

    title: qsTr("Add Spell")

    standardButtons: Dialog.Ok | Dialog.Cancel

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Row {
            width: parent.width

            Label {
                text: qsTr("Name")
                width: 100
            }

            TextField {
                id: spellName
                width: parent.width-110
            }
        }

        Row {
            width: parent.width
            spacing: 2

            Label {
                text: qsTr("Check")
                width: 100
            }

            ComboBox {
                id: attr1
                width: (parent.width-118)/3
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "mu", text: hero.muText },
                    { value: "kl", text: hero.klText },
                    { value: "intu", text: hero.inText },
                    { value: "ch", text: hero.chText },
                    { value: "ff", text: hero.ffText },
                    { value: "ge", text: hero.geText },
                    { value: "ko", text: hero.koText },
                    { value: "kk", text: hero.kkText },
                ]
            }
            ComboBox {
                id: attr2
                width: (parent.width-110)/3
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "mu", text: hero.muText },
                    { value: "kl", text: hero.klText },
                    { value: "intu", text: hero.inText },
                    { value: "ch", text: hero.chText },
                    { value: "ff", text: hero.ffText },
                    { value: "ge", text: hero.geText },
                    { value: "ko", text: hero.koText },
                    { value: "kk", text: hero.kkText },
                ]
            }
            ComboBox {
                id: attr3
                width: (parent.width-110)/3
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "mu", text: hero.muText },
                    { value: "kl", text: hero.klText },
                    { value: "intu", text: hero.inText },
                    { value: "ch", text: hero.chText },
                    { value: "ff", text: hero.ffText },
                    { value: "ge", text: hero.geText },
                    { value: "ko", text: hero.koText },
                    { value: "kk", text: hero.kkText },
                ]
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Spell Rate")
                width: 100
            }

            SpinBox {
                id: sr
                from: 0
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Cost")
                width: 100
            }

            TextField {
                id: cost
                width: parent.width-110
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Casting Time")
                width: 100
            }

            TextField {
                id: time
                width: parent.width-110
            }
        }
    }
}
