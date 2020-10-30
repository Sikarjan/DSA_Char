import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import Qt.labs.settings 1.1

import "components"
import "dialogs"

Page {
    id: pageMagic
    width: 600
    height: 400

    property alias spellModel: spellModel
    property int activeSpell: -1
    property string spellListStore: ""

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

                onValueModified: {
                    hero.ae = value
                }
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

    Settings {
        property alias spellListStore: pageMagic.spellListStore
        property alias cantrips: cantrips.text
        property alias magicAbilities: magicAbilities.text
        property alias tradition: tradition.text
        property alias prop: prop.text
    }

    Component.onCompleted: {
        if(spellListStore){
            var spellStore = JSON.parse(spellListStore)
            spellModel.clear()
            for(var i=0;i<spellStore.length;i++){
                spellModel.append(spellStore[i])
            }
        }
    }

    AddSpellDialog {
        id:addSpellDialog
        anchors.centerIn: parent
    }

    Column {
        id:content
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5
        clip: true

        Button {
            text: qsTr("Add Spell")
            onClicked: addSpellDialog.visible = true
        }

        ListView {
            id: spellView
            width: parent.width
            height: contentHeight
            model: spellModel

            header: spellHeader
            delegate: spellDelegate
        }
        TextBox {
            id: cantrips
            width: 380
            title: qsTr("cantrips")
            placeholderText: qsTr("Your cantrips")
        }
        TextBox {
            id: magicAbilities
            width: 380
            title: qsTr("Magical Special Abilities")
            placeholderText: qsTr("Your special abilites")
        }
        GridLayout {
           columns: 2
           Label { text: qsTr("Tradition")}
           TextField {
               id: tradition
               selectByMouse: true
               Layout.fillWidth: true
           }

           Label { text: qsTr("Properties")}
           TextField {
               id: prop
               selectByMouse: true
               Layout.fillWidth: true
           }

           Label { text: qsTr("Primary Attribute")}
           Label { text: hero.getAttr(hero.mainAttr) }
        }
    }

    ListModel {
        id: spellModel

        function sortSpells() {
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
            return a.spell.localeCompare(b.spell)
        }
    }

    Component {
        id: spellHeader

        Row {
            width: parent.width
            spacing: 0

            Layout.bottomMargin: 5

            Text { text: qsTr("Spell");    width: 120;  wrapMode: Text.Wrap }
            Text { text: qsTr("Check");    width: 90;  wrapMode: Text.Wrap}
            Text { text: qsTr("SR");       width: 40;  wrapMode: Text.Wrap}
            Text { text: qsTr("Cost");     width: 60;  wrapMode: Text.Wrap}
            Text { text: qsTr("Casting Time");     width: 60;  wrapMode: Text.Wrap}
            Text { text: qsTr("Range");    width: 80;  wrapMode: Text.Wrap}
            Text { text: qsTr("Duration"); width: 60;  wrapMode: Text.Wrap}
            Text { text: qsTr("Property"); width: 90;  wrapMode: Text.Wrap}
            Text { text: qsTr("Impr.");    width: 40;  wrapMode: Text.Wrap }
            Text { text: qsTr("Effect") }
        }
    }

    Component {
        id:spellDelegate

        RowLayout {
            id: row
            spacing: 0
            width: parent.width
            Layout.alignment: Qt.AlignTop

            TCell {
                text: spell
                width: 120
                horizontalAlignment: Text.AlignLeft

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true

                    onEntered: {spellCheck.text = hero.getAttr(check, 3)+spellMod(mod)}
                    onExited: {spellCheck.text = hero.getAttr(check, 0)+spellMod(mod)}
                    onClicked: {
                        activeSpell = index
                        spellContext.popup()
                    }
                }
            }
            TCell { id: spellCheck; width: 90; bgHeight: row.implicitHeight }
            TCell { text: sr;       width: 40 }
            TCell { text: cost;     width: 60; bgHeight: row.implicitHeight }
            TCell { text: time;     width: 60 }
            TCell { text: range;    width: 80; bgHeight: row.implicitHeight }
            TCell { text: duration; width: 60 }
            TCell { text: prop;     width: 90; bgHeight: row.implicitHeight }
            TCell { text: impr;     width: 40 }
            TCell {
                text: effect
                Layout.fillWidth: true
                bgHeight: row.implicitHeight
                horizontalAlignment: Text.AlignLeft
            }

            Component.onCompleted: {
                spellCheck.text = hero.getAttr(check, 0)+spellMod(mod)
            }
            function spellMod(mod){
                if(mod === 0){
                    return "";
                }else if(mod === 1){
                    return qsTr(" (-SP)")
                }else if(mod === 2){
                    return qsTr(" (-TP)")
                }
            }
        }
    }
    Menu {
        id: spellContext
        MenuItem {
            text: qsTr("Edit")
            onTriggered: addSpellDialog.visible = true
        }
        MenuItem {
            text: qsTr("Delete")
            onTriggered: spellModel.remove(activeSpell)
        }
    }
}
