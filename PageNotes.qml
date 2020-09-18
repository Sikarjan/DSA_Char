import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.1
import QtQuick.Dialogs 1.3
import io.qt.examples.texteditor 1.0

Page {
    id: page
    width: 600
    height: 400

    Settings {
        property alias notes: note.text
        property alias openFolder: openDialog.folder
        property alias saveFolder: saveDialog.folder
    }

    header: Label {
        text: qsTr("Notes")
        font.pixelSize: fontSizeLarge
    }

    FileDialog {
        id: openDialog
        nameFilters: ["Text files (*.txt)", "HTML files (*.html *.htm)"]
        folder: shortcuts.home
        onAccepted: document.load(openDialog.fileUrl)
    }

    FileDialog {
        id: saveDialog
        defaultSuffix: document.fileType
        nameFilters: openDialog.nameFilters
        folder: shortcuts.home
        onAccepted: document.saveAs(saveDialog.fileUrl)
    }
    FontDialog {
        id: fontDialog
        onAccepted: {
            document.fontFamily = font.family;
            document.fontSize = font.pointSize;
        }
    }
/*    ColorDialog { // Causes warnings and does not work
        id: colorDialog
        currentColor: "black"
    }*/
    MessageDialog {
        id: errorDialog
    }

    DocumentHandler {
        id: document
        document: note.textDocument
        cursorPosition: note.cursorPosition
        selectionStart: note.selectionStart
        selectionEnd: note.selectionEnd
        textColor: "black"
        Component.onCompleted: document.load("qrc:/texteditor.html")
        onLoaded: {
            note.text = text
        }
        onError: {
            errorDialog.text = message
            errorDialog.visible = true
        }
    }

    Column{
        anchors.fill: parent
        spacing: 5

        ToolBar {
            id: menuRow
            leftPadding: 8

            RowLayout {
                id: flow
                width: parent.width

                Row {
                    id: fileRow
                    ToolButton {
                        id: openButton
                        text: "\uF115" // icon-folder-open-empty
                        font.family: "fontello"
                        onClicked: openDialog.open()
                    }
                    ToolSeparator {
                        contentItem.visible: fileRow.y === editRow.y
                    }
                }

                Row {
                    id: editRow
                    ToolButton {
                        id: copyButton
                        text: "\uF0C5" // icon-docs
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        enabled: note.selectedText
                        onClicked: note.copy()
                    }
                    ToolButton {
                        id: cutButton
                        text: "\uE800" // icon-scissors
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        enabled: note.selectedText
                        onClicked: note.cut()
                    }
                    ToolButton {
                        id: pasteButton
                        text: "\uF0EA" // icon-paste
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        enabled: note.canPaste
                        onClicked: note.paste()
                    }
                    ToolSeparator {
                        contentItem.visible: editRow.y === formatRow.y
                    }
                }

                Row {
                    id: formatRow
                    ToolButton {
                        id: boldButton
                        text: "\uE806" // icon-bold
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.bold
                        onClicked: document.bold = !document.bold
                    }
                    ToolButton {
                        id: italicButton
                        text: "\uE80A" // icon-italic
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.italic
                        onClicked: document.italic = !document.italic
                    }
                    ToolButton {
                        id: underlineButton
                        text: "\uF0CD" // icon-underline
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.underline
                        onClicked: document.underline = !document.underline
                    }
                    ToolButton {
                        id: fontFamilyToolButton
                        text: qsTr("\uE805") // icon-font
                        font.family: "fontello"
                        font.bold: document.bold
                        font.italic: document.italic
                        font.underline: document.underline
                        onClicked: {
                            fontDialog.currentFont.family = document.fontFamily;
                            fontDialog.currentFont.pointSize = document.fontSize;
                            fontDialog.open();
                        }
                    }
                    ToolButton {
                        text: qsTr("\uf0ca") // icon-unordered list
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.ul
                        onClicked: document.ul = !document.ul
                    }

                    ToolSeparator {
                        contentItem.visible: formatRow.y === alignRow.y
                    }
                }

                Row {
                    id: alignRow
                    ToolButton {
                        text: "\uE801" // icon-align-left
                        font.family: "fontello"
                        onClicked: alignmentMenu.open()
                    }

                    Menu {
                        id: alignmentMenu

                        MenuItem {
                            text: "\uE801" // icon-align-left
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignLeft
                            onClicked: document.alignment = Qt.AlignLeft
                        }
                        MenuItem {
                            text: "\uE802" // icon-align-center
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignHCenter
                            onClicked: document.alignment = Qt.AlignHCenter
                        }
                        MenuItem {
                            text: "\uE803" // icon-align-right
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignRight
                            onClicked: document.alignment = Qt.AlignRight
                        }
                        MenuItem {
                            text: "\uE804" // icon-align-justify
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                            checkable: true
                            checked: document.alignment == Qt.AlignJustify
                            onClicked: document.alignment = Qt.AlignJustify
                        }
                    }
                }

/*
                Row {
                    id: alignRow
                    ToolButton {
                        id: alignLeftButton
                        text: "\uE801" // icon-align-left
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.alignment == Qt.AlignLeft
                        onClicked: document.alignment = Qt.AlignLeft
                    }
                    ToolButton {
                        id: alignCenterButton
                        text: "\uE802" // icon-align-center
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.alignment == Qt.AlignHCenter
                        onClicked: document.alignment = Qt.AlignHCenter
                    }
                    ToolButton {
                        id: alignRightButton
                        text: "\uE803" // icon-align-right
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.alignment == Qt.AlignRight
                        onClicked: document.alignment = Qt.AlignRight
                    }
                    ToolButton {
                        id: alignJustifyButton
                        text: "\uE804" // icon-align-justify
                        font.family: "fontello"
                        focusPolicy: Qt.TabFocus
                        checkable: true
                        checked: document.alignment == Qt.AlignJustify
                        onClicked: document.alignment = Qt.AlignJustify
                    }
                }*/
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height-menuRow.height - parent.spacing

            TextArea {
                id: note

                wrapMode: TextEdit.Wrap
                textFormat: Qt.RichText
                selectByMouse: true
                persistentSelection: true
                onLinkActivated: Qt.openUrlExternally(link)
                leftPadding: 55
                rightPadding: 55
                topPadding: 15
                bottomPadding: 15
                background: RowLayout {
                    Image{
                        source: "qrc:/img/img/BalkenSymboleLinks.png"
                    }
                    Rectangle {
                        height: 2
                        Layout.fillWidth: true
                    }
                    Image{
                        source: "qrc:/img/img/BalkenSymboleRechts.png"
                    }
                }

                placeholderText: qsTr("Here is some room for you personal notes.")

                MouseArea {
                    acceptedButtons: Qt.RightButton
                    anchors.fill: parent
                    onClicked: contextMenu.popup()
                }
            }
        }
    }
    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Copy")
            enabled: note.selectedText
            onTriggered: note.copy()
        }
        MenuItem {
            text: qsTr("Cut")
            enabled: note.selectedText
            onTriggered: note.cut()
        }
        MenuItem {
            text: qsTr("Paste")
            enabled: note.canPaste
            onTriggered: note.paste()
        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("Font...")
            onTriggered: fontDialog.open()
        }

/*        MenuItem {
            text: qsTr("Color...")
            onTriggered: colorDialog.open()
        }*/
    }
}
