import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import "HCUIKit"

//import UIKit 1.0

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
    }


    Grid {
        id: colorPicker
        rows: 2; columns: 3; spacing: 3

        MouseArea {
            onClicked: container.clicked(container.cellColor)
        }

        Cell { cellColor: "red"; onClicked: label.color = cellColor }
        Cell { cellColor: "green"; onClicked: label.color = cellColor }
        Cell { cellColor: "blue"; onClicked: label.color = cellColor }
        Cell { cellColor: "yellow"; onClicked: label.color = cellColor }
        Cell { cellColor: "steelblue"; onClicked: label.color = cellColor }
        Cell { cellColor: "black"; onClicked: label.color = cellColor }
    }

    Button {
        id: popupButton
        x: 130
        y: 0
        width: 106
        height: 53
        text: qsTr("Popup Text")

        Image {
            id: image
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            source: ""
        }
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

        states: State {
            name: "down"; when: popupButton.pressed === true  //when: mouseArea.pressed === true
            PropertyChanges { target: label; anchors.verticalCenterOffset: -100; y: 160; rotation: 40; color: "red" }
        }

        transitions: Transition {
            from: ""; to: "down"; reversible: true
            ParallelAnimation {
                NumberAnimation { properties: "anchors.verticalCenterOffset,rotation"; duration: 500; easing.type: Easing.InOutQuad }
                ColorAnimation { duration: 500 }
            }
        }
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
            uIButton.state
        }
    }

    Text {
        id: hiddenText
        x: uIView.x
        y: uIView.y
        width: uIView.width
        height: 100
        text: qsTr("HIDDEN\nTEXT")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 26
    }

    Connections {
        target: viewController

        onSignalFunc: {
            messageDialog.text = msg;
            messageDialog.open();
        }
    }

    UIView {
        id: uIView
        width: 100
        height: 100
        anchors.right: uIButton.left
        anchors.rightMargin: 34
        anchors.verticalCenterOffset: -100
        anchors.verticalCenter: parent.verticalCenter
        backgroundColor: "#ff0000"
        opacity: 0.95
    }

    UIControl {
        id: uIControl
        width: 100
        height: 100
        opacity: 0.7
        anchors.verticalCenterOffset: -100
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: uIButton.right
        anchors.leftMargin: 44
        visible: true
        backgroundColor: "#0000ff"
        // 클릭 이벤트 (기타 이벤트는 바인딩 하지 않음)
        onClicked: { console.log("버튼 상태변경 "); uIButton.enabled = !uIButton.enabled}
    }

    UIButton {
        id: uIButton
        height: 100
        anchors.verticalCenterOffset: -100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        title: "NORMAL"
        selected: false
        backgroundImageSource: "bt_gray_n.png"
        backgroundColor: "#00000000"
        // 클릭 이벤트
        onClicked: {
            console.log("Button clicked")
            selected = !selected
        }
        // 눌림 이벤트
        onTouchDown: {
            console.log("Button pressed")
        }
        // 릴리즈 이벤트
        onTouchUp: {
            console.log("Button released")
        }

        Component.onCompleted: {
            // 노멀 상태 이외의 기타 버튼 설정함.
            // 노멀은 기본 설정시 자동으로 설정됨. (오버라이딩 해도 상관없음)
            // 상태는 0: normal, 1: highlighted, 2: selected, 3: disabled
            var stateHighlighted = stateNameAtIndex(1)  // 상태 이름을 인덱스 형태로 가져올 수도 있음.
            setTitleForState("HIGHLIGHT", stateHighlighted);
            setTitleForState("SELECTED", "selected");
            setBackgroundImageForState("../bt_gray_p.png", stateHighlighted)
            setBackgroundImageForState("../bt_gray_p.png", "selected")
        }
    }

    UISlider {
        id: uISlider
        width: label.width
        value: 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: label.bottom
        anchors.topMargin: 6
        minTrackColor: "#38558c"
        maxTrackColor: "#3f3f41"
        thumbImageSource: "../bt_pick.png"

        onValueChanged: {
            uIView.opacity = value
            value = value > 0.1 ? value : 0.1   // 값에 제한을 두고자 할때 이와 같이 사용.
        }
    }

}
