import QtQuick 2.15

Rectangle {
    visible: true
    id: applicationBarContainer
    anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
        bottomMargin: 75
    }
    color: "green"
    height: parent.height/12

    Image {
        id: appIcon
        anchors {
            left: parent.left
            leftMargin: 30
            verticalCenter:  parent.verticalCenter
        }

        height: parent.height *.6
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/phone.png"
    }
}
