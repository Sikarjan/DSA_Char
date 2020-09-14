import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

import "components"

Page {
    id: page
    width: 600
    height: 400

    property alias ctList: combatTalentsList
    property alias combatTalents: combatTalents

    Component.onCompleted: combatTalentsList.sortCombatSkills()

    header: Label {
        text: qsTr("Notes")
    }

    Flickable {
        id: flick
        anchors.fill: parent
        anchors.margins: 5
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
        }
    }

    Component {
        id: combatHead
        RowLayout {
            spacing: 3
            Label {
                width: 300
                text: qsTr("Combat Techniques")
            }
            Text {
                width: 80
                text: qsTr("Primary Attribute")
                wrapMode: Text.Wrap
            }
            Label {
                width: 50
                text: qsTr("Impr.")
            }
            Label {
                width: 50
                text: qsTr("CSR")
            }
            Label {
                width: 50
                text: qsTr("AT/RC")
            }
            Label {
                width: 50
                text: qsTr("PA")
            }
            Label {
                text: qsTr("Notes")
            }
        }
    }

    Component {
        id: combatDelegate

        Row {
            spacing: 3
            Label {
                width: 200
                text: name
            }
            Label {
                width: 80
                text: hero.getAttr(primaryAttr, 0)
            }
            Label {
                width: 50
                text: improve
            }
            Label {
                width: 50
                text: level
            }
            Label {
                width: 50
                text: at
            }
            Label {
                width: 50
                text: pa
            }
            Label {
                text: ((modAt > 0 || modPa > 0) ? ("("+qsTr("At mod")+modAt+"/"+qsTr("Pa mod")+modPa+") "):"") + notes
                Layout.fillWidth: true
            }
        }
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
            name: qsTr("Crossbow")
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
            name: qsTr("Bows")
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
            name: qsTr("Daggers")
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
            name: qsTr("Fencing Weapons")
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
            name: qsTr("Impact Weapons")
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
            name: qsTr("Chain Weapons")
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
            name: qsTr("Lances")
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
            name: qsTr("Brawling")
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
            name: qsTr("Shields")
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
            name: qsTr("Swords")
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
            name: qsTr("Pole Weapons")
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
            name: qsTr("Throw Weapons")
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
            name: qsTr("Two-Handed Impact Weapons")
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
            name: qsTr("Two-Handed Swords")
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
