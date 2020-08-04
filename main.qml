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
            Text {
                text: qsTr("Adding an item that allows you to carry other items")
            }
            ComboBox {
                id: bagType
                textRole: "text"
                valueRole: "value"

                model: [
                    { text: qsTr("Leather Backpack"), value: 50, type: "backpack", weight: 2 },
                    { text: qsTr("Shoulder Bag"), value: 30, type: "bag", weight: 1  },
                    { text: qsTr("Bumbag"), value: 10, type: "bumbag", weight: 0.5  },
                    { text: qsTr("Scabbard"), value: 20, type: "scabbard", weight: 1  },
                    { text: qsTr("Dagger Sheath"), value: 10, type: "daggerSheath", weight: 0.5 },
                    { text: qsTr("Quiver"), value: 20, type: "quiver", weight: 2 }
                ]
            }
            ComboBox{
                id: bagCarry
                textRole: "text"
                valueRole: "value"

                model: [
                    { text: qsTr("Body"), value: "body" },
                    { text: qsTr("Belt"), value: "belt" },
                    { text: qsTr("Backstrap"), value: "backstrap" }
                ]
            }
        }

        onAccepted: {
            var bagModel = bagType.model
            var type = bagModel[bagType.currentIndex].type

            bagList.append({
                "bagName": bagType.currentText,
                "size": bagType.currentValue,
                "type": type,
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
