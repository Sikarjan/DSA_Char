import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id: addItemDialog
    width: 400

    title: qsTr("Adding Item")

    standardButtons: Dialog.Ok | Dialog.Cancel

    property bool error: false

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Row {
            width: parent.width

            Label {
                text: qsTr("Type")
                width: 100
            }

            ComboBox {
                id: itemType
                width: parent.width-110
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: "item", text: qsTr("Item") },
                    { value: "weapon", text: qsTr("Weapon") },
                    { value: "rangeWeapon", text: qsTr("Range Weapon") },
                    { value: "armor", text: qsTr("Armor") }
                ]
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Item")
                width: 100
            }

            TextField {
                id: itemName
                width: parent.width-110
            }
        }

        Row {
            Label {
                text: qsTr("Weight")
                width: 100
            }

            SpinBox {
                id: itemWeight
                stepSize: 50
                to:10000
                editable: true
                value: 100

                property real realValue: value/100

                validator: DoubleValidator {
                    bottom: Math.min(itemWeight.from, itemWeight.to)
                    top:  Math.max(itemWeight.from, itemWeight.to)
                }

                textFromValue: function(value, locale) {
                    return Number(value / 100).toLocaleString(locale, 'f', 2)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }
        }
        Row {
            Label {
                text: qsTr("Price in Silver")
                width: 100
            }

            SpinBox {
                id: itemPrice
                stepSize: 50
                to: 100000
                editable: true

                property real realValue: value/100

                validator: DoubleValidator {
                    bottom: Math.min(itemPrice.from, itemPrice.to)
                    top:  Math.max(itemPrice.from, itemPrice.to)
                }

                textFromValue: function(value, locale) {
                    return Number(value / 100).toLocaleString(locale, 'f', 2)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }

            CheckBox {
                id: payBox
                checked: true
                text: qsTr("pay")
            }
            Text {
                visible: error
                text: qsTr("Insufficent funds!")
                color: "red"
            }
        }
        Row {
            Label {
                text: qsTr("Amount")
                width: 100
            }

            SpinBox {
                id: itemAmount
                from: 1
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Where")
                width: 100
            }

            ComboBox {
                id: itemWhere
                textRole: "bagName"
                valueRole: "bagId"
                model: page3.bagList
                width: parent.width - 110
            }
        }
        Row {
            width: parent.width
            visible: itemType.currentIndex === 1 || itemType.currentIndex === 2

            Label {
                text: qsTr("Combat Technique")
                width: 100
            }
            ComboBox {
                id: ct
                textRole: "name"
                valueRole: "tal"
                model: pageCombat.ctList
            }
        }
        Row {
            width: parent.width
            visible: itemType.currentIndex === 1 || itemType.currentIndex === 2

            Label {
                text: qsTr("Damage")
                width: 100
            }
            SpinBox {
                id: damageDice
                from: 1
            }
            Label {
                text: qsTr("D6+")
            }
            SpinBox {
                id: damageFlat
                from: -5
                value: 1
            }
        }
        Row {
            width: parent.width
            visible: itemType.currentIndex === 1 || itemType.currentIndex === 2

            Label {
                text: qsTr("Reach")
                width: 100
            }

            ComboBox {
                id: reach
                width: parent.width-110
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: 1, text: qsTr("short") },
                    { value: 2, text: qsTr("medium") },
                    { value: 3, text: qsTr("long") }
                ]
            }
        }
        Row {
            width: parent.width
            visible: itemType.currentIndex === 1 || itemType.currentIndex === 2

            Label {
                text: qsTr("AT/PA Mod")
                width: 100
            }
            SpinBox {
                id: at
                from: -5
                value: 0
            }
            Label{
                text: "/"
            }
            SpinBox {
                id: pa
                from: -5
                value: 0
            }
        }
    }

    onAccepted: {
        var cost = itemAmount.value * itemPrice.value
        if(payBox && cost > hero.money){
            error = true
            addItemDialog.open()
            return
        }

        page3.itemList.append({
                            "item": itemName.text,
                            "type": itemType.currentValue,
                            "amount": itemAmount.value,
                            "weight": itemWeight.realValue,
                            "price": itemPrice.realValue,
                            "whereId": itemWhere.currentValue, // holds bagId
                            "damageDice": damageDice.value,
                            "damageFlat": damageFlat.value,
                            "reach": reach.currentValue,
                            "at": at.value,
                            "pa": pa.value,
                            "ct": ct.currentValue
        })
        page3.itemList.sortItems()

        itemType.currentIndex = 0
        itemName.clear()
        itemAmount.value = 1
        itemWeight.realValue = 1
        itemPrice.realValue = 0

        // Add weight to hero
        hero.addWeight(itemWeight.realValue, itemWhere.currentValue)

        if(payBox){
            hero.money -= cost
        }

        error = false
    }
    onRejected: {
        itemType.currentIndex = 0
        itemName.clear()
        itemAmount.value = 1
        itemWeight.realValue = 1
        itemPrice.realValue = 0
        error = false
    }
}
