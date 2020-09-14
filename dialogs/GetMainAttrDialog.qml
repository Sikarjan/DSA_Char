import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id:root
    width: 400

    title: qsTr("Edit Main Attribute")

    standardButtons: Dialog.Ok

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Row {
            Label {
                id: firstLabel
                width: 130
                text: qsTr("Main Attribute")
            }
            ComboBox {
                textRole: "text"
                valueRole: "value"
                model: [
                    {text: hero.muText, value: "mu"},
                    {text: hero.klText, value: "kl"},
                    {text: hero.inText, value: "intu"},
                    {text: hero.chText, value: "ch"},
                    {text: hero.ffText, value: "ff"},
                    {text: hero.geText, value: "ge"},
                    {text: hero.koText, value: "ko"},
                    {text: hero.kkText, value: "kk"}
                ]

                Component.onCompleted: currentIndex = indexOfValue(hero.mainAttr)
                onActivated: hero.mainAttr = currentValue
            }
        }
    }
}
