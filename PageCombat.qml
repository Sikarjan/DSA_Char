import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

import "components"
import "dialogs"
import "components/Globals.js" as Globals

Page {
    id: page
    width: 600
    height: 400

    property alias ctList: combatTalentsList
    property alias combatTalents: combatTalents

    property int activeSkill: 0

    Component.onCompleted: combatTalentsList.sortCombatSkills()

    header: Label {
        anchors.leftMargin: Globals.marginNormal
        text: qsTr("Combat")
        font.pixelSize: Globals.fontSizeBig
    }

    Flickable {
        id: flick
        anchors.fill: parent
        contentHeight: content.height
        clip: true

        ScrollBar.vertical: ScrollBar {
            active: true
        }

        Column {
            id: content
            anchors.fill: parent
            spacing: 5

            ListView {
                id: combatTalents
                width: parent.width
                height: contentHeight

                model: combatTalentsList
                header: combatHead
                delegate: combatDelegate

                function setSkill(tal, prop, level){
                    for(var i=0;i<model.count;i++){
                        if(tal === model.get(i).tal){
                            model.setProperty(i, prop, level)
                            return 1
                        }
                    }
                    return 0
                }
            }
            Rectangle {
                width: parent.width
                height: Globals.marginBig
                // Add some grafical element
            }
            ListView {
                width: parent.width
                height: contentHeight

                model: page3.itemList
                delegate: ccDelegate
            }
            Rectangle {
                width: parent.width
                height: Globals.marginBig
                // Add some grafical element
            }
            ListView {
                width: parent.width
                height: contentHeight

                model: page3.itemList
                delegate: rcDelegate
            }
        }
    }

    Component {
        id: ccDelegate

        Row {
            visible: type === "weapon"
            height: type === "weapon" ? childrenRect.height:0
            spacing: 3

            Label {
                text: item
            }
            Label {
                text: Globals.cts[ct]
            }
            Label {
                text: Globals.cts[ct]+damageBonus
            }
            Label {
                text: damageDice ? damageDice+qsTr("D6+")+damageFlat:""
            }
            Label {
                text: at
            }
            Label {
                text: pa
            }
            Label {
                text: Globals.reach[reach]
            }
        }
    }

    Component {
        id: rcDelegate

        Row {
            visible: type === "rangeWeapon"
            height: type === "weapon" ? childrenRect.height:0
            spacing: 3

            Label {
                text: item
            }
            Label {
                text: damage ? damage:""
            }
        }
    }

    Component {
        id: combatHead

        Row{
            x: Globals.marginNormal
            spacing: 3
            Label {
                width: 250
                text: qsTr("Combat Techniques")
                font.bold: true
                font.pixelSize: Globals.fontSizeNormal + 3
            }
            Text {
                width: 80
                text: qsTr("Primary Attribute")
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                width: 50
                text: qsTr("Impr.")
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                width: 50
                text: qsTr("CSR")
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                width: 50
                text: qsTr("AT/RC")
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                width: 30
                text: qsTr("PA")
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                text: qsTr("Notes")
            }
        }
    }

    Component {
        id: combatDelegate

        Rectangle {
            color: index%2 == 0 ? "lightgray":"white"
            width: page.width
            height: childrenRect.height+2*Globals.marginSmall

            Row {
                x: Globals.marginNormal
                y: Globals.marginSmall
                width: parent.width - 2*Globals.marginNormal
                spacing: 3
//                anchors.verticalCenter: parent.verticalCenter

                Label {
                    width: 250
                    text: Globals.cts[tal]

                    MouseArea {
                        anchors.fill: parent

                        acceptedButtons: Qt.RightButton
                        onClicked: {
                            page.activeSkill = index
                            ctContextMenu.popup()
                        }
                    }
                }
                Label {
                    width: 80
                    text: hero.getAttr(primaryAttr, 0)
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    width: 50
                    text: improve
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    width: 50
                    text: level
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    width: 50
                    text: at
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    width: 30
                    text: pa == "-1" ? "X":pa
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: ((modAt > 0 || modPa > 0) ? ("("+qsTr("At mod")+modAt+"/"+qsTr("Pa mod")+modPa+") "):"") + notes
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                }
            }
        }
    }

    Menu {
        id: ctContextMenu
        MenuItem {
            text: qsTr("Edit skill")
            onTriggered: editCSDialog.open()
        }
    }

    EditCombatSkillDialog {
        id: editCSDialog
        anchors.centerIn: parent
    }


    ListModel {
        id: combatTalentsList

        // Sort items by "name"
        function sortCombatSkills() {
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
            return a.name.localeCompare(b.name)
        }

        ListElement {
            tal: "CT_1"
            level: 6
            at: 6
            pa: -1
            improve: "B"
            primaryAttr: "ff"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_2"
            level: 6
            at: 6
            pa: -1
            improve: "C"
            primaryAttr: "ff"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_3"
            level: 6
            at: 6
            pa: 5
            improve: "B"
            primaryAttr: "ge"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_4"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "ge"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_5"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_6"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_7"
            level: 6
            at: 6
            pa: 5
            improve: "B"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_8"
            level: 6
            at: 6
            pa: 5
            improve: "B"
            primaryAttr: "ge/kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_9"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_10"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "ge/kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_11"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "ge/kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_12"
            level: 6
            at: 6
            pa: 5
            improve: "B"
            primaryAttr: "ff"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_13"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
        ListElement {
            tal: "CT_14"
            level: 6
            at: 6
            pa: 5
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            notes: ""
        }
    }
}
