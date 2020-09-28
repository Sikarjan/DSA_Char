import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Dialog {
    id: root
    width: 400

    title: qsTr("Purse")

    standardButtons: Dialog.Ok | Dialog.Cancel

    Column {
        anchors.fill: parent
        anchors.margins: 5

        spacing: 5

        Row {
            Label {
                id: first
                width: 150
                text: qsTr("Silver")
            }
            SpinBox {
                id: silver
                stepSize: 50
                from:hero.money*-1
                to: 999900
                editable: true
                wheelEnabled: true

                property real realValue: value/100

                textFromValue: function(value, locale) {
                    return Number(value / 100).toLocaleString(locale, 'f', 2)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }
        }
        Row {
            Label {
                width: first.width
                text: qsTr("Available")
            }
            Label {
                text: Number(hero.money / 100).toLocaleString(Qt.locale(),'f',2)
            }
        }
    }

    onAccepted: {
        hero.money += silver.value
        silver.value = 0
    }

    onRejected: {
        silver.value = 0
    }
}
