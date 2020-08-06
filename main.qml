import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import "components"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    menuBar: MenuBar{
        Menu {
            title: qsTr("Hero")
            Action{
                text: qsTr("&Import")
                onTriggered: importHeroDialog.visible = true
            }
            MenuSeparator{}
            Action{
                text: qsTr("&Quit")
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: qsTr("Items")
            Action {
                text: qsTr("&Add Item")
                onTriggered: addItemDialog.open()
            }
            Action {
                text: qsTr("Add &Bag")
                onTriggered: addBagDialog.open()
            }
        }
    }

    FileDialog {
        id: importHeroDialog
        title: qsTr("Import Hero from Optholit")
        folder: shortcuts.home
        defaultSuffix: "json"
        nameFilters: ["Hero Files (*.json)"]
        onAccepted: hero.importHero(importHeroDialog.fileUrl)
    }

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

            bagList.append({
                               "bagName": bagType.currentText,
                               "size": bagType.currentValue,
                               "type": bagModel[bagType.currentIndex].type,
                               "weight": bagModel[bagType.currentIndex].weight,
                               "price": bagModel[bagType.currentIndex].price,
                               "fill": 0,
                               "where": bagCarry.currentText
            })
        }
    }
    Dialog {
        id: addItemDialog
        width: 400
        height: 300
        title: qsTr("Adding Item")

        standardButtons: Dialog.Ok | Dialog.Cancel

        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5

            Row {
                width: parent.width

                Label {
                    text: qsTr("Item")
                    width: 100
                }

                TextInput {
                    id: itemName
                    width: parent.width-110
                }
            }

            Row {
                Label {
                    text: qsTr("Weight")
                    width: 100
                }

                SpinBox {
                    id: itemWeight
                }
            }
            Row {
                Label {
                    text: qsTr("Price")
                    width: 100
                }

                SpinBox {
                    id: itemPrice
                }
            }
            Row {
                Label {
                    text: qsTr("Amount")
                    width: 100
                }

                SpinBox {
                    id: itemAmount
                }
            }
            Row {
                width: parent.width

                Label {
                    text: qsTr("Where")
                    width: 100
                }

                ComboBox {
                    id: itemWhere
                    textRole: "bagName"
                    valueRole: "value"
                    model: bagList
                    width: parent.width - 110
                }
            }
        }

        onAccepted: {
            itemList.append({
                                "item": itemName.text,
                                "amount": itemAmount.value,
                                "weight": itemWeight.value,
                                "price": itemPrice.value,
                                "where": itemWhere.currentText,
                                "whereId": itemWhere.currentIndex
            })
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
            leP {
                onValueChanged: hero.le = leP.value
            }
        }

        Page2Form {
        }

        Page3Form {
            ListModel {
                id: bagList

                ListElement {
                    bagName: qsTr("Body")
                    size: 0
                    type: "body"
                    weight: 0
                    price: 0
                    fill: 0
                    where: qsTr("Body")
                }
            }

            Component {
                id: bagListHeader
                Row {
                    spacing: 3
                    Label { text: qsTr("Container"); width: 120 }
                    Label { text: qsTr("Where"); width: 40 }
                    Label { text: qsTr("Level"); width: 40 }
                    Label { text: qsTr("Weight"); width: 40 }
                    Label { text: qsTr("Price"); width: 40 }
                }
            }

            ListModel {
                id: itemList

                onCountChanged:  {
                    for(var i=0; i<count; i++) {
                        for(var j=0; j<i; j++) {
                            if(get(i).where === get(j).where)
                                move(i,j,1)
                            break
                        }
                    }
                }
            }

            Component {
                id: itemListHeader
                Row {
                    spacing: 3
                    Label { text: qsTr("Item"); width: 140 }
                    Label { text: qsTr("Amount"); width: 70 }
                    Label { text: qsTr("Weight"); width: 50 }
                    Label { text: qsTr("Price"); width: 50 }
                }
            }
            Component {
                id: itemListDelegate
                Row {
                    spacing: 3

                    Label {
                        id: itemNameLabel
                        text: model.item
                        width: 140
                    }
                    SpinBox {
                        value: model.amount
                        width: 70
                        height: itemNameLabel.height
                        editable: false

                        property int lastValue: 0

                        onValueChanged:  {
                            var nWeight = (value - lastValue)*model.weight
                            lastValue = value
                            var fill = bagList.get(model.whereId).fill + nWeight
                            bagList.setProperty(model.whereId, "fill", fill)
                        }
                    }
                    Label {
                        text: model.weight
                        width: 50
                    }
                    Label {
                        text: model.price
                        width: 50
                    }
                }
            }
        }
    }

    Hero{
        id:hero
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Hero")
        }
        TabButton {
            text: qsTr("Skills")
        }
        TabButton {
            text: qsTr("Belongings")
        }
    }
}
