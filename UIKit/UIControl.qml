import QtQuick 2.0

UIView {
    id: superView

    signal clicked()
    signal release()
    signal touchUp()
    signal touchDown()

    Item {
        id: privateProperties
        property bool isPressed: false
    }

    MouseArea {
        id: touchArea
        anchors.fill: parent
        onPressedChanged: {
            privateProperties.isPressed = !privateProperties.isPressed

            if (privateProperties.isPressed) {
                superView.touchDown()
            } else {
                superView.touchUp()
            }
        }

        onClicked: superView.clicked()
    }
}
