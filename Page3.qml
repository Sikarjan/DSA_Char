import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import "components"

Page {
    id: page
    width: 600
    height: 400

    property alias itemWhereMenu: itemWhereMenu
    property alias bagList: bagList
    property alias itemList: itemList

    header: RowLayout {
        spacing: 5
        Layout.margins: 5

        Label {
            text: qsTr("Belongins")
            font.pixelSize: fontSizeLarge
        }


        Rectangle {
            Layout.fillWidth: true
        }

        Column {
            spacing: 2
            Label {
                text: qsTr("Total weight: ") + hero.currentLoad.toFixed(3)
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            }
            Label {
                text: qsTr("Burden by weight: ") + hero.weightBurden
                Layout.rightMargin: 5
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            }
        }
        Rectangle {
            Layout.fillWidth: true
        }

        Label {
            text: qsTr("Purse")
        }
        CharProperty {
            propertyName: qsTr("Ducats")
            propValue: Math.floor(hero.money/1000)
        }
        CharProperty {
            propertyName: qsTr("Silver")
            propValue: Math.floor(hero.money/100).toString().slice(-1)
        }
        CharProperty {
            propertyName: qsTr("Halers")
            propValue: Math.floor(hero.money/10).toString().slice(-1)
        }
        CharProperty {
            width: 45
            propertyName: qsTr("Kreutzers")
            propValue: hero.money.toString().slice(-1)
        }
    }

    Column {
        id: col
        anchors.fill: parent
        anchors.margins: 5

        spacing: 5

        Row {
            spacing: 3
            Label { text: qsTr("Location"); width: 240 }
            Label { text: qsTr("Where"); width: 50 }
            Label { text: qsTr("Level"); width: 100 }
            Label { text: qsTr("Weight"); width: 60 }
            Label { text: qsTr("Price"); width: 50 }
            Label { text: qsTr("Dropped"); width: 50 }
        }
        ListView {
            id: bagListView
            width: parent.width
            height: contentHeight > col.height/2 ? col.height/2:contentHeight
            model: bagList
            clip: true

            delegate: bagListDelegate

            ScrollBar.vertical: ScrollBar {
                active: true
            }
        }

        Rectangle {
            width: parent.width
            height: 2
            color: "darkgray"
        }

        Row {
            spacing: 3
            Label { text: qsTr("Item"); width: 240 }
            Label { text: qsTr("Amount"); width: 80 }
            Label { text: qsTr("Weight"); width: 60 }
            Label { text: qsTr("Price"); width: 50 }
        }
        ListView {
            id: itemListView
            width: parent.width
            height: parent.height - bagListView.height - 2 * parent.spacing - tabBar.height
            spacing: 2
            model: itemList
            clip: true

            section.property: "whereId"
            section.criteria: ViewSection.FullString
            section.delegate: itemListSectionDelegate

            delegate: itemListDelegate

            ScrollBar.vertical: ScrollBar {
                active: true
            }
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
                width: 60
            }
            Label {
                text: model.price
                width: 50
            }
            CheckBox {
                opacity: index > 0
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
            onTriggered: {
                confirmDelete.item = bagList.get(bagList.activeId).bagName
                confirmDelete.task = "bag"
                confirmDelete.visible = true
            }
        }
        MenuItem {
            text: "Info"
            onTriggered: {
                var mItem = bagList.get(bagList.activeId)
                console.log(JSON.stringify(mItem))
            }
        }
    }

    Component {
        id: itemListHeader
        Row {
            spacing: 3
            Label { text: qsTr("Item"); width: 240 }
            Label { text: qsTr("Amount"); width: 80 }
            Label { text: qsTr("Weight"); width: 60 }
            Label { text: qsTr("Price"); width: 50 }
        }
    }
    Component {
        id: itemListDelegate
        Row {
            spacing: 3
            anchors.leftMargin: 2

            Label {
                id: itemNameLabel
                text: model.item
                width: 240
                clip: true
                font.pixelSize: fontSizeMedium

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
                editable: true
                wheelEnabled: true

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
                width: 60
                font.pixelSize: fontSizeMedium
            }
            Label {
                text: model.price
                width: 50
                font.pixelSize: fontSizeMedium
            }
        }
    }

    Component {
        id: itemListSectionDelegate

        Rectangle {
            id: secRect
            width: parent.width
            height: secRow.implicitHeight+4
            color: "lightsteelblue"

            property string label: bagList.get(section).bagName

            Row {
                id: secRow
                anchors.verticalCenter: parent.verticalCenter
                x:2

                Label {
                    text: secRect.label
                    font.bold: true
                    font.pixelSize: Qt.application.font.pixelSize + 3
                    width: 240
                }
                Label { text: qsTr("Amount"); width: 80 }
                Label { text: qsTr("Weight"); width: 60 }
                Label { text: qsTr("Price"); width: 50 }
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
                confirmDelete.item = itemList.get(itemList.selectedIndex).item
                confirmDelete.visible = true
            }
        }
        MenuItem {
            text: "Info"
            onTriggered: {
                var mItem = itemList.get(itemList.selectedIndex)
                console.log(JSON.stringify(mItem))
            }
        }
    }

    MessageDialog {
        id: confirmDelete
        title: qsTr("Confirm delete")
        icon: StandardIcon.Question
        text: qsTr("Are you sure you want to delete %1?\n This cannot be undone.").arg(item)
        standardButtons: StandardButton.Yes | StandardButton.No

        property string item
        property string task: "item"
        onYes: {
            if(task === "item"){
                var item = itemList.get(itemList.selectedIndex)
                var weight = item.weight * item.amount

                bagList.setProperty(item.whereId, "load", bagList.get(item.whereId).load-weight)
                if(item.whereId > 0){
                    bagList.setProperty(0, "load", bagList.get(0).load-weight)
                }

                hero.currentLoad -= weight
                itemList.remove(itemList.selectedIndex);
            }
            else if(task === "bag"){
                for(var i=0;i<itemList.count;i++){
                    var j = itemList.get(i)

                    if(j.whereId === bagList.activeId){
                        itemList.setProperty(i, "whereId", 0)
                    }
                }

                bagList.setProperty(0, "load", bagList.get(0).load-bagList.get(bagList.activeId).weight)
                hero.currentLoad -= bagList.get(bagList.activeId).weight

                bagList.remove(bagList.activeId)
                hero.editItemWhereMenu("new")
                itemList.sortItems()
            }
        }
    }

    ListModel {
        id: bagList

        property int nextId: 1
        property int activeId: -1
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
            var load = get(selectedIndex).weight*get(selectedIndex).amount
            var type = get(selectedIndex).type

            setProperty(selectedIndex, "whereId", bagId)

            if(lastBagId !== 0){
                bagList.setProperty(lastBagId, "load", bagList.get(lastBagId).load - load)
            }

            if(bagId !== 0){
                bagList.setProperty(bagId, "load", bagList.get(bagId).load + load)
            }

            if(type === "armor"){
                var armorType = get(selectedIndex).armorType
console.log("chekcing for armor")
                if(armorType%2 === 0){
                    console.log("changing ini")
                    if(bagId === 0){
                        hero.iniMod -= 1
                        hero.moveMod -= 1
                    }else{
                        hero.iniMod += 1
                        hero.moveMod += 1
                    }
                }
            }

            itemList.sortItems()
        }
    }
}
