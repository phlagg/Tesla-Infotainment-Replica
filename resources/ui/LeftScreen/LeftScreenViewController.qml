import QtQuick 2.15


Rectangle {
    id: hideButton
    anchors{
        right: parent.right
        rightMargin: -1 * width
        verticalCenter: parent.verticalCenter
    }
    width: parent.width /12
    height: parent.height / 12
    color: "black"
    Text {
        id: hideButtonText
        anchors {
            right: parent.right
            rightMargin: 15
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        text: "<"
        font.pixelSize: 16
        color: fontColor
    }
    MouseArea {
        anchors.fill: parent
            onClicked: leftScreen.visible = false
    }
}


