import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id: addBagDialog
    width: 400
    height: 300
    title: qsTr("Add Bag")

    standardButtons: Dialog.Ok | Dialog.Cancel

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Text {
            width: parent.width
            wrapMode: Text.Wrap
            text: qsTr("Adding an item that allows you to carry other items.")
        }
        ComboBox {
            id: bagType
            width: parent.width

            textRole: "text"
            valueRole: "value"
// Data not complete here or correct!
            model: [
                { text: qsTr("Leather Backpack"), value: 50, type: "backpack", weight: 1, price: 17, desc: qsTr("Regular packpack that allows to transport other items.")},
                { text: qsTr("Pouch"), value: 10, type: "bag", weight: 0.25, price: 4, desc: qsTr("Simple linnen bag. Can be carried on a belt or on the back.") },
                { text: qsTr("Shoulder Bag"), value: 30, type: "bag", weight: 1, price: 17, desc: qsTr("")},
                { text: qsTr("Bumbag"), value: 10, type: "bumbag", weight: 0.25, price: 4, desc: qsTr("")  },
                { text: qsTr("Money Pouch"), value: 10, type: "bumbag", weight: 0.25, price: 4, desc: qsTr("")  },
                { text: qsTr("Scabbard"), value: 20, type: "scabbard", weight: 1, price: 17, desc: qsTr("")  },
                { text: qsTr("Dagger Sheath"), value: 10, type: "scabbard", weight: 0.25, price: 5, desc: qsTr("") },
                { text: qsTr("Quiver"), value: 20, type: "quiver", weight: 0.75, price: 15, desc: qsTr("Quiver for 20 arrows or bolds. To be carried on a belt or on the back.") }
            ]

            onCurrentTextChanged: {
                var bagModel = bagType.model

                bagDescription.text = currentText +" | " + qsTr("capacity: ")+ bagModel[currentIndex].value + qsTr(" stone")+"\n"+ bagModel[currentIndex].desc
            }
        }

        ComboBox{
            id: bagCarry
            textRole: "text"
            valueRole: "value"
            width: parent.width/2

            model: [
                { text: qsTr("Body"), value: "body" },
                { text: qsTr("Belt"), value: "belt" },
                { text: qsTr("Backstrap"), value: "backstrap" }
            ]
        }

        Text {
            id: bagDescription
            width: parent.width
            wrapMode: Text.Wrap
        }
    }

    onAccepted: {
        var bagModel = bagType.model
        var bagWeight = bagModel[bagType.currentIndex].weight
        var item = {name: bagType.currentText, gr: bagType.currentValue, type: bagModel[bagType.currentIndex].type, weight: bagWeight, price: bagModel[bagType.currentIndex].price, where: bagCarry.currentText}

        hero.addBag(item)
    }
}
