import QtQuick 2.0

Item {
    id: superView
    width:200
    height:200

    property color  backgroundColor: "white"

    Rectangle {
        id: background
        anchors.fill: parent
        border.width: 0

    }

    PropertyChanges {
        id: colorChanges
        target: backgroundColor;
        background.color: backgroundColor;
    }


    Component.onCompleted: {
        background.color = Qt.binding(function(){ return backgroundColor; });
    }
}
