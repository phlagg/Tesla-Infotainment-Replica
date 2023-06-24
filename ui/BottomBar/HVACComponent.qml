import QtQuick 2.15

Item {
    property string fontColor: "#4b4b4b"
    property var hvacController
    width: 90 *( parent.width / 1280)

    Rectangle {
        id: decrementButton
        anchors{
            left: parent.left
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
            onClicked: hvacController.incrementTargetTemperature(-1)
        }

    }

    Text {
        id: targetTemperatureText
        anchors {
            left: decrementButton.right
            leftMargin: 15
            verticalCenter: parent.verticalCenter
        }
        color: fontColor
        font.pixelSize: 30
        text: hvacController.targetTemperature

    }

    Rectangle {
        id: incrementButton
        anchors{
            left: targetTemperatureText.right
            leftMargin: 15
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
            onClicked: hvacController.incrementTargetTemperature(1)
        }

    }


}
