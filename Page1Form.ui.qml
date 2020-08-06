import QtQuick 2.12
import QtQuick.Controls 2.12
import "components"
import QtQuick.Layouts 1.11

Page {
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
        x: 102
        y: 6
        width: 455
        height: 62

        CharProperty {
            id: mu
            propName: qsTr("MU")
            propColor: "Red"
            propValue: hero.mu
            propModValue: hero.muMod
        }

        CharProperty {
            id: kl
            propValue: hero.kl
            propModValue: hero.klMod
            propColor: "#7220f0"
            propName: "KL"
        }

        CharProperty {
            id: intu
            propValue: hero.intu
            propModValue: hero.inMod
            propColor: "#47f020"
            propName: "IN"
        }

        CharProperty {
            id: ch
            propValue: hero.ch
            propModValue: hero.chMod
            propColor: "#dd000000"
            propName: "CH"
        }

        CharProperty {
            id: ff
            propValue: hero.ff
            propModValue: hero.ffMod
            propColor: "#f7ff08"
            propName: "FF"
        }

        CharProperty {
            id: ge
            propValue: hero.ge
            propModValue: hero.geMod
            propColor: "#204ef0"
            propName: "GE"
        }

        CharProperty {
            id: ko
            propValue: hero.ko
            propModValue: hero.koMod
            propColor: "#aeafae"
            propName: "KO"
        }

        CharProperty {
            id: kk
            propValue: hero.kk
            propModValue: hero.kkMod
            propColor: "#ffab00"
            propName: "KK"
        }
    }

    // Zustände
    ButtonGroup {
        id: burdenGroup
    }
    ButtonGroup {
        id: painGroup
    }

    Grid {
        id: grid
        x: 220
        y: 196
        width: 369
        height: 146
        spacing: 1
        rows: 3
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
        // next Row
        Label {
            text: qsTr("Burden")
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

        // next Row
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
    }

    Column {
        x: 231
        y: 82

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
