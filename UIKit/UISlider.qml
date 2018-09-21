import QtQuick 2.0
import QtQuick.Controls 2.2

Slider {
    id: control

    property color minTrackColor: "#1484F7"
    property color maxTrackColor: "#B8B8B8"
    property color thumbColor: "#FFFFFF"
    property string minImageSource: ""
    property string maxImageSource: ""
    property string thumbImageSource: ""

    value: 0.5

    background: Rectangle {
        id: maxTrack
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: maxTrackColor

        Rectangle {
            id: minTrack
            width: control.visualPosition * parent.width
            height: parent.height
            color: minTrackColor
            radius: 2
        }
    }

    handle: Rectangle {
        id: thumb

        Image{
            id: thumbImage

            anchors.fill: parent
            source: thumbImageSource

            onStatusChanged: {
                if(status === Image.Ready) {
                    thumb.width = sourceSize.width / 2
                    thumb.height = sourceSize.height / 2
                    thumb.border.color = "transparent"
                } else {
                    thumb.width = thumb.implicitWidth
                    thumb.height = thumb.implicitHeight
                    thumb.border.color = "#BBBBBB"
                }
            }
        }

        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: implicitWidth
        radius: implicitWidth / 2
        border.color: "#BBBBBB"
    }

    Component.onCompleted: {
        minTrack.color  = Qt.binding( function() { return minTrackColor })
        maxTrack.color  = Qt.binding( function() { return maxTrackColor })
        thumb.color     = Qt.binding( function() { return thumbImage.status === Image.Ready ? "transparent" : thumbColor })
        thumbImage.source = Qt.binding( function() { return thumbImageSource } )
    }
}
