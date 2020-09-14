import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

import "components"
import "dialogs"
import "components/Globals.js" as Globals

Page {
    width: 600
    height: 400

    property alias skillList: skillList
    property alias skillView: skillView
    property int activeSkill: 0

    Component.onCompleted: skillList.sortSkills()

    header: RowLayout {
        Label {
            text: qsTr("Skills")
            font.pixelSize: Qt.application.font.pixelSize * 2
            padding: 10
        }
        Rectangle {
            Layout.fillWidth: true
        }

        Row {
            id: row

            CharAttribute {
                id: mu
                height: 25
                attrName: hero.muText
                attrColor: "Red"
                attrValue: hero.mu
                attrModValue: hero.muMod
            }

            CharAttribute {
                id: kl
                height: 25
                attrValue: hero.kl
                attrModValue: hero.klMod
                attrColor: "#7225f0"
                attrName: hero.klText
            }

            CharAttribute {
                id: intu
                height: 25
                attrValue: hero.intu
                attrModValue: hero.inMod
                attrColor: "#47f025"
                attrName: hero.klText
            }

            CharAttribute {
                id: ch
                height: 25
                attrValue: hero.ch
                attrModValue: hero.chMod
                attrColor: "#dd000000"
                attrName: hero.chText
            }

            CharAttribute {
                id: ff
                height: 25
                attrValue: hero.ff
                attrModValue: hero.ffMod
                attrColor: "#f7ff08"
                attrName: hero.ffText
            }

            CharAttribute {
                id: ge
                height: 25
                attrValue: hero.ge
                attrModValue: hero.geMod
                attrColor: "#254ef0"
                attrName: hero.geText
            }

            CharAttribute {
                id: ko
                height: 25
                attrValue: hero.ko
                attrModValue: hero.koMod
                attrColor: "#aeafae"
                attrName: hero.koText
            }

            CharAttribute {
                id: kk
                height: 25
                attrValue: hero.kk
                attrModValue: hero.kkMod
                attrColor: "#ffab00"
                attrName: hero.kkText
            }
        }
    }

    ListView {
        id: skillView
        anchors.fill: parent

        model: skillList
        clip: true

        section.property: "sec"
        section.criteria: ViewSection.FullString
        section.delegate: Rectangle {
            id: skillSection
            width: parent.width
            height: secRow.implicitHeight+4
            color: "lightsteelblue"

            property string label: skillList.getSecName(section)

            Row {
                id: secRow
                anchors.verticalCenter: parent.verticalCenter
                x:2
                spacing: 5

                Label {
                    text: skillSection.label
                    font.bold: true
                    font.pixelSize: Qt.application.font.pixelSize + 3
                    width: 175
                }
                Label { text: qsTr("Check"); width: 100 }
                Label { text: qsTr("ENC"); width: 50 }
                Label { text: qsTr("SR"); width: 30 }
                Label { text: "+"; width: Qt.application.font.pixelSize+5 }
                Label { text: qsTr("Mod"); width: 30 }
                Label { text: qsTr("Comment") }
            }
        }

        delegate: Row {
            spacing: 5
            width: skillView.width - 10
            x:5

            Label {
                id: skillName
                text: name
                width: 170
                font.pointSize: Qt.application.font.pixelSize

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true

                    onEntered: setAttrText("in")
                    onExited: setAttrText("out")
                    onClicked: {
                        activeSkill = index
                        skillContext.popup()
                    }
                }
            }

            Label {
                id: skillCheck
                text: check
                font.pointSize: skillName.font.pointSize
                width: 100
            }
            Label {
                text: burden === 0 ? qsTr("No"):(burden === 1? qsTr("Yes"):qsTr("maybe"))
                width: 50
            }
            Label {
                text: level
                width: 30
            }
            Button {
                anchors.verticalCenter: parent.verticalCenter
                width: skillCheck.height -2
                height: width

                Image {
                    anchors.fill: parent
                    source: "qrc:/img/img/dice.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    activeSkill = index
                    rollTalentDialog.open()
                }
            }

            Label {
                text: mod < 0 ? mod:(mod > 0 ? "+"+mod:"")
                width: 30
            }

            Label {
                text: comment
                clip: true
                Layout.fillWidth: true
            }

            Component.onCompleted: setAttrText("out")

            function setAttrText(state) {
                var attrTest = check.split(",")

                if(state === "in"){
                    skillCheck.text = hero.getAttr(attrTest[0], 1)+" "+hero.getAttr(attrTest[1], 1)+" "+hero.getAttr(attrTest[2], 1)
                }else{
                    skillCheck.text = hero.getAttr(attrTest[0], 0)+" "+hero.getAttr(attrTest[1], 0)+" "+hero.getAttr(attrTest[2], 0)
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            active: true
        }

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

    Menu {
        id: skillContext
        MenuItem {
            text: qsTr("Edit")
            onTriggered: editSkillDialog.open()
        }
    }
    EditSkillDialog {
        id: editSkillDialog
        anchors.centerIn: parent
    }

    ListModel {
        id: skillList

        // Sort items by "sec" and then by name
        function sortSkills() {
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
            var res = a.sec- b.sec

            if(res === 0){
                return a.name.localeCompare(b.name)
            }
            return res
        }
        function getSecName(id){
            var secs = [qsTr("Physical"), qsTr("Social"), qsTr("Nature"), qsTr("Knowledge"), qsTr("Craft")]

            return secs[id]
        }

        ListElement {
            tal:"TAL_1"
            sec: 0
            name: qsTr("Flying")
            level: 0
            check: "mu,in,ge"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_2"
            sec: 0
            name: qsTr("Gaukelei")
            level: 0
            check: "mu,ch,ff"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_3"
            sec: 0
            name: qsTr("Climbing")
            level: 0
            check: "mu,ge,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_4"
            sec: 0
            name: qsTr("Body Control")
            level: 0
            check: "ge,ge,ko"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_5"
            sec: 0
            name: qsTr("Feat of Strength")
            level: 0
            check: "ko,kk,kk"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_6"
            sec: 0
            name: qsTr("Riding")
            level: 0
            check: "ch,ge,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_7"
            sec: 0
            name: qsTr("Swimming")
            level: 0
            check: "ge,ko,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_8"
            sec: 0
            name: qsTr("Self-Control")
            level: 0
            check: "mu,mu,ko"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_9"
            sec: 0
            name: qsTr("Singing")
            level: 0
            check: "kl,ch,ko"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_10"
            sec: 0
            name: qsTr("Perception")
            level: 0
            check: "kl,in,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_11"
            sec: 0
            name: qsTr("Dancing")
            level: 0
            check: "kl,ch,ge"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_12"
            sec: 0
            name: qsTr("Pickpocket")
            level: 0
            check: "mu,ff,ge"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_13"
            sec: 0
            name: qsTr("Stealth")
            level: 0
            check: "mu,in,ge"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_14"
            sec: 0
            name: qsTr("Carousing")
            level: 0
            check: "kl,ko,kk"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_15"
            sec: 1
            name: qsTr("Persuasion")
            level: 0
            check: "mu,kl,ch"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_16"
            sec: 1
            name: qsTr("Seduction")
            level: 0
            check: "mu,ch,ch"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_17"
            sec: 1
            name: qsTr("Intimidation")
            level: 0
            check: "mu,in,ch"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_18"
            sec: 1
            name: qsTr("Etiquette")
            level: 0
            check: "kl,in,ch"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_19"
            sec: 1
            name: qsTr("Streetwise")
            level: 0
            check: "kl,in,ch"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_20"
            sec: 1
            name: qsTr("Empathy")
            level: 0
            check: "kl,in,ch"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_21"
            sec: 1
            name: qsTr("Fast-Talk")
            level: 0
            check: "mu,in,ch"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_22"
            sec: 1
            name: qsTr("Disguise")
            level: 0
            check: "in,ch,ge"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_23"
            sec: 1
            name: qsTr("Willpower")
            level: 0
            check: "mu,in,ch"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_24"
            sec: 2
            name: qsTr("Tracking")
            level: 0
            check: "mu,in,ge"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_20"
            sec: 2
            name: qsTr("Ropes")
            level: 0
            check: "kl,ge,ko"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_26"
            sec: 2
            name: qsTr("Fishing")
            level: 0
            check: "ff,ge,ko"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_27"
            sec: 2
            name: qsTr("Orienting")
            level: 0
            check: "kl,in,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_28"
            sec: 2
            name: qsTr("Plant Lore")
            level: 0
            check: "kl,ff,ko"
            burden: 2
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_29"
            sec: 2
            name: qsTr("Animal Lore")
            level: 0
            check: "mu,mu,ch"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_30"
            sec: 2
            name: qsTr("Survival")
            level: 0
            check: "mu,ge,ko"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_31"
            sec: 3
            name: qsTr("Gambling")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_32"
            sec: 3
            name: qsTr("Geography")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_33"
            sec: 3
            name: qsTr("History")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_34"
            sec: 3
            name: qsTr("Religions")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_35"
            sec: 3
            name: qsTr("Warfare")
            level: 0
            check: "mu,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_36"
            sec: 3
            name: qsTr("Magical Lore")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_37"
            sec: 3
            name: qsTr("Mechanics")
            level: 0
            check: "kl,kl,ff"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_38"
            sec: 3
            name: qsTr("Math")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_39"
            sec: 3
            name: qsTr("Law")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_40"
            sec: 3
            name: qsTr("Myths & Legends")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_41"
            sec: 3
            name: qsTr("Sphere Lore")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_42"
            sec: 3
            name: qsTr("Astronomy")
            level: 0
            check: "kl,kl,in"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_43"
            sec: 4
            name: qsTr("Alchemy")
            level: 0
            check: "mu,kl,ff"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_44"
            sec: 4
            name: qsTr("Sailing")
            level: 0
            check: "ff,ge,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_45"
            sec: 4
            name: qsTr("Driving")
            level: 0
            check: "ch,ff,ko"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_46"
            sec: 4
            name: qsTr("Commerce")
            level: 0
            check: "mu,in,ch"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_47"
            sec: 4
            name: qsTr("Treat Poison")
            level: 0
            check: "mu,kl,in"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_48"
            sec: 4
            name: qsTr("Treat Disease")
            level: 0
            check: "mu,in,ko"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_49"
            sec: 4
            name: qsTr("Treat Soul")
            level: 0
            check: "in,ch,ko"
            burden: 0
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_50"
            sec: 4
            name: qsTr("Treat Wounds")
            level: 0
            check: "kl,ff,ff"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_51"
            sec: 4
            name: qsTr("Woodworking")
            level: 0
            check: "ff,ge,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_52"
            sec: 4
            name: qsTr("Prepare Food")
            level: 0
            check: "in,ff,ff"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_53"
            sec: 4
            name: qsTr("Leatherworking")
            level: 0
            check: "ff,ge,ko"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_54"
            sec: 4
            name: qsTr("Artistic Ability")
            level: 0
            check: "in,ff,ff"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_55"
            sec: 4
            name: qsTr("Metalworking")
            level: 0
            check: "ff,ko,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_56"
            sec: 4
            name: qsTr("Music")
            level: 0
            check: "ch,ff,ko"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_57"
            sec: 4
            name: qsTr("Pick Locks")
            level: 0
            check: "in,ff,ff"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_58"
            sec: 4
            name: qsTr("Earthencraft")
            level: 0
            check: "ff,ff,kk"
            burden: 1
            mod: 0
            comment: ""
        }

        ListElement {
            tal:"TAL_59"
            sec: 4
            name: qsTr("Clothworking")
            level: 0
            check: "kl,ff,ff"
            burden: 1
            mod: 0
            comment: ""
        }
        /*
        Regex for notepad++ to get all skills in the right format from https://github.com/elyukai/optolith-client/blob/master/src/App/Constants/Id.re
          \| ([\d]+) => ([\w]*)
        ListElement {\r\n\ttal:"TAL_\1" \r\n\tsec: qsTr\("Craft"\)\r\n\tname: qsTr\("\2"\)\r\n\tlevel: 0\r\n\tcheck: "mu,kl,in"\r\n\tburden: 0\r\n\tmod: 0\r\n\tcomment: ""\r\n}\r\n
        */
    }
}
