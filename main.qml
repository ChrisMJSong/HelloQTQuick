import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2

Rectangle {
    id: win
    width: 640
    height: 480



    MessageDialog {
        id: messageDialog
        title: "somthing"
        text: "asdfasdf"
        onAccepted: {
            // do something
        }
//        Component.onCompleted: visible = true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked(container.cellColor)
    }

    Grid {
        id: colorPicker
        x: 4; anchors.bottom: page.bottom; anchors.bottomMargin: 4
        rows: 2; columns: 3; spacing: 3

        Cell { cellColor: "red"; onClicked: label.color = cellColor }
        Cell { cellColor: "green"; onClicked: label.color = cellColor }
        Cell { cellColor: "blue"; onClicked: label.color = cellColor }
        Cell { cellColor: "yellow"; onClicked: label.color = cellColor }
        Cell { cellColor: "steelblue"; onClicked: label.color = cellColor }
        Cell { cellColor: "black"; onClicked: label.color = cellColor }
    }

    Label {
        id: label
        x: 193
        y: 205
        text: qsTr("Hello QT!")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pointSize: 60
    }

    Button {
        id: button
        x: 264
        y: 2
        width: 113
        height: 46
        text: qsTr("Hello")
        bottomPadding: -8
        rightPadding: -4
        padding: -7
        autoExclusive: false
        checked: false
        checkable: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: label.bottom
        anchors.topMargin: 50

        onClicked: {
            viewController.testAlert("Button Clicked!");
        }
    }

    Connections {
        target: viewController

        onSignalFunc: {
            messageDialog.text = msg;
            messageDialog.open();
        }
    }
}
