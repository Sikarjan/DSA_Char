import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import "components"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    menuBar: MenuBar{
        Menu {
            title: qsTr("Hero")
            Action{
                text: qsTr("&Import")
                onTriggered: importHeroDialog.visible = true
            }
            MenuSeparator{}
            Action{
                text: qsTr("&Quit")
                onTriggered: Qt.quit()
            }
        }
    }

    FileDialog {
        id: importHeroDialog
        title: qsTr("Import Hero from Optholit")
        folder: shortcuts.home
        defaultSuffix: "json"
        nameFilters: ["Hero Files (*.json)"]
        onAccepted: hero.importHero(importHeroDialog.fileUrl)
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
            leP {
                onValueChanged: hero.le = leP.value
            }
        }

        Page2Form {
        }

        Page3Form {
        }
    }

    Hero{
        id:hero
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Hero")
        }
        TabButton {
            text: qsTr("Skills")
        }
        TabButton {
            text: qsTr("Spells")
        }
    }
}
