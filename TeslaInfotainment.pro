QT += quick positioning location

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

LIBS+=

HEADERS += \
        Controllers/audiocontroller.h \
        Controllers/hvachandler.h \
        Controllers/system.h

SOURCES += \
        Controllers/audiocontroller.cpp \
        Controllers/hvachandler.cpp \
        Controllers/system.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=


# Workaround for QTBUG-38735
QT_FOR_CONFIG += location-private
qtConfig(geoservices_mapboxgl): QT += sql opengl
qtConfig(geoservices_osm): QT += concurrent


android: include(<path/to/android_openssl/openssl.pri)
android: include(/home/phlagg/Android/Sdk/android_openssl/openssl.pri)
