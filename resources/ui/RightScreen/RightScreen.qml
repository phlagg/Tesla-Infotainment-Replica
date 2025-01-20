import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Controls 2.0 as C2

import "../LeftScreen/"

Rectangle{
    id: rightScreen
    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
        left: leftScreen.right
    }



/***************************************** BEGIN MAP ************************************************/
    property string geoapifyHostingKey : "410c0770635d490b9a0133ad5f3a7356"
    property string mapUrl3D: "https://maps.geoapify.com/v1/styles/osm-liberty/style.json?apiKey="
    property string mapUrlDarkGrey: "https://maps.geoapify.com/v1/styles/dark-matter-dark-grey/style.json?apiKey="
    property string mapUrlDarkBrown: "https://maps.geoapify.com/v1/styles/dark-matter-brown/style.json?apiKey="
    property string mapUrlDarkPurple: "https://maps.geoapify.com/v1/styles/dark-matter-dark-purple/style.json?apiKey="
    property string mapUrlDark: "https://maps.geoapify.com/v1/styles/dark-matter/style.json?apiKey="
    property string mapUrlBright: "https://maps.geoapify.com/v1/styles/dark-matter/style.json?apiKey="

    Plugin {
        id: mapPlugin
        name: "mapboxgl"//"osm" "maplibregl", "esri", ...
//        PluginParameter {
//            name: "mapboxgl.mapping.additional_style_urls"
//            value: "https://maps.geoapify.com/v1/styles/osm-bright/style.json?apiKey=" + GeoapifyHostingKey
//        }
     }


    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(49.2827, -123.12) // Oslo
        zoomLevel: 10
        // property geoCoordinate startCentroid
//        activeMapType: supportedMapTypes[supportedMapTypes.length - 1] /* Used to set custom Map */
//        DynamicParameter {
//            id: parameterD1
//            type: "layer"
//            property string name: "3d-buildings"
//            property string source: "composite"
//            property string sourceLayer: "building"
//            property string layerType: "fill-extrusion"
//            property real minzoom: 0.0
//        }

//        DynamicParameter {
//            id: parameterD2
//            type: "filter"

//            property string layer: "3d-buildings"
//            property var filter: [ "==", "extrude", "true" ]
//        }

//        DynamicParameter {
//            id: parameterD3
//            type: "paint"

//            property string layer: "3d-buildings"
//            property string fillExtrusionColor: "#c0c0c0"
//            property real fillExtrusionOpacity: .6
//            property var fillExtrusionHeight: { return { type: "identity", property: "height" } }
//            property var fillExtrusionBase: { return { type: "identity", property: "min_height" } }
//        }
    }

/***************************************** END MAP ************************************************/
property string fontColor: "#4b4b4b"

    Image {
        id: lockIcon
        anchors {
            left: parent.left
            top: parent.top
            margins: 20
        }
        width: parent.width/40
        fillMode: Image.PreserveAspectFit
        source: (systemHandler.carLocked ? "qrc:/ui/assets/lock.png" : "qrc:/ui/assets/unlock.png")
        MouseArea {
            anchors.fill: parent
            onClicked: systemHandler.setCarLocked(!systemHandler.carLocked )
        }
    }

    Text {
        id: dateTimeDisplay
        anchors {
            left: lockIcon.right
            leftMargin: 40
            bottom: lockIcon.bottom

        }
        font.pixelSize: 16
        font.bold: true
        color: fontColor
        text: systemHandler.currentTime
    }

    Text {
        id: outdoorTemperatureDisplay
        anchors {
            left: dateTimeDisplay.right
            leftMargin: 40
            bottom: lockIcon.bottom

        }
        font.pixelSize: 16
        font.bold: true
        color: fontColor
        text: systemHandler.outdoorTemp + "°C"
    }

    Text {
        id: usernameDisplay
        anchors {
            left: outdoorTemperatureDisplay.right
            leftMargin: 40
            bottom: lockIcon.bottom

        }
        font.pixelSize: 16
        font.bold: true
        color: fontColor
        text: systemHandler.userName
    }

    NavigationSearchBox {
        id: navSearchBox
        width: parent.width / 3
        height: parent.height /12

        anchors {
            left: lockIcon.left
            top: lockIcon.bottom
            topMargin: 20
        }
    }

    Image {
        id: compassIcon
        anchors {
            top: navSearchBox.top
            topMargin: 0
            right: parent.right
            rightMargin: 50

        }
        rotation: -1*map.bearing
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/compass.png"
        width: parent.width /16
        MouseArea {
            anchors.fill: parent
            onClicked: map.bearing = 0
         }
    }

    Image {
        id: isometricViewIcon
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/3D.png"
        width: parent.width /12
        anchors{
            horizontalCenter: compassIcon.horizontalCenter
            top: compassIcon.bottom
            topMargin: 50

        }

        MouseArea {
            property int previousX: -1
            property int previousY: -1
            property bool rotating: false
            anchors.fill: parent
            onClicked: (map.tilt != 0 ? map.tilt =0 : map.tilt = 50)
            pressAndHoldInterval: 400
            onPressAndHold: {
                previousX = mouseX;
                previousY = mouseY;
                rotating = true
                console.log("Long");
            }
            onPositionChanged: {
                if(rotating){
                    let direction = Qt.vector2d(mouseX - previousX, mouseY - previousY).normalized();
                    let normal = Qt.vector2d(direction.y, direction.x).normalized();
                    console.log("direction : " + direction);
                    console.log("normal : " + normal);
                    map.tilt += normal.x *1.5 ;
                    map.bearing += normal.y *1.5;
                    // map.tilt += (mouse.x- previousX);
                    // map.bearing += (mouse.x- previousX)*8;
                    previousX = mouseX;
                    previousY = mouseY
                }
            }

            onReleased: {
                previousX = -1;
                previousY = -1;
                rotating = false;
                console.log("Long End");
            }
        }
    }


    C2.Button {
        width: 60
        height: LeftScreen.leftScreen.height * 0.125
        text: "title"
        onClicked: {
           LeftScreen.leftScreenStack.push(LeftScreen.carInfo)
           LeftScreen.leftScreenStack.currentItem.forceActiveFocus()
        }
    }



//    C2.Slider {
//        id: tiltSlider
//        height: parent.height/3
//        orientation : Qt.Vertical
//        anchors {
//            bottom: parent.bottom
//            bottomMargin: 30
//            right: parent.right
//            rightMargin: 20
//        }
//        from: map.minimumTilt;
//        to: map.maximumTilt
//        value: map.tilt
//        onValueChanged: {
//            map.tilt = value;
//        }
//    }

//        C2.Slider {
//        id: bearingSlider
//        height: parent.height/3
//        orientation : Qt.Horizontal
//        anchors {
//            bottom: parent.bottom
//            bottomMargin: 30
//            right: parent.right
//            rightMargin: 100
//        }

//        from: 0
//        to: 360
//        value: map.bearing
//        onValueChanged: {
//            map.bearing = value;
//        }
//    }




}
