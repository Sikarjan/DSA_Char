import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import Qt.labs.settings 1.1
import "components"
import "dialogs"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("DSA Char Sheet")

    property string bagListStore: ""
    property string itemListStore: ""

    Settings {
        property alias x: root.x
        property alias y: root.y
        property alias width: root.width
        property alias height: root.height
        property alias bagListStore: root.bagListStore
        property alias itemListStore: root.itemListStore
        property alias heroFolder: importHeroDialog.folder
    }

    Component.onCompleted: {
        if(bagListStore){
            bagList.clear()
            var bagStore = JSON.parse(bagListStore)
            for(var i=0;i<bagStore.length; i++){
                bagList.append(bagStore[i])
                if(i>0){
                    hero.addItemWhereMenu(bagStore[i].bagName, bagStore[i].bagId)
                }
            }
        }else{
            bagList.append({
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

        if(itemListStore){
            itemList.clear()
            var itemStore = JSON.parse(itemListStore)
            for(i=0;i<itemStore.length; i++){
                itemList.append(itemStore[i])
            }
        }
    }

    onClosing: {
        var bagStore = []
        for(var i=0;i<bagList.count;i++){
            bagStore.push(bagList.get(i))
        }
        bagListStore = JSON.stringify(bagStore)

        var itemStore = []
        for(i=0;i<itemList.count;i++){
            itemStore.push(itemList.get(i))
        }
        itemListStore = JSON.stringify(itemStore)
    }

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
                onTriggered: root.close()
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

    AddBagDialog {
        id: addBagDialog
    }
    EditBagDialog {
        id: editBagDialog
    }
    AddItemDialog {
        id: addItemDialog
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
                property int activeId: -1

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

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                bagList.activeId = index
                                bagContextMenu.popup()
                            }
                        }
                    }
                    Label {
                        text: model.where
                        width: 50
                    }
                    Label {
                        text: model.load.toFixed(3) + "/" + model.size
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

            Menu {
                id: bagContextMenu

                MenuItem {
                    text: qsTr("Edit")
                    onTriggered:  editBagDialog.open()
                }
                MenuItem {
                    text: qsTr("Remove")
                    onTriggered: bagList.remove(bagList.activeId)
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
                    Label { text: qsTr("Amount"); width: 80 }
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
                        font.pixelSize: Qt.application.font.pixelSize*1.8

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                itemList.selectedIndex = model.index
                                var pos = mapToGlobal(mouseX, mouseY)

                                if(root.height - itemMenu.height < pos.y){
                                    itemMenu.popup(Qt.point(pos.x,root.height - itemMenu.height))
                                }

                                itemMenu.popup()
                            }
                        }
                    }
                    SpinBox {
                        value: model.amount
                        width: 80
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
                        font.pixelSize: Qt.application.font.pixelSize*1.8
                    }
                    Label {
                        text: model.price
                        width: 50
                        font.pixelSize: Qt.application.font.pixelSize*1.8
                    }
                }
            }

            Menu {
                id: itemMenu

                MenuItem {
                    text: qsTr("Move...")

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            var pos = mapToGlobal(mouseX, mouseY)

                            if(root.height - itemWhereMenu.height < pos.y){
                                itemWhereMenu.popup(Qt.point(pos.x,root.height - itemMenu.height))
                            }

                            itemWhereMenu.popup()
                        }
                    }

                    Menu {
                        id: itemWhereMenu
                        title: qsTr("Location")

                        MenuItem {
                            text: qsTr("Body")
                            onClicked: itemList.moveItem(0)
                        }

                        onClosed: {
                            itemMenu.close()
                        }
                    }
                }
                MenuItem {
                    text: qsTr("Remove")
                    onTriggered: {
                        var item = itemList.get(itemList.selectedIndex)
                        var weight = item.weight * item.amount

                        bagList.setProperty(item.whereId, "load", bagList.get(item.whereId).load-weight)
                        if(item.whereId > 0){
                            bagList.setProperty(0, "load", bagList.get(0).load-weight)
                        }

                        hero.currentLoad += weight
                        itemList.remove(itemList.selectedIndex);
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
