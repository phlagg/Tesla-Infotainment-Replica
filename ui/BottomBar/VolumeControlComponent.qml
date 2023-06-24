import QtQuick 2.15

Item {
    property string fontColor: "#4b4b4b"
    width: 120 *( parent.width / 1280)

    Connections {
        target: audioController
        function onVolumeLevelChanged() {
            if(audioController.volumeLevel > 0){
            visibleTimer.stop()
            volumeIcon.visible = false
            visibleTimer.start()
            }
        }
    }

    Timer {
        id: visibleTimer
        interval: 1500
        repeat: false
        onTriggered: {
            volumeIcon.visible = true
        }
    }

    Rectangle {
        id: decrementButton
        anchors{
            right: volumeIcon.left
            rightMargin: 15
            top: parent.top
            bottom: parent.bottom

        }
        width: height / 2
        color: "black"
        Text {
            id: decrementText
            anchors.centerIn: parent
            text: "<"
            font.pixelSize: 16
            color: fontColor
        }
        MouseArea {
            anchors.fill: parent
            onClicked: audioController.incrementVolume(-1)
        }

    }

    Image {
        id: volumeIcon
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors {
            right: incrementButton.left
            rightMargin: 15
            verticalCenter: parent.verticalCenter
        }
        source: {
            if(audioController.volumeLevel < 1)
                return "qrc:/ui/assets/volmute.png"
            if(audioController.volumeLevel >= 1 && audioController.volumeLevel < 3)
                return "qrc:/ui/assets/vol0.png"
            if(audioController.volumeLevel >= 3 && audioController.volumeLevel < 5)
                return "qrc:/ui/assets/vol1.png"
            if(audioController.volumeLevel >= 5 && audioController.volumeLevel < 8)
                return "qrc:/ui/assets/vol2.png"
            if(audioController.volumeLevel >= 8)
                return "qrc:/ui/assets/vol3.png"

        }
        MouseArea {
            anchors.fill: parent
            onClicked: audioController.toggleMuteVolume()
        }
    }

    Text {
        id: volumeTextLabel
        visible: !volumeIcon.visible
        anchors {
            centerIn: volumeIcon
        }
        color: fontColor
        font.pixelSize: 30
        text: audioController.volumeLevel

    }

    Rectangle {
        id: incrementButton
        anchors{
            right: parent.right
            top: parent.top
            bottom: parent.bottom

        }
        width: height / 2
        color: "black"
        Text {
            id: incrementText
            anchors.centerIn: parent
            text: ">"
            font.pixelSize: 16
            color: fontColor
        }
        MouseArea {
            anchors.fill: parent
            onClicked: audioController.incrementVolume(1)
        }

    }


}
