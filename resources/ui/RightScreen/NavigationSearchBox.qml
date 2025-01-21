import QtQuick 2.15

Rectangle {
    id: navSearchBox
    radius: 8

    color: "#f0f0f0"

    Image {
        id: searchIcon
        source: "qrc:/resources/ui/assets/search.png"

        anchors {
            left: parent.left
            leftMargin: 25
            verticalCenter: parent.verticalCenter
        }
        height: parent.height * 0.4
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: navigationPlaceholderText
        visible: navigationTextInput.text == ""
        text: "Navigate"
        color: "#989898"
        font.bold: true
        font.pixelSize: 18

        anchors {
            verticalCenter: parent.verticalCenter
            left: searchIcon.right
            leftMargin: 20
        }
    }

    TextInput {
        id: navigationTextInput
        clip: true
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: searchIcon.right
            leftMargin: 20
        }
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
    }
}
