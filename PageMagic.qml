import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import Qt.labs.qmlmodels 1.0

import "components"

Page {
    id: pageMagic
    width: 600
    height: 400

    header: RowLayout {
        Label {
            text: qsTr("Magic")
            font.pixelSize: fontSizeLarge
            padding: 10
        }

        Rectangle {
            Layout.fillWidth: true
        }

        Row {
            spacing: marginSmall
            Label {
                text: qsTr("AE")
            }
            SpinBox {
                id: ae
                editable: true
                wheelEnabled: true
                enabled: true
                value: hero.ae
                from: -10
                to: hero.aeMax

                onValueModified: hero.ae = value
            }
        }

        Row {
            CharAttribute {
                attrName: hero.muText
                attrColor: "Red"
                attrValue: hero.mu
                attrModValue: hero.mu-hero.stateModMagic
            }

            CharAttribute {
                attrValue: hero.kl
                attrModValue: hero.kl-hero.stateModMagic
                attrColor: "#7220f0"
                attrName: hero.klText
            }

            CharAttribute {
                attrValue: hero.intu
                attrModValue: hero.intu-hero.stateModMagic
                attrColor: "#47f020"
                attrName: hero.klText
            }

            CharAttribute {
                id: ch
                attrValue: hero.ch
                attrModValue: hero.ch-hero.stateModMagic
                attrColor: "#dd000000"
                attrName: hero.chText
            }

            CharAttribute {
                attrValue: hero.ff
                attrModValue: hero.ff-hero.stateModMagic
                attrColor: "#f7ff08"
                attrName: hero.ffText
            }

            CharAttribute {
                attrValue: hero.ge
                attrModValue: hero.ge-hero.stateModMagic
                attrColor: "#204ef0"
                attrName: hero.geText
            }

            CharAttribute {
                attrValue: hero.ko
                attrModValue: hero.ko-hero.stateModMagic
                attrColor: "#aeafae"
                attrName: hero.koText
            }

            CharAttribute {
                attrValue: hero.kk
                attrModValue: hero.kk-hero.stateModMagic
                attrColor: "#ffab00"
                attrName: hero.kkText
            }
        }
    }

    Column {
        id:content
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5
        clip: true

        ListView {
            id: spellView
            width: parent.width
            height: contentHeight
            model: spellModel

            header: spellHeader
            delegate: spellDelegate
        }
    }

    ListModel {
        id: spellModel

        Component.onCompleted: {
            spellModel.append({
                                 "spell": "Test spell",
                                 "check": "in/kl/kk",
                                 "sr": 4,
                                 "cost": "5 AsP",
                                 "time": 4,
                                 "range": "selbst",
                                 "duration": "QSx3",
                                 "prop": "Heilung",
                                 "impr": "B",
                                 "effect": "Paralys Stufe 1"
            })
            spellModel.append({
                                 "spell": "Test spell 2",
                                 "check": "in/ch/kk",
                                 "sr": 6,
                                 "cost": "2 AsP",
                                 "time": 4,
                                 "range": "selbst",
                                 "duration": "QSx3",
                                 "prop": "Heilung",
                                 "impr": "D",
                                 "effect": "Unsichtbar"
            })
        }
    }

    Component {
        id: spellHeader

        RowLayout {
            width: parent.width
            spacing: 3

            Layout.bottomMargin: 5

            Label { text: qsTr("Spell");    width: 120 }
            Label { text: qsTr("Check");    width: 90}
            Label { text: qsTr("SR");       width: 40}
            Label { text: qsTr("Cost");     width: 60}
            Label { text: qsTr("Casting Time");     width: 60}
            Label { text: qsTr("Range");    width: 80}
            Label { text: qsTr("Duration"); width: 60}
            Label { text: qsTr("Property"); width: 90}
            Label { text: qsTr("Impr.");    width: 40 }
            Label { text: qsTr("Effect");   Layout.fillWidth: true }
        }
    }

    Component {
        id:spellDelegate
        RowLayout {
            spacing: 0
            width: parent.width
            TCell {
                text: spell
                width: 120
                horizontalAlignment: Text.AlignLeft

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true

                    onEntered: {spellCheck.text = hero.getAttr(check, 3)}
                    onExited: {spellCheck.text = hero.getAttr(check, 0)}
                    onClicked: {
                        activeSpell = index
                        spellContext.popup()
                    }
                }
            }
            TCell { id: spellCheck; width: 90; highlight: true }
            TCell { text: sr;       width: 40 }
            TCell { text: cost;     width: 60; highlight: true }
            TCell { text: time;     width: 60 }
            TCell { text: range;    width: 80; highlight: true }
            TCell { text: duration; width: 60 }
            TCell { text: prop;     width: 90; highlight: true }
            TCell { text: impr;     width: 40 }
            TCell {
                text: effect
                Layout.fillWidth: true
                highlight: true
                horizontalAlignment: Text.AlignLeft
            }

            Component.onCompleted: {check.text = hero.getAttr(check, 0)}
        }
    }
}
