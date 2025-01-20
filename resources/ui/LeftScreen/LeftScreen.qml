import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item {
    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
    }
    width: parent.width / 3
    visible: true

    property Component carInfo: CarInfo {}

    StackView {
        id: leftScreenStack
        initialItem: teal
        anchors.fill: parent
        width: window.width / 2

        delegate: StackViewDelegate {
            function transitionFinished(properties) {
                properties.exitItem.opacity = 1;
            }

            pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "x"
                    from: 0
                    to: target.width
                    duration: 1000
                }
                PropertyAnimation {
                    target: exitItem
                    property: "x"
                    from: target.width
                    to: 0
                }
            }
        }
    }

    Component {
        id: teal
        Rectangle {
            color: 'teal'
            anchors.fill: parent
            implicitWidth: 200
            implicitHeight: 200
        }
    }

    LeftScreenViewController {}
}
