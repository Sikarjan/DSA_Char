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
    title: qsTr("DSA Character Sheet")

    property string bagListStore: ""
    property string itemListStore: ""
    property string skillListStore: ""

    Settings {
        property alias x: root.x
        property alias y: root.y
        property alias width: root.width
        property alias height: root.height
        property alias bagListStore: root.bagListStore
        property alias itemListStore: root.itemListStore
        property alias skillListStore: root.skillListStore
        property alias heroFolder: importHeroDialog.folder
    }

    Component.onCompleted: {
        if(bagListStore){
            page3.bagList.clear()

            var bagStore = JSON.parse(bagListStore)
            var bagIdHigh = 0

            for(var i=0;i<bagStore.length; i++){
                page3.bagList.append(bagStore[i])
                if(i>0){
                    hero.addItemWhereMenu(bagStore[i].bagName, bagStore[i].bagId)
                    if(bagStore[i].bagId>bagIdHigh){
                        bagIdHigh = bagStore[i].bagId
                    }
                }
            }
            page3.bagList.nextId = bagIdHigh+1
        }else{
            page3.bagList.append({
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
            page3.itemList.clear()
            var itemStore = JSON.parse(itemListStore)
            for(i=0;i<itemStore.length; i++){
                page3.itemList.append(itemStore[i])
            }
        }

        if(skillListStore){
            var skillStore = JSON.parse(skillListStore)
            for(i=0;i<skillStore.length;i++){
                if(skillStore[i].level !== 0){
                    page2.skillView.setSkill(skillStore[i].tal, "level", skillStore[i].level)
                    page2.skillView.setSkill(skillStore[i].tal, "comment", skillStore[i].comment)
                }
            }
        }
    }

    onClosing: {
        var bagStore = []
        for(var i=0;i<page3.bagList.count;i++){
            bagStore.push(page3.bagList.get(i))
        }
        bagListStore = JSON.stringify(bagStore)

        var itemStore = []
        for(i=0;i<page3.itemList.count;i++){
            itemStore.push(page3.itemList.get(i))
        }
        itemListStore = JSON.stringify(itemStore)

        var skillStore = []
        for(i=0;i<page2.skillList.count;i++){
            skillStore.push(page2.skillList.get(i))
        }
        skillListStore = JSON.stringify(skillStore)
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

        Page2 {
            id:page2
        }

        Page3 {
            id: page3
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
