import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Dialog {
    id: editBagDialog
    width: 400
    height: 300
    title: qsTr("Edit Bag")

    standardButtons: Dialog.Ok | Dialog.Cancel

    onVisibleChanged: {
        if(!editBagDialog.visible)
            return

        var bag = bagList.get(bagList.activeId)

        bagName.text = bag["bagName"]
        bagCapacity.value = bag["size"]
        bagWeight.value = bag["weight"]*100
        bagPrice.value = bag["price"]*100
        bagWhere.text = bag["where"]
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Row {
            width: parent.width

            Label {
                text: qsTr("Bag Name")
                width: 100
            }

            TextField {
                id: bagName
                width: parent.width-110
            }
        }
        Row {
            width: parent.width

            Label {
                text: qsTr("Capacity")
                width: 100
            }

            SpinBox {
                id: bagCapacity
                from: 1
                to: 500
            }
        }
        Row {
            Label {
                text: qsTr("Weight")
                width: 100
            }

            SpinBox {
                id: bagWeight
                stepSize: 50
                to:10000
                editable: true
                value: 100

                property real realValue: value/100

                validator: DoubleValidator {
                    bottom: Math.min(bagWeight.from, bagWeight.to)
                    top:  Math.max(bagWeight.from, bagWeight.to)
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
                id: bagPrice
                stepSize: 50
                to: 100000
                editable: true

                property real realValue: value/100

                validator: DoubleValidator {
                    bottom: Math.min(bagPrice.from, bagPrice.to)
                    top:  Math.max(bagPrice.from, bagPrice.to)
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
            width: parent.width

            Label {
                text: qsTr("Where")
                width: 100
            }

            TextField {
                id: bagWhere
                width: parent.width-110
            }
        }
    }

    onAccepted: {
        bagList.setProperty(bagList.activeId, "bagName", bagName.text)
        bagList.setProperty(bagList.activeId, "size", bagCapacity.value)
        bagList.setProperty(bagList.activeId, "weight", bagWeight.realValue)
        bagList.setProperty(bagList.activeId, "price", bagPrice.realValue)
        bagList.setProperty(bagList.activeId, "where", bagWhere.text)
    }
}
