import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12

Dialog {
    id: addItemDialog
    width: 400

    title: qsTr("Adding Item")

    standardButtons: Dialog.Ok | Dialog.Cancel

    Column {
        id: content
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

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
                text: qsTr("Price")
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
    }

    onAccepted: {
        page3.itemList.append({
                            "item": itemName.text,
                            "amount": itemAmount.value,
                            "weight": itemWeight.realValue,
                            "price": itemPrice.realValue,
                            "whereId": itemWhere.currentValue // holds bagId
        })
        page3.itemList.sortItems()

        itemName.clear()
        itemAmount.value = 1
        itemWeight.realValue = 1
        itemPrice.realValue = 0

        // Add weight to hero
        hero.addWeight(itemWeight.realValue, itemWhere.currentValue)
    }
}
