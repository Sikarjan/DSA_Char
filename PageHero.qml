import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import Qt.labs.settings 1.1

import "components"
import "components/Globals.js" as Globals

Page {
    id: page
    width: 600
    height: 400
    hoverEnabled: false
    title: qsTr("Hero")

    Settings {
        property alias advantages: advantages.text
        property alias disadvantages: disadvantages.text
        property alias abilities: abilities.text
    }

    function clear(){
        advantages.text = ""
        disadvantages.text = ""
        abilities.text = ""
    }

    header: RowLayout {
        Label {
            text: qsTr("Hero")
            font.pixelSize: fontSizeLarge
            padding: 10
        }

        Rectangle {
            Layout.fillWidth: true
        }

        Row {
            CharAttribute {
                attrName: hero.muText
                attrColor: "Red"
                attrValue: hero.mu
                attrModValue: hero.mu-hero.stateModAll
            }

            CharAttribute {
                attrValue: hero.kl
                attrModValue: hero.kl-hero.stateModAll
                attrColor: "#7220f0"
                attrName: hero.klText
            }

            CharAttribute {
                attrValue: hero.intu
                attrModValue: hero.intu-hero.stateModAll
                attrColor: "#47f020"
                attrName: hero.klText
            }

            CharAttribute {
                id: ch
                attrValue: hero.ch
                attrModValue: hero.ch-hero.stateModAll
                attrColor: "#dd000000"
                attrName: hero.chText
            }

            CharAttribute {
                attrValue: hero.ff
                attrModValue: hero.ff-hero.stateModAll
                attrColor: "#f7ff08"
                attrName: hero.ffText
            }

            CharAttribute {
                attrValue: hero.ge
                attrModValue: hero.ge-hero.stateModAll
                attrColor: "#204ef0"
                attrName: hero.geText
            }

            CharAttribute {
                attrValue: hero.ko
                attrModValue: hero.ko-hero.stateModAll
                attrColor: "#aeafae"
                attrName: hero.koText
            }

            CharAttribute {
                attrValue: hero.kk
                attrModValue: hero.kk-hero.stateModAll
                attrColor: "#ffab00"
                attrName: hero.kkText
            }
        }
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

        Grid {
            id: content
            columnSpacing: 5
            columns: Math.floor(page.width/400)
            width: parent.width

            GridLayout {
                id: basics
                columns: 2
                columnSpacing: 4
                width: 390

                Label {
                    text: qsTr("Name")
                }
                TextField {
                    text: hero.hName
                    onEditingFinished: hero.hName = text
                    selectByMouse: true
                    Layout.fillWidth: true
                }
                Label {
                    text: qsTr("Race")
                }
                Label {
                    text: Globals.raceIds[hero.raceId]
                }
                Label {
                    text: qsTr("Culture")
                }
                TextField {
                    text: hero.culture
                    onEditingFinished: hero.culture = text
                    selectByMouse: true
                    Layout.fillWidth: true
                }
                Label {
                    text: qsTr("Profession")
                }
                TextField {
                    text: hero.profession
                    onEditingFinished: hero.profession = text
                    selectByMouse: true
                    Layout.fillWidth: true
                }
                Label {
                    text: qsTr("Size")
                }
                TextField {
                    text: hero.hSize
                    onEditingFinished: hero.hSize = text
                    selectByMouse: true
                    Layout.fillWidth: true
                }
                Label {
                    text: qsTr("Weigh")
                }
                Label {
                    text: hero.hWeight + " "+qsTr("stone")
                }
            }

            Rectangle {
                id: avator
                width: 225
                height: 300

                Image {
                    anchors.fill: parent
                    source: "qrc:/img/img/parchment.png"
                }
                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: hero.avatar
                    fillMode: Image.PreserveAspectFit
                }
            }
            Column {
                id: points
                spacing: 5

                Row {
                    spacing: 5
                    Label {
                        id: col1
                        text: qsTr("Points")
                        width: 150
                    }
                    Label {
                        id: col2
                        text: qsTr("Stat")
                        width: 90
                    }
                    Label {
                        id: col3
                        text: qsTr("Mod")
                    }
                    Label {
                        id: col4
                        text: qsTr("Bought")
                    }
                    Label {
                        id: col5
                        text: qsTr("Max")
                    }
                }

                // Life Points
                Row {
                    spacing: 5

                    Column {
                        Label {
                            text: qsTr("Life Points")
                            width: col1.width
                        }
                        Label {
                            text: qsTr("Mod")+"+"+hero.koText+"+"+hero.koText
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    SpinBox {
                        id: leP
                        width: col2.width
                        height: 30
                        editable: true
                        wheelEnabled: true
                        enabled: true
                        font.pointSize: 10
                        value: hero.le
                        from: -10
                        to: hero.leMax

                        onValueModified: hero.le = value
                    }
                    Label {
                        text: hero.leMod
                        width: col3.width
                    }
                    Label {
                        text: hero.leBought
                        width: col4.width
                    }
                    Label {
                        text: hero.leMax
                        width: col5.width
                    }
                }
                // Magic Points
                Row {
                    spacing: 5
                    visible: hero.aeMod >= 0
                    Column {
                        Label {
                            text: qsTr("Arcane Energie")
                            width: col1.width
                        }
                        Label {
                            text: qsTr("20 for Spellcaster + Primary Attribute")
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    SpinBox {
                        id: ae
                        width: col2.width
                        height: 30
                        editable: true
                        wheelEnabled: true
                        enabled: true
                        value: hero.ae
                        font.pointSize: 10
                        from: -10
                        to: hero.aeMax
                    }
                    Label {
                        text: hero.aeMod
                        width: col3.width
                    }
                    Label {
                        text: hero.aeBought
                        width: col4.width
                    }
                    Label {
                        text: hero.aeMax
                        width: col5.width
                    }
                }

                // Karmal Points
                Row {
                    spacing: 5
                    visible: hero.keMod >= 0
                    Column {
                        Label {
                            text: qsTr("Karma Points")
                            width: col1.width
                        }
                        Label {
                            text: qsTr("20 for Blessed One + Primary Attribute")
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    SpinBox {
                        id: ke
                        width: col2.width
                        height: 30
                        editable: true
                        wheelEnabled: true
                        enabled: true
                        value: hero.ke
                        font.pointSize: 10
                        from: -10
                        to: hero.keMax
                    }
                    Label {
                        text: hero.keMod
                        width: col3.width
                    }
                    Label {
                        text: hero.keBought
                        width: col4.width
                    }
                    Label {
                        text: hero.keMax
                        width: col5.width
                    }
                }
                // Fate Points
                Row {
                    spacing: 5
                    Label {
                        text: qsTr("Fate Points")
                        height: 40
                        width: col1.width
                    }
                    SpinBox {
                        width: col2.width
                        height: 30
                        editable: true
                        wheelEnabled: true
                        enabled: true
                        value: hero.fatePoints
                        font.pointSize: 10
                        from: 0
                        to: hero.fatePointsMax
                    }
                    Label {
                        text: hero.fatePointsMod
                        width: col3.width
                    }Label {
                        text: "X"
                        width: col4.width
                    }
                    Label {
                        text: hero.fatePointsMax
                        width: col5.width
                    }
                }
            }

            Column {

                Row {
                    spacing: 3
                    Label {
                        text: qsTr("Properties")
                        width: col1.width
                    }
                    Label {
                        id: baseLabel
                        text: qsTr("Base")
                    }
                    Label {
                        text: qsTr("Mod")
                    }
                    Label {
                        text: qsTr("Stat")
                    }
                }
                // Spirit
                Row {
                    spacing: 3
                    Column {
                        Label {
                            text: qsTr("Spirit")
                            width: col1.width
                        }
                        Label {
                            text: qsTr("Race Mod")+"("+hero.spiritBase+") +("+hero.muText+"+"+hero.klText+"+"+hero.inText+")/6"
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    Label {
                        text: hero.spiritBase+Math.round((hero.mu+hero.kl+hero.intu)/6)
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.spiritMod
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.spirit
                        width: baseLabel.width
                    }
                }
                // Toughness
                Row {
                    spacing: 3
                    Column {
                        Label {
                            text: qsTr("Toughness")
                            width: col1.width
                        }
                        Label {
                            text: qsTr("Race Mod")+"("+hero.toughnessBase+") +("+hero.koText+"+"+hero.koText+"+"+hero.kkText+")/6"
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    Label {
                        text: hero.toughnessBase+Math.round((hero.ko+hero.ko+hero.kk)/6)
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.toughnessMod
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.toughness
                        width: baseLabel.width
                    }
                }
                // Dodge
                Row {
                    spacing: 3
                    Column {
                        Label {
                            text: qsTr("Dodge")
                            width: col1.width
                        }
                        Label {
                            text: hero.geText+"/2"
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    Label {
                        text: Math.round(hero.ge/2)
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.dodgeMod
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.dodge
                        width: baseLabel.width
                    }
                }
                // Initiative
                Row {
                    spacing: 3
                    Column {
                        Label {
                            text: qsTr("Initiative")
                            width: col1.width
                        }
                        Label {
                            text: "("+hero.muText+"+"+hero.geText+")/2"
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    Label {
                        text: Math.round((hero.mu+hero.ge)/2)
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.iniMod
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.iniBase
                        width: baseLabel.width
                    }
                }
                // Movement
                Row {
                    spacing: 3
                    Column {
                        Label {
                            text: qsTr("Movement")
                            width: col1.width
                        }
                        Label {
                            text: qsTr("Race Mod +8")
                            font.pixelSize: fontSizeSmall
                        }
                    }
                    Label {
                        text: hero.moveRaceMod+8
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.moveMod
                        width: baseLabel.width
                    }
                    Label {
                        text: hero.move
                        width: baseLabel.width
                    }
                }
            }

            Grid {
                id: conditions

                spacing: 2
                columns: 7

                Label {
                    text: qsTr("Condition")
                }
                Label {
                    text: "0"
                }
                Label {
                    text: "1"
                }
                Label {
                    text: "2"
                }
                Label {
                    text: "3"
                }
                Label {
                    text: "4"
                }
                Label {
                    text: qsTr("Incapacitated")
                }

                // Confusion
                Label {
                    text: qsTr("Confusion")
                }
                RadioButton {
                    id: con0
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: confusionGroup
                    checked: hero.confusion === 0
                    onToggled: hero.confusion = 0
                }
                RadioButton {
                    id: con1
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: confusionGroup
                    checked: hero.confusion === 1
                    onToggled: hero.confusion = 1
                }
                RadioButton {
                    id: con2
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: confusionGroup
                    checked: hero.confusion === 2
                    onToggled: hero.confusion = 2
                }
                RadioButton {
                    id: con3
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: confusionGroup
                    checked: hero.confusion === 3
                    onToggled: hero.confusion = 3
                }
                RadioButton {
                    id: con4
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: confusionGroup
                    checked: hero.confusion === 4
                    onToggled: hero.confusion = 4
                }
                Label {
                    text: qsTr("perplex")
                }

                // Fear
                Label {
                    text: qsTr("Fear")
                }
                RadioButton {
                    id: fear0
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: fearGroup
                    checked: hero.fear === 0
                    onToggled: hero.fear = 0
                }
                RadioButton {
                    id: fear1
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: fearGroup
                    checked: hero.fear === 1
                    onToggled: hero.fear = 1
                }
                RadioButton {
                    id: fear2
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: fearGroup
                    checked: hero.fear === 2
                    onToggled: hero.fear = 2
                }
                RadioButton {
                    id: fear3
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: fearGroup
                    checked: hero.fear === 3
                    onToggled: hero.fear = 3
                }
                RadioButton {
                    id: fear4
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: fearGroup
                    checked: hero.fear === 4
                    onToggled: hero.fear = 4
                }
                Label {
                    text: qsTr("petrified")
                }

                // Burden
                Label {
                    text: qsTr("Encumbrance")
                }
                RadioButton {
                    id: bel0
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: burdenGroup
                    checked: hero.burden === 0
                    onToggled: hero.burden = 0
                }
                RadioButton {
                    id: bel1
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: burdenGroup
                    checked: hero.burden == 1
                    onToggled: hero.burden = 1
                }
                RadioButton {
                    id: bel2
                    width: 22
                    height: 24
                    ButtonGroup.group: burdenGroup
                    checked: hero.burden == 2
                    onToggled: hero.burden = 2
                }
                RadioButton {
                    id: bel3
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: burdenGroup
                    checked: hero.burden == 3
                    onToggled: hero.burden = 3
                }
                RadioButton {
                    id: bel4
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: burdenGroup
                    checked: hero.burden >= 4
                    onToggled: hero.burden = 4
                }
                Label {
                    text: qsTr("hamstrung")
                }

                // Pain
                Label {
                    text: qsTr("Pain")
                }
                RadioButton {
                    id: pain0
                    width: 22
                    height: 24
                    checked: hero.pain == 0
                    onToggled: hero.pain = 0
                    ButtonGroup.group: painGroup
                }
                RadioButton {
                    id: pain1
                    width: 22
                    height: 24
                    checked: hero.pain == 1
                    onToggled: hero.pain = 1
                    ButtonGroup.group: painGroup
                }
                RadioButton {
                    id: pain2
                    width: 22
                    height: 24
                    checked: hero.pain == 2
                    onToggled: hero.pain = 2
                    ButtonGroup.group: painGroup
                }
                RadioButton {
                    id: pain3
                    width: 22
                    height: 24
                    checked: hero.pain == 3
                    onToggled: hero.pain = 3
                    ButtonGroup.group: painGroup
                }
                RadioButton {
                    id: pain4
                    width: 22
                    height: 24
                    checked: hero.pain >= 4
                    onToggled: hero.pain = 4
                    ButtonGroup.group: painGroup
                }
                Label {
                    text: qsTr("unconscious")
                }

                // Paralysis
                Label {
                    text: qsTr("Paralysis")
                }
                RadioButton {
                    id: para0
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: paraGroup
                    checked: hero.paralysis === 0
                    onToggled: hero.paralysis = 0
                }
                RadioButton {
                    id: para1
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: paraGroup
                    checked: hero.paralysis === 1
                    onToggled: hero.paralysis = 1
                }
                RadioButton {
                    id: para2
                    width: 22
                    height: 24
                    ButtonGroup.group: paraGroup
                    checked: hero.paralysis === 2
                    onToggled: hero.paralysis = 2
                }
                RadioButton {
                    id: para3
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: paraGroup
                    checked: hero.paralysis === 3
                    onToggled: hero.paralysis = 3
                }
                RadioButton {
                    id: para4
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: paraGroup
                    checked: hero.paralysis >= 4
                    onToggled: hero.paralysis = 4
                }
                Label {
                    text: qsTr("paralysed")
                }

                // Rapture
                Label {
                    text: qsTr("Rapture")
                }
                RadioButton {
                    id: rap0
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: rapGroup
                    checked: hero.rapture === 0
                    onToggled: hero.rapture = 0
                }
                RadioButton {
                    id: rap1
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: rapGroup
                    checked: hero.rapture === 1
                    onToggled: hero.rapture = 1
                }
                RadioButton {
                    id: rap2
                    width: 22
                    height: 24
                    ButtonGroup.group: rapGroup
                    checked: hero.rapture === 2
                    onToggled: hero.rapture = 2
                }
                RadioButton {
                    id: rap3
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: rapGroup
                    checked: hero.rapture === 3
                    onToggled: hero.rapture = 3
                }
                RadioButton {
                    id: rap4
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: rapGroup
                    checked: hero.rapture >= 4
                    onToggled: hero.rapture = 4
                }
                Label {
                    text: qsTr("engrossed")
                }

                // Stupor
                Label {
                    text: qsTr("Stupor")
                }
                RadioButton {
                    id: stup0
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: stupGroup
                    checked: hero.stupor === 0
                    onToggled: hero.stupor = 0
                }
                RadioButton {
                    id: stup1
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: stupGroup
                    checked: hero.stupor === 1
                    onToggled: hero.stupor = 1
                }
                RadioButton {
                    id: stup2
                    width: 22
                    height: 24
                    ButtonGroup.group: stupGroup
                    checked: hero.stupor === 2
                    onToggled: hero.stupor = 2
                }
                RadioButton {
                    id: stup3
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: stupGroup
                    checked: hero.stupor === 3
                    onToggled: hero.stupor = 3
                }
                RadioButton {
                    id: stup4
                    width: 22
                    height: 24
                    text: qsTr("")
                    ButtonGroup.group: stupGroup
                    checked: hero.stupor >= 4
                    onToggled: hero.stupor = 4
                }
                Label {
                    text: qsTr("sensless")
                }
            }

            Column {
                width: 380
                spacing: 2
                Label {
                    text: qsTr("Advantages")
                }
                TextBox {
                    id: advantages
                    width: parent.width
                    placeholderText: qsTr("Your advantages.")
                }
            }
            Column {
                width: 380
                spacing: 2
                Label {
                    text: qsTr("Disadvantages")
                }
                TextBox {
                    id: disadvantages
                    width: parent.width
                    placeholderText: qsTr("Your disadvantages.")
                }
            }
            Column {
                width: 380
                spacing: 2
                Label {
                    text: qsTr("Abilities")
                }
                TextBox {
                    id: abilities
                    width: parent.width
                    placeholderText: qsTr("Your abilities.")
                }
            }
        }
    }
    // Zustände
    ButtonGroup {
        id: confusionGroup
    }
    ButtonGroup {
        id: fearGroup
    }

    ButtonGroup {
        id: burdenGroup
    }
    ButtonGroup {
        id: painGroup
    }
    ButtonGroup {
        id: rapGroup
    }
    ButtonGroup {
        id: paraGroup
    }
    ButtonGroup {
        id: stupGroup
    }
}
