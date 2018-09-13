import QtQuick 2.0

UIControl {    
    id: self

    // MARK: Property declarations
    property string title: "Button"
    property color tintColor: "#49A0F8"
    property string backgroundImageSource: ""
    property bool selected: false

    function setImageAtState(state) {
    }

    function isSelected() {
        return selected
    }

    function changuiControlStateAction(state) {
        switch (state) {
        case "normal":
            break;
        case "highlighted":
            break;
        case "normal":
            break;
        case "normal":
            break;
        }
    }

    function indexForState(state) {
        var index = 0;
        switch (state) {
        case uiControlState.normal:
            index = 1
            break;
        case uiControlState.selected:
            index = 2
            break;
        case uiControlState.disabled:
            index = 3
            break;

        case uiControlState.normal:
        default:
            break;
        }

        return index
    }

    // MARK: javascript functions
    function setTitleForSate(title, state) {
        var index = indexForState(state)
        privateProperties.titles[index] = title;

        if(self.state === state) {
            titleLabel.text = title
        }
    }

    function titleForState(state) {
        var index = indexForState(state)
        var titleText = privateProperties.titles[index];

        if (titleText === undefined || titleText.length === 0) {
            titleText = privateProperties.titles[0];
        }

        return titleText;
    }

    function setBackgroundImageForSate(imageSource, state) {
        var index = indexForState(state)
        privateProperties.backgroundImageSources[index] = imageSource;
    }

    function backgroundImageForState(state) {
        var index = indexForState(state)
        var imageSource = privateProperties.backgroundImageSources[index];

        if (imageSource === undefined || imageSource.length === 0) {
            imageSource = privateProperties.backgroundImageSources[0];
        }

        return imageSource;
    }

    // MARK: Object properties
    width: 100
    height: 50

    // MARK: Private Properties
    QtObject {
        id: privateProperties

        property variant titles: ["", "", "", ""]
        property variant imageSources: ["", "", "", ""]
        property variant backgroundImageSources: ["", "", "", ""]
    }

    QtObject {
        id: uiControlState
        property string normal: "normal"
        property string highlighted: "highlighted"
        property string selected: "selected"
        property string disabled: "disabled"
    }

    // MARK: Child objects
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/qtquickplugin/images/template_image.png"
    }

    Image {
        id: image
        width: 0    // 기본으로 이미지를 표시하지 않음.
        anchors{
            left: parent.left
            leftMargin: 0
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }
        source: ""
    }

    Text {
        id: titleLabel
        text: qsTr("Button")
        anchors{
            left: image.right
            leftMargin: 8
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
            right: parent.right
            rightMargin: 8
        }
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }


    // MARK: State
    states: [
        State {
            id: state1
            name: uiControlState.normal
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.normal);
            }
        },
        State {
            name: uiControlState.highlighted
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.highlighted);
            }
        },
        State {
            name: uiControlState.selected
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.selected);
            }
        },
        State {
            name: uiControlState.disabled
            when: !self.enabled
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.disabled);
            }
        }
    ]

    // MARK: Signal
    onTouchUp: {
        state = isSelected() ? uiControlState.selected : uiControlState.normal
    }

    onTouchDown: {
        state = uiControlState.highlighted
    }

    Component.onCompleted: {
        self.state = uiControlState.normal
        titleLabel.text = Qt.binding(function() {return privateProperties.titles[0] = title;})
        titleLabel.color = Qt.binding(function() {return tintColor;})
        backgroundImage.source = Qt.binding(function() { return backgroundImageSource; })
    }
}
