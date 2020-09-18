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
    property string ctListStore: ""
    property string note: "" // Implementation missing shall show a short text as hint or result

    readonly property int fontSizeSmall: Qt.application.font.pixelSize * 0.8
    readonly property int fontSizeMedium: Qt.application.font.pixelSize * 1.5
    readonly property int fontSizeLarge: Qt.application.font.pixelSize * 2
    readonly property int fontSizeExtraLarge: Qt.application.font.pixelSize * 5

    readonly property int marginSmall: 3
    readonly property int marginNormal: 5
    readonly property int marginBig: 7

    Settings {
        property alias x: root.x
        property alias y: root.y
        property alias width: root.width
        property alias height: root.height
        property alias bagListStore: root.bagListStore
        property alias itemListStore: root.itemListStore
        property alias skillListStore: root.skillListStore
        property alias ctListStore: root.ctListStore
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
                if(skillStore[i].level !== 0 || skillStore[i].mod !== 0 || skillStore[i].comment !== ""){
                    page2.skillView.setSkill(skillStore[i].tal, "level", skillStore[i].level)
                    page2.skillView.setSkill(skillStore[i].tal, "mod", skillStore[i].mod)
                    page2.skillView.setSkill(skillStore[i].tal, "comment", skillStore[i].comment)
                }
            }
        }

        if(ctListStore){
            var ctStore = JSON.parse(ctListStore)
            for(i=0;i<ctStore.length;i++){
                pageCombat.ctList.append(ctStore[i])
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

        var ctStore = []
        for(i=0;i<pageCombat.ctList.count;i++){
            ctStore.push(pageCombat.ctList.get(i))
        }
    }

    menuBar: MenuBar{
        Menu {
            title: qsTr("&File")
            Action {
                text: qsTr("&New")
            }
            Action {
                text: qsTr("&Save")
            }Action {
                text: qsTr("Save &As")
            }
            Action {
                text: qsTr("&Load")
            }
            MenuSeparator{}
            Action{
                text: qsTr("&Quit")
                onTriggered: root.close()
            }
        }

        Menu {
            title: qsTr("&Hero")
            Action{
                text: qsTr("&Import")
                onTriggered: importHeroDialog.visible = true
            }
            Action {
                text: qsTr("&Edit Attributes")
                onTriggered: editAttributesDialog.visible = true
            }
            Action {
                text: qsTr("Edit &Main Attribute")
                onTriggered: getMainAttrDialog.visible = true
                enabled: hero.aeMod >= 0 || hero.keMod >= 0
            }

            Action {
                text: qsTr("&Add Avatar")
                onTriggered: addAvatarDialog.visible = true
            }


        }
        Menu {
            title: qsTr("&Items")
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
    FileDialog {
        id: addAvatarDialog
        title: qsTr("Add an Avatar")
        folder: shortcuts.home
        nameFilters: ["Image files (*.png *.jpg *.gif)"]
        onAccepted: hero.avatar = addAvatarDialog.fileUrl
    }

    AddBagDialog {
        id: addBagDialog
        anchors.centerIn: parent
    }
    EditBagDialog {
        id: editBagDialog
 //       anchors.centerIn: parent
    }
    AddItemDialog {
        id: addItemDialog
        anchors.centerIn: parent
    }
    RollTalentDialog {
        id: rollTalentDialog
//        anchors.centerIn: parent
    }
    EditAttributesDialog {
        id: editAttributesDialog
        anchors.centerIn: parent
    }
    GetMainAttrDialog {
        id: getMainAttrDialog
        anchors.centerIn: parent
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {
            id: page1
        }

        Page2 {
            id: page2
        }
        PageCombat {
            id: pageCombat
        }

        Page3 {
            id: page3
        }

        PageNotes {
            id: pageNotes
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
            text: qsTr("Combat")
        }
        TabButton {
            text: qsTr("Belongings")
        }TabButton {
            text: qsTr("Notes")
        }
    }
}
