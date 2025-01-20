import QtQuick 2.15
import QtQuick.Scene3D 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

Rectangle {
    id: carInfo
    color: "white"
    anchors.fill: parent
    Image {
        id: carRender
        anchors.centerIn: parent
        width: parent.width * 0.9
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/carRender.jpg"
    }



//    Scene3D {
//        anchors.fill: parent

//        CarRender {
//            id: carRenderModel

//        }
//    }
}
