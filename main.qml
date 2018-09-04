import QtQuick 2.0
import QtQuick.Window 2.3
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
