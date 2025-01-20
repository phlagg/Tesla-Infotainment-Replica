cmake_minimum_required(VERSION 3.16)
project(TeslaInfotainment VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Location Positioning Quick)
find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS Concurrent OpenGL Sql)

qt_standard_project_setup()

qt_add_executable(TeslaInfotainment WIN32 MACOSX_BUNDLE
    controllers/audiocontroller.cpp controllers/audiocontroller.h
    controllers/hvachandler.cpp controllers/hvachandler.h
    controllers/system.cpp controllers/system.h
    main.cpp
)
target_link_libraries(TeslaInfotainment PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Location
    Qt::Positioning
    Qt::Quick
)


# Resources:
set(qml_resource_files
    "main.qml"
    "ui/BottomBar/BottomBar.qml"
    "ui/BottomBar/HVACComponent.qml"
    "ui/BottomBar/VolumeControlComponent.qml"
    "ui/LeftScreen/LeftScreen.qml"
    "ui/RightScreen/NavigationSearchBox.qml"
    "ui/RightScreen/RightScreen.qml"
    "ui/assets/3D.png"
    "ui/assets/carIcon.png"
    "ui/assets/carIcon.svg"
    "ui/assets/carRender.jpg"
    "ui/assets/compass.png"
    "ui/assets/lock.png"
    "ui/assets/search.png"
    "ui/assets/unlock.png"
    "ui/assets/vol0.png"
    "ui/assets/vol1.png"
    "ui/assets/vol2.png"
    "ui/assets/vol3.png"
    "ui/assets/volmute.png"
)

qt_add_resources(TeslaInfotainment "qml"
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
