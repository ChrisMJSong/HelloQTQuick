import QtQuick 2.0

UIControl {
    id: self

    // MARK: Property declarations
    property string title: "Button"
    property color tintColor: "#49A0F8"
    property url imageSource: ""
    property url backgroundImageSource: ""
    property bool selected: false

    // MARK: javascript functions
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
        case uiControlState.highlighted:
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

    function setTitleForState(title, state) {
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

    function setImageForState(imageSource, state) {
        var index = indexForState(state)
        privateProperties.imageSources[index] = imageSource;

        if(self.state === state) {
            imageSources.source = imageSource
        }
    }

    function imageForState(state) {
        var index = indexForState(state)
        var imageSource = privateProperties.imageSources[index];

        if (imageSource === undefined || imageSource.length === 0) {
            imageSource = privateProperties.imageSources[0];
        }

        return imageSource;
    }

    function setBackgroundImageForState(imageSource, state) {
        var index = indexForState(state)
        privateProperties.backgroundImageSources[index] = imageSource;

        if(self.state === state) {
            backgroundImage.source = imageSource
        }
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
    backgroundColor: "#00000000"

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
    BorderImage {
        id: backgroundImage
        source: ""
        anchors.fill: parent
        border {
            left: 10
            top: 10
            right: 10
            bottom: 20
        }
    }

    Image {
        id: image
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        visible: true
        source: ""

        onStatusChanged: {
            if(status == Image.Ready) {
                var targetWidth = sourceSize.width;
                var targetHeight = sourceSize.height;

                if (targetWidth > parent.width) {
                    targetWidth = parent.width
                }
                if (targetHeight > parent.height) {
                    targetHeight = parent.height
                }
                width = targetWidth / Screen.devicePixelRatio
                height = targetHeight / Screen.devicePixelRatio
            }
        }
    }

    Text {
        id: titleLabel
        text: qsTr("Button")
        anchors{
            left: parent.left
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
            name: uiControlState.normal
            when: !self.selected && self.enabled
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.normal);
            }
            PropertyChanges {
                target: image;
                source: imageForState(uiControlState.normal)
            }
            PropertyChanges {
                target: backgroundImage;
                source: backgroundImageForState(uiControlState.normal)
            }
        },
        State {
            name: uiControlState.highlighted
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.highlighted);
            }
            PropertyChanges {
                target: image;
                source: imageForState(uiControlState.highlighted)
            }
            PropertyChanges {
                target: backgroundImage;
                source: backgroundImageForState(uiControlState.highlighted)
            }
        },
        State {
            name: uiControlState.selected
            when: self.selected
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.selected);
            }
            PropertyChanges {
                target: image;
                source: imageForState(uiControlState.selected)
            }
            PropertyChanges {
                target: backgroundImage;
                source: backgroundImageForState(uiControlState.selected)
            }
        },
        State {
            name: uiControlState.disabled
            when: !self.enabled
            PropertyChanges {
                target: titleLabel;
                text: titleForState(uiControlState.disabled);
            }
            PropertyChanges {
                target: image;
                source: imageForState(uiControlState.disabled)
            }
            PropertyChanges {
                target: backgroundImage;
                source: backgroundImageForState(uiControlState.disabled)
            }
        }
    ]

    // MARK: Signal
    onTouchUp: {
        state = isSelected() ? uiControlState.selected : uiControlState.normal
    }

    onTouchDown: {
        self.state = uiControlState.highlighted
    }

    Component.onCompleted: {
        self.state = uiControlState.normal
        titleLabel.text = Qt.binding(function() {return privateProperties.titles[0] = title;})
        titleLabel.color = Qt.binding(function() {return tintColor;})
        image.source = Qt.binding(function() { return privateProperties.imageSources[0] = imageSource; })
        backgroundImage.source = Qt.binding(function() { return privateProperties.backgroundImageSources[0] = backgroundImageSource; })
    }
}
