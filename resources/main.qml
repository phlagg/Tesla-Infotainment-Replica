import QtQuick 2.15
import QtQuick.Window 2.15
import "ui/BottomBar"
import "ui/RightScreen"
import "ui/LeftScreen"
import "ui/ApplicationBar"


Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Tesla Infotainment")
    property alias leftScreenStack: leftScreenStack

    RightScreen {
        id: rightScreen
    }

    LeftScreen {
        id: leftScreen
    }

    BottomBar {
        id: bottomBar
    }

    ApplicationBar {
        id: applicationBar
    }
}
