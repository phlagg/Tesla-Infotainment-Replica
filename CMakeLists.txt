cmake_minimum_required(VERSION 3.16)
project(TeslaInfotainment VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Location Positioning Quick Controls2)
find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS Concurrent OpenGL Sql)

qt_standard_project_setup()

qt_add_executable(TeslaInfotainment WIN32 MACOSX_BUNDLE
    src/controllers/audiocontroller.cpp src/controllers/audiocontroller.h
    src/controllers/hvachandler.cpp src/controllers/hvachandler.h
    src/controllers/system.cpp src/controllers/system.h
    src/main.cpp
)
target_link_libraries(TeslaInfotainment PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Location
    Qt::Positioning
    Qt::Quick
    Qt::Controls2
)


# Resources:
set(qml_resource_files
    "resources/main.qml"
    "resources/ui/BottomBar/BottomBar.qml"
    "resources/ui/BottomBar/HVACComponent.qml"
    "resources/ui/BottomBar/VolumeControlComponent.qml"
    "resources/ui/LeftScreen/LeftScreen.qml"
    "resources/ui/RightScreen/NavigationSearchBox.qml"
    "resources/ui/RightScreen/RightScreen.qml"
    "resources/ui/assets/3D.png"
    "resources/ui/assets/carIcon.png"
    "resources/ui/assets/carIcon.svg"
    "resources/ui/assets/carRender.jpg"
    "resources/ui/assets/compass.png"
    "resources/ui/assets/lock.png"
    "resources/ui/assets/search.png"
    "resources/ui/assets/unlock.png"
    "resources/ui/assets/vol0.png"
    "resources/ui/assets/vol1.png"
    "resources/ui/assets/vol2.png"
    "resources/ui/assets/vol3.png"
    "resources/ui/assets/volmute.png"
)

qt_add_resources(TeslaInfotainment "resources/qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

if(QT_FEATURE_geoservices_mapboxgl)
    target_link_libraries(TeslaInfotainment PRIVATE
        Qt::OpenGL
        Qt::Sql
    )
endif()

if(QT_FEATURE_geoservices_osm)
    target_link_libraries(TeslaInfotainment PRIVATE
        Qt::Concurrent
    )
endif()

install(TARGETS TeslaInfotainment
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_app_script(
    TARGET TeslaInfotainment
    FILENAME_VARIABLE deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})
