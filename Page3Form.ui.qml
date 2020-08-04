import QtQuick 2.12
import QtQuick.Controls 2.12
import "components"

Page {
    width: 600
    height: 400

    header: Label {
        text: qsTr("Spells")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Column {
        id: column
        x: 28
        y: 14
        width: 197
        height: 292
    }
}
