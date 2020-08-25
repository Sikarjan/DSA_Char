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
            var bagWeigth = bagModel[bagType.currentIndex].weight
            var item = {name: bagType.currentText, gr: bagType.currentValue, type: bagModel[bagType.currentIndex].type, weight: bagWeigth, price: bagModel[bagType.currentIndex].price, where: bagCarry.currentText}

            hero.addBag(item)
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

                TextField {
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
                    stepSize: 50
                    to:10000
                    editable: true

                    property real realValue: value/100

                    validator: DoubleValidator {
                        bottom: Math.min(itemWeight.from, itemWeight.to)
                        top:  Math.max(itemWeight.from, itemWeight.to)
                    }

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
                    text: qsTr("Price")
                    width: 100
                }

                SpinBox {
                    id: itemPrice
                    stepSize: 50
                    to: 100000
                    editable: true

                    property real realValue: value/100

                    validator: DoubleValidator {
                        bottom: Math.min(itemPrice.from, itemPrice.to)
                        top:  Math.max(itemPrice.from, itemPrice.to)
                    }

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
                    valueRole: "bagId"
                    model: bagList
                    width: parent.width - 110
                }
            }
        }

        onAccepted: {
            itemList.append({
                                "item": itemName.text,
                                "amount": itemAmount.value,
                                "weight": itemWeight.realValue,
                                "price": itemPrice.realValue,
                                "where": itemWhere.currentText,
                                "whereId": itemWhere.currentValue // holds bagId
            })
            itemList.sortItems()
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
            leP {
                onValueChanged: hero.le = leP.value // Warum? Da sollte man doch ein Binding machen können
            }
        }

        Page2Form {
        }

        Page3Form {
            ListModel {
                id: bagList

                property int nextId: 1

                Component.onCompleted: {
                    append({
                               "bagId": 0,
                               "bagName": qsTr("Body"),
                               "size": hero.maxLoad,
                               "type": "body",
                               "weight": 0,
                               "price": 0,
                               "load": 0,
                               "where": "-",
                               "dropped": false
                    })
                }

                function moveItem(item){
                    itemList.moveItem(item.bagId)
                }
            }

            Component {
                id: bagListHeader
                Row {
                    spacing: 3
                    Label { text: qsTr("Container"); width: 240 }
                    Label { text: qsTr("Where"); width: 50 }
                    Label { text: qsTr("Level"); width: 100 }
                    Label { text: qsTr("Weight"); width: 50 }
                    Label { text: qsTr("Price"); width: 50 }
                    Label { text: qsTr("Dropped"); width: 50 }
                }
            }

            Component {
                id: bagListDelegate

                Row {
                    spacing: 3

                    Label {
                        text: model.bagName
                        width: 240
                        clip: true
                    }
                    Label {
                        text: model.where
                        width: 50
                    }
                    Label {
                        text: model.load + "/" + model.size
                        width: 100
                    }
                    Label {
                        text: model.weight
                        width: 50
                    }
                    Label {
                        text: model.price
                        width: 50
                    }
                    CheckBox {
                        visible: index > 0
                        checked: model.dropped
                        onToggled: {
                            var factor = checked ? -1:1
                            hero.currentLoad += factor*(model.load + model.weight)
                            bagList.setProperty(0,"load",hero.currentLoad)
                        }
                    }
                }
            }

            ListModel {
                id: itemList

                property int selectedIndex: -1

                // Sort items by "whereId" they are located and then by name
                function sortItems() {
                    let indexes = [...Array(count).keys()]
                    indexes.sort((a,b) => compareFunction(get(a), get(b)))

                    let sorted = 0
                    while (sorted < indexes.length && sorted === indexes[sorted]) sorted++
                    if (sorted === indexes.length) return
                    for (let i = sorted; i < indexes.length; i++) {
                        move(indexes[i], count - 1, 1)
                        insert(indexes[i], { } )
                    }
                    remove(sorted, indexes.length - sorted)
                }
                function compareFunction(a, b){
                    var res = a.whereId - b.whereId

                    if(res === 0){
                        return a.item.localeCompare(b.item)
                    }
                    return res
                }

                function moveItem(bagId){
                    var lastBagId = get(selectedIndex).whereId
                    var newPos = bagList.get(bagId).bagName
                    var load = get(selectedIndex).weight*get(selectedIndex).amount

                    setProperty(selectedIndex, "where", newPos)
                    setProperty(selectedIndex, "whereId", bagId)

                    if(lastBagId !== 0){
                    bagList.setProperty(lastBagId, "load", bagList.get(lastBagId).load - load)
                    }

                    if(bagId !== 0){
                        bagList.setProperty(bagId, "load", bagList.get(bagId).load + load)
                    }

                    itemList.sortItems()
                }
            }

            Component {
                id: itemListHeader
                Row {
                    spacing: 3
                    Label { text: qsTr("Item"); width: 240 }
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
                        width: 240
                        clip: true

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                itemList.selectedIndex = model.index
                                itemMenu.popup()
                            }
                        }
                    }
                    SpinBox {
                        value: model.amount
                        width: 70
                        height: itemNameLabel.height
                        editable: false

                        onValueModified: {
                            var nWeight = (value - model.amount)*model.weight
                            var mLoad = bagList.get(model.whereId).load + nWeight

                            bagList.setProperty(model.whereId, "load", mLoad)
                            hero.currentLoad += nWeight

                            bagList.setProperty(0,"load",hero.currentLoad)

                            model.amount = value
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

            Menu {
                id: itemMenu

                MenuItem {
                    text: qsTr("Move...")
                    onClicked: itemWhereMenu.popup()

                    Menu {
                        id: itemWhereMenu
                        title: qsTr("Location")

                        MenuItem {
                            text: qsTr("Body")
                            onClicked: itemList.moveItem(0)
                        }
                    }
                }
                MenuItem {
                    text: qsTr("Remove")
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
