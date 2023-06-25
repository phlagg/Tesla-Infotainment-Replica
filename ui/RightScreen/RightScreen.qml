import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15

Rectangle{
    id: rightScreen
    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }

    width: parent.width *2/3

/***************************************** BEGIN MAP ************************************************/

    Plugin {
        id: mapPlugin
        name: "mapboxgl"//"osm" "maplibregl", "esri", ...
        PluginParameter {
            name: "osm.mapping.custom.host"
            value: "https://maps.geoapify.com/v1/tile/osm-carto/"
        }
        // PluginParameter {
        //     name: "here.apiKey";
        //     value: "{YOUR_API_KEY}"
        // }
     }


    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(49.2827, -123.12) // Oslo
        zoomLevel: 10
        // property geoCoordinate startCentroid
//        activeMapType: supportedMapTypes[supportedMapTypes.length - 1] /* Used to set custom Map */
/*
        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                map.bearing -= delta
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }*/
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


}
