import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id: addItemDialog
    width: 400

    title: qsTr("Add Spell")

    standardButtons: Dialog.Ok | Dialog.Cancel

    onVisibleChanged: {
        if(visible && pageMagic.activeSpell >= 0){
            var spell = pageMagic.spellModel.get(pageMagic.activeSpell)
            var attr = ["mu","kl","in","ch","ff","ge","ko","kk"]
            var imp = ["A","B","C","D"]
            var test = spell.check.split("/")
            spellName.text = spell.spell
            attr1.currentIndex = attr.indexOf(test[0])
            attr2.currentIndex = attr.indexOf(test[1])
            attr3.currentIndex = attr.indexOf(test[2])
            sr.value = spell.sr
            cost.text = spell.cost
            time.text = spell.time
            range.text = spell.range
            duration.text = spell.duration
            prop.currentIndex = prop.model.indexOf(spell.property)
            improve.currentIndex = imp.indexOf(spell.improve)
            effect.text = spell.effect
        }
    }

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Row {
            width: parent.width

            Label {
                text: qsTr("Name")
                width: 100
            }

            TextField {
                id: spellName
                width: parent.width-110
            }
        }

        Row {
            width: parent.width
            spacing: 2

            Label {
                text: qsTr("Check")
                width: 100
            }

            ComboBox {
                id: attr1
                width: (parent.width-118)/3
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "mu", text: hero.muText },
                    { value: "kl", text: hero.klText },
                    { value: "intu", text: hero.inText },
                    { value: "ch", text: hero.chText },
                    { value: "ff", text: hero.ffText },
                    { value: "ge", text: hero.geText },
                    { value: "ko", text: hero.koText },
                    { value: "kk", text: hero.kkText },
                ]
            }
            ComboBox {
                id: attr2
                width: (parent.width-110)/3
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "mu", text: hero.muText },
                    { value: "kl", text: hero.klText },
                    { value: "intu", text: hero.inText },
                    { value: "ch", text: hero.chText },
                    { value: "ff", text: hero.ffText },
                    { value: "ge", text: hero.geText },
                    { value: "ko", text: hero.koText },
                    { value: "kk", text: hero.kkText },
                ]
            }
            ComboBox {
                id: attr3
                width: (parent.width-110)/3
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "mu", text: hero.muText },
                    { value: "kl", text: hero.klText },
                    { value: "intu", text: hero.inText },
                    { value: "ch", text: hero.chText },
                    { value: "ff", text: hero.ffText },
                    { value: "ge", text: hero.geText },
                    { value: "ko", text: hero.koText },
                    { value: "kk", text: hero.kkText },
                ]
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Spell Rate")
                width: 100
            }

            SpinBox {
                id: sr
                from: 0
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Cost")
                width: 100
            }

            TextField {
                id: cost
                width: parent.width-110
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Casting Time")
                width: 100
            }

            TextField {
                id: time
                width: parent.width-110
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Range")
                width: 100
            }

            TextField {
                id: range
                width: parent.width-110
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Duration")
                width: 100
            }

            TextField {
                id: duration
                width: parent.width-110
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Property")
                width: 100
            }

            ComboBox {
                id: prop
                width: parent.width-110
                model: [
                    qsTr("Anti-Magic"),
                    qsTr("Clairvoyance"),
                    qsTr("Demonic"),
                    qsTr("Elemental"),
                    qsTr("Healing"),
                    qsTr("Illusion"),
                    qsTr("Influence"),
                    qsTr("Object"),
                    qsTr("Spheres"),
                    qsTr("Telekinesis"),
                    qsTr("Transformation")
                ]
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Improve")
                width: 100
            }

            ComboBox {
                id: improve
                model: ["A", "B", "C", "D"]
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Effect")
                width: 100
            }

            TextField {
                id: effect
                width: parent.width-110
                wrapMode: Text.WordWrap
            }
        }
    }

    onAccepted: {
        var mSpell = {
            "spell": spellName.text,
            "check": attr1.currentText.toLowerCase()+"/"+attr2.currentText.toLowerCase()+"/"+attr3.currentText.toLowerCase(),
            "sr": sr.value,
            "cost": cost.text,
            "time": time.text,
            "range": range.text,
            "duration": duration.text,
            "prop": prop.currentText,
            "impr": improve.currentText,
            "effect": effect.text
            }
        if(pageMagic.activeSpell == -1){
            pageMagic.spellModel.append(mSpell)
        }else{
            pageMagic.spellModel.set(pageMagic.activeSpell,mSpell)
        }

        var spellStore = []
        for(var i=0;i<pageMagic.spellModel.count;i++){
            spellStore.push(pageMagic.spellModel.get(i))
        }
        pageMagic.spellListStore = JSON.stringify(spellStore)
        pageMagic.spellModel.sortSpells()

        clearDialog()
    }

    onRejected: {
        clearDialog()
    }

    function clearDialog(){
        spellName.text = ""
        attr1.currentIndex = 0
        attr2.currentIndex = 0
        attr3.currentIndex = 0
        sr.value = 0
        cost.text = ""
        time.text = ""
        range.text = ""
        duration.text = ""
        prop.currentIndex = 0
        improve.currentIndex = 0
        effect.text = ""
        pageMagic.activeSpell = -1
    }
}
