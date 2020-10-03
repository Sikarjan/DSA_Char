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

    property alias ctList: ctList
    property alias combatTalents: combatTalents

    property int activeSkill: 0

    Component.onCompleted: {
        ctList.sortCombatSkills()
        console.log("page: "+page.height+" flick: "+flick.height+" content: "+content.height)
    }

    header: RowLayout {
        spacing: marginNormal
        Label {
            anchors.leftMargin: marginNormal
            text: qsTr("Combat")
            font.pixelSize: fontSizeLarge
        }
        Rectangle {
            Layout.fillWidth: true
        }
        Row {
            spacing: 2
            Label {
                text: qsTr("LP")
            }

            SpinBox {
                editable: true
                wheelEnabled: true
                enabled: true
                font.pointSize: 10
                value: hero.le
                from: -10
                to: hero.leMax

                onValueModified: hero.le = value
            }
        }

        CharProperty {
            propertyName: qsTr("Mov")
            propValue: hero.move-hero.stateModMove
        }
        CharProperty {
            propertyName: qsTr("Ini")
            propValue: hero.iniBase+hero.iniMod-hero.burden
        }
        CharProperty {
            propertyName: qsTr("Do")
            propValue: hero.dodge
        }
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

                model: ctList
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
                height: marginBig
                // Add some grafical element
            }
            ListView {
                width: parent.width
                height: contentHeight

                model: page3.itemList
                delegate: ccDelegate
                header: ccHead
            }
            Rectangle {
                width: parent.width
                height: marginBig
                // Add some grafical element
            }
            ListView {
                width: parent.width
                height: contentHeight

                model: page3.itemList
                delegate: rcDelegate
                header:  rcHead
            }
            Rectangle {
                width: parent.width
                height: marginBig
                // Add some grafical element
            }
            ListView {
                id: armorList
                width: parent.width
                height: contentHeight

                model: page3.itemList
                delegate: armorDelegate
                header:  armorHead
            }
        }
    }

    Component {
        id: ccHead

        Row {
            spacing: 3

            Label {
                text: qsTr("Weapon")
                width: 150
            }
            Label {
                text: qsTr("Combat Technique")
                width: 150
            }
            Text {
                text: qsTr("Damage Bonus")
                width: 80
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Damage")
                width: 60
            }
            Text {
                text: qsTr("Damage Total")
                width: 60
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("At/Pa Mod")
                width: 100
            }
            Label {
                text: qsTr("Reach")
                width: 100
            }
            Label {
                text: qsTr("At")
                width: 60
            }
            Label {
                text: qsTr("Pa")
                width: 60
            }
        }
    }

    Component {
        id: ccDelegate

        Row {
            visible: type === "weapon"
            height: type === "weapon" ? childrenRect.height:0
            spacing: 3

            property var ctSkill: ctList.getCT(ct)

            Label {
                text: item
                width: 150
            }
            Label {
                text: ct ? ctSkill.name:""
                width: 150
            }
            Label {
                text: ct ? hero.getAttr(ctSkill.primaryAttr,0)+damageBonus:""
                width: 80
            }
            Label {
                text: damageDice ? damageDice+qsTr("D6+")+damageFlat:""
                width: 60
            }
            Label {
                text: damageDice ?
                          damageDice+qsTr("D6+")+
                          (damageFlat+
                          ctSkill.modHp+
                          ((hero.getMainCtAttrValue(ctSkill.primaryAttr) > damageBonus ? hero.getMainCtAttrValue(ctSkill.primaryAttr)-damageBonus:0)))
                        :""
                width: 60
            }

            Label {
                text: at ? at+"/"+pa:""
                width: 100
            }
            Label {
                text: reach ? Globals.reach[reach]:""
                width: 100
            }
            Label {
                text: ct ?
                          ctSkill.modAt+    // Mod by talent e.g. one-handed
                          at+               // Mod by weapon
                          ctSkill.level+    // Basic attack
                          Math.floor((hero.mu-8)/3)-    // Bonus from courage
                          hero.attrMods     // Mod by current states
                        :""
                width: 60
            }
            Label {
                text: ct ?
                          ctSkill.modPa+ // Mod by talent e.g. one-handed
                          pa+            // Mod by weapon
                          Math.round(ctSkill.level/2)+    // Basic parade
                          Math.floor((hero.getMainCtAttrValue(ctSkill.primaryAttr)-8)/3)- // Bonus from main attribute
                          hero.attrMods  // Mod by current states
                        :""
                width: 60
            }
        }
    }

    Component {
        id: rcHead

        Row {
            spacing: 3

            Label {
                text: qsTr("Weapon")
                width: 150
            }
            Label {
                text: qsTr("Combat Technique")
                width: 150
            }
            Label {
                text: qsTr("Load time")
                width: 80
            }
            Label {
                text: qsTr("Damage")
                width: 60
            }
            Label {
                text: qsTr("Ammunition")
                width: 100
            }
            Label {
                text: qsTr("Range")
                width: 100
            }
            Label {
                text: qsTr("AT")
                width: 100
            }
        }
    }
    Component {
        id: rcDelegate

        Row {
            visible: type === "rangeWeapon"
            height: type === "rangeWeapon" ? childrenRect.height:0
            spacing: 3

            property var ctSkill: ctList.getCT(ct)

            Label {
                text: item
                width: 150
            }
            Label {
                text: ct ? ctSkill.name:""
                width: 150
            }
            Label {
                text: ct ? reload:""
                width: 80
            }
            Label {
                text: damageDice ? damageDice+qsTr("D6+")+damageFlat:""
                width: 60
            }
            Label {
                text: ammunition ? ammunition:""
                width: 100
            }
            Label {
                text: range ? range:""
                width: 100
            }
            Label {
                text: ct ? ctSkill.level-hero.attrMods:""
            }
        }
    }

    Component {
        id: armorHead

        Row {
            x: marginNormal
            spacing: 3

            Label {
                width: 150
                text: qsTr("Armor")
            }
            Label {
                width: 50
                text: qsTr("Pro")
            }
            Label {
                width: 50
                text: qsTr("Enc")
            }
            Label {
                width: 100
                text: qsTr("Add. Penalties")
            }
            Label {
                width: 50
                text: qsTr("Worn")
            }
        }
    }
    Component {
        id: armorDelegate

        Row {
            x: marginNormal
            visible: type === "armor"
            height: type === "armor" ? childrenRect.height:0
            spacing: 3

            Label {
                width: 150
                text: item
            }
            Label {
                width: 50
                text: protection ? protection:""
            }
            Label {
                width: 50
                text: enc ? enc:""
            }
            Label {
                width: 100
                text: armorType%2 === 0 ? qsTr("-1 Mov -1 Ini"):""
            }
            CheckBox {
                width: 50
                checked: whereId === 0

                onClicked: {
                    checked = whereId === 0
                    note = qsTr("This is toggled by putting the armor from body to a bag in the items tab.")
                }
            }
        }
    }

    Component {
        id: combatHead

        Row{
            x: marginNormal
            spacing: 3
            Label {
                width: 250
                text: qsTr("Combat Techniques")
                font.bold: true
                font.pixelSize: fontSizeMedium
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
            height: childrenRect.height+2*marginSmall

            Row {
                x: marginNormal
                y: marginSmall
                width: parent.width - 2*marginNormal
                spacing: 3

                Label {
                    width: 250
                    text: name

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
                    text: level+Math.floor(((rc ? hero.ff:hero.mu)-8)/3)
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    width: 30
                    text: rc ? "X": Math.round(level/2)+Math.floor((hero.getMainCtAttrValue(primaryAttr)-8)/3)
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: ((modAt !== 0 || modPa !== 0 || modHp !== 0) ? ("("+qsTr("At mod ")+modAt+"/"+qsTr("Pa mod ")+modPa+"/"+qsTr("HP mod ")+modHp+") "):"") + notes
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
        id: ctList

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

        function getCT(tal){
            for(var i=0;i<count;i++){
                if(tal === get(i).tal){
                    return get(i)
                }
            }
            return 0
        }

        ListElement {
            tal: "CT_1"
            name: qsTr("Crossbow")
            level: 6
            rc: true
            improve: "B"
            primaryAttr: "ff"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_2"
            name: qsTr("Bows")
            level: 6
            rc: true
            improve: "C"
            primaryAttr: "ff"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_3"
            name: qsTr("Daggers")
            level: 6
            rc:false
            improve: "B"
            primaryAttr: "ge"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_4"
            name: qsTr("Fencing Weapons")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "ge"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_5"
            name: qsTr("Impact Weapons")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_6"
            name: qsTr("Chain Weapons")
            level: 6
            rc: true
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_7"
            name: qsTr("Lances")
            level: 6
            rc: false
            improve: "B"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_9"
            name: qsTr("Brawling")
            level: 6
            rc: false
            improve: "B"
            primaryAttr: "ge/kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_10"
            name: qsTr("Shields")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_12"
            name: qsTr("Swords")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "ge/kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_13"
            name: qsTr("Pole Weapons")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "ge/kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_14"
            name: qsTr("Throw Weapons")
            level: 6
            rc: true
            improve: "B"
            primaryAttr: "ff"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_15"
            name: qsTr("Two-Handed Impact Weapons")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
        ListElement {
            tal: "CT_16"
            name: qsTr("Two-Handed Swords")
            level: 6
            rc: false
            improve: "C"
            primaryAttr: "kk"
            modAt: 0
            modPa: 0
            modHp: 0
            notes: ""
        }
    }
}
