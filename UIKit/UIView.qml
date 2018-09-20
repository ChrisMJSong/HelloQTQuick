import QtQuick 2.0

Item {
    id: self

    property color  backgroundColor: "#FFFFFF"

    width:200
    height:200

    Rectangle {
        id: background
        anchors.fill: parent
        border.width: 0
    }

    Component.onCompleted: {
        background.color = Qt.binding(function(){ return backgroundColor; });
    }
}
