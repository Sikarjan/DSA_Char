import QtQuick 2.12
import QtQuick.Controls 2.12
import "components"
import QtQuick.Layouts 1.11

Page {
    id: page
    width: 600
    height: 400
    hoverEnabled: false
    title: "Hero"

    property alias leP: leP
    property alias asP: asP
    property alias painGroup: painGroup

    header: Label {
        text: qsTr("Hero")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Row {
        id: row
        x: 125
        width: 475
        height: 61
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 5

        CharAttribute {
            id: mu
            attrName: hero.muText
            attrColor: "Red"
            attrValue: hero.mu
            attrModValue: hero.muMod
        }

        CharAttribute {
            id: kl
            attrValue: hero.kl
            attrModValue: hero.klMod
            attrColor: "#7220f0"
            attrName: hero.klText
        }

        CharAttribute {
            id: intu
            attrValue: hero.intu
            attrModValue: hero.inMod
            attrColor: "#47f020"
            attrName: hero.klText
        }

        CharAttribute {
            id: ch
            attrValue: hero.ch
            attrModValue: hero.chMod
            attrColor: "#dd000000"
            attrName: hero.chText
        }

        CharAttribute {
            id: ff
            attrValue: hero.ff
            attrModValue: hero.ffMod
            attrColor: "#f7ff08"
            attrName: hero.ffText
        }

        CharAttribute {
            id: ge
            attrValue: hero.ge
            attrModValue: hero.geMod
            attrColor: "#204ef0"
            attrName: hero.geText
        }

        CharAttribute {
            id: ko
            attrValue: hero.ko
            attrModValue: hero.koMod
            attrColor: "#aeafae"
            attrName: hero.koText
        }

        CharAttribute {
            id: kk
            attrValue: hero.kk
            attrModValue: hero.kkMod
            attrColor: "#ffab00"
            attrName: hero.kkText
        }
    }

    // Zustände
    ButtonGroup {
        id: confusionGroup
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

    Grid {
        id: grid
        x: 290
        y: 72
        width: 310
        height: 146
        spacing: 1
        rows: 7
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
            text: "Incapacitated"
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
            checked: hero.burden == 0
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
            ButtonGroup.group: painGroup
        }
        RadioButton {
            id: pain1
            width: 22
            height: 24
            checked: hero.pain == 1
            ButtonGroup.group: painGroup
        }
        RadioButton {
            id: pain2
            width: 22
            height: 24
            checked: hero.pain == 2
            ButtonGroup.group: painGroup
        }
        RadioButton {
            id: pain3
            width: 22
            height: 24
            checked: hero.pain == 3
            ButtonGroup.group: painGroup
        }
        RadioButton {
            id: pain4
            width: 22
            height: 24
            checked: hero.pain >= 4
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
        y: 72
        anchors.left: parent.left
        anchors.leftMargin: 5

        Row {
            Label {
                id: col1
                text: qsTr("Points")
                height: 40
                width: 150
            }
            Label {
                id: col2
                text: qsTr("Max")
            }
            Label {
                id: col3
                text: qsTr("Current")
                width: 100
            }
        }

        // Life Points
        Row {
            Label {
                text: qsTr("Life Points")
                height: 40
                width: col1.width
            }
            Label {
                text: hero.leMax
                width: col2.width
            }

            SpinBox {
                id: leP
                width: col3.width
                height: 30
                editable: true
                wheelEnabled: true
                enabled: true
                font.pointSize: 10
                value: hero.le
                from: -10
                to: hero.leMax
            }
        }
        // Magic Points
        Row {
            visible: hero.aspMod > 0
            Label {
                text: qsTr("Arcane Energy")
                height: 40
                width: col1.width
            }
            Label {
                text: hero.aspMax
                width: col2.width
            }

            SpinBox {
                id: asP
                width: col3.width
                height: 30
                editable: true
                wheelEnabled: true
                enabled: true
                value: hero.asp
                font.pointSize: 10
                from: -10
                to: hero.aspMax
            }
        }
    }
}

/*##^##
Designer {
    D{i:2;anchors_y:"-44"}
}
##^##*/

