import QtQuick 2.0

UIView {
    id: self

    signal clicked()
    signal release()
    signal touchUp()
    signal touchDown()

    function isPressed() {
        return privateProperties.isPressed
    }

    QtObject {
        id: privateProperties
        property bool isPressed: false
    }

    MouseArea {
        id: touchArea
        anchors.fill: parent
        onPressedChanged: {
            privateProperties.isPressed = !privateProperties.isPressed
            if (privateProperties.isPressed) {
                self.touchDown()
            } else {
                self.touchUp()
            }
        }

        onClicked: self.clicked()
    }
}
