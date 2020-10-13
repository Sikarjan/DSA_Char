import QtQuick 2.15
import QtQuick.Controls 1.4
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

    Component.onCompleted: {
        spellModel.append({
                             "spell": "Test spell",
                             "check": "in/kl/kk",
                             "sr": 4,
                             "cost": "5 AsP",
                             "time": 4,
                             "range": "selbst",
                             "duration": "QSx3",
                             "property": "Heilung",
                             "impr": "B",
                             "effect": "Paralys Stufe 1"
        })
    }

    Column {
        id:content
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        TableView {
            id: spellView
            width: parent.width
            model: spellModel

           TableViewColumn { role: "spell"; title: qsTr("Spell"); delegate: linkCell}
           TableViewColumn { role: "check"; title: qsTr("Check"); delegate: checkCell }
           TableViewColumn { role: "sr"; title: qsTr("SR"); delegate: textCell}
           TableViewColumn { role: "cost"; title: qsTr("Cost"); delegate: textCell}
           TableViewColumn { role: "time"; title: qsTr("Casting Time"); delegate: textCell}
           TableViewColumn { role: "range"; title: qsTr("Range"); delegate: textCell}
           TableViewColumn { role: "duration"; title: qsTr("Duration"); delegate: textCell}
           TableViewColumn { role: "proptery"; title: qsTr("Property"); delegate: textCell}
           TableViewColumn { role: "impr"; title: qsTr("Impr."); delegate: textCell }
           TableViewColumn { role: "effect"; title: qsTr("Effect"); delegate: textCell }

        }
    }

    Component {
        id: textCell
        Label {
            text: styleData.value
        }
    }
    Component {
        id: linkCell
        Label {
            text: styleData.value
        }
    }

    Component {
        id: checkCell
        Rectangle {
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
            Label {
                id: check
                text: hero.getAttr(styleData.value)
            }
            MouseArea {
                anchors.fill: parent

                onEntered: check.text = hero.getAttr(styleData.value,3)
                onExited: check.text = hero.getAttr(styleData.value)
            }
        }
    }

    ListModel {
        id: spellModel
/*
        TableModelColumn { display: "spell"}
        TableModelColumn { display: "check"}
        TableModelColumn { display: "sr"}
        TableModelColumn { display: "cost"}
        TableModelColumn { display: "time"}
        TableModelColumn { display: "range"}
        TableModelColumn { display: "duration"}
        TableModelColumn { display: "proptery"}
        TableModelColumn { display: "impr"}
        TableModelColumn { display: "effect"}*/
    }
}
