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
                text: qsTr("Adding an item that allows you to carry other items")
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

                onCurrentIndexChanged: {
                    var bagModel = bagType.model

                    bagDescription.text = currentText+" | " + qsTr("capacity: ")+ currentValue+ qsTr(" stone")+"\n"+ bagModel[currentIndex].desc
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
            text: qsTr("Spells")
        }
    }
}
