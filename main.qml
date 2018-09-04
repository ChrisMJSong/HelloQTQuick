import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: win
    width: 640
    height: 480

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
        width: 113
        height: 46
        text: qsTr("Hello")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: label.bottom
        anchors.topMargin: 50
    }

}
