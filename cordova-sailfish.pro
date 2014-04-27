# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = cordova-sailfish

CONFIG += sailfishapp

SOURCES += src/cordova-sailfish.cpp  \
    src/plugins/notification.cpp \
    src/plugins/geolocation.cpp \
    src/plugins/fileapi.cpp \
    #src/plugins/device.cpp \
    src/pluginregistry.cpp \
    src/plugins/console.cpp \
    #src/plugins/connection.cpp \
    src/plugins/compass.cpp \
    src/plugins/accelerometer.cpp \
    #src/plugins/events.cpp \
    src/cordova.cpp \
    src/cplugin.cpp \
    src/plugins/contacts.cpp \
    src/plugins/camera.cpp
#    src/plugins/media.cpp

HEADERS += \
    src/plugins/notification.h \
    src/plugins/geolocation.h \
    src/plugins/fileapi.h \
    #src/plugins/device.h \
    src/pluginregistry.h \
    src/plugins/console.h \
    #src/plugins/connection.h \
    src/plugins/compass.h \
    src/plugins/accelerometer.h \
    #src/plugins/events.h \
    src/cordova.h \
    src/cplugin.h \
    src/plugins/contacts.h \
    src/plugins/camera.h \
    src/plugins/cameraresolution.h
    #src/plugins/media.h

 QT += widgets
    QT += location
    QT += sensors
    QT += feedback
    #QT += systeminfo
    QT += contacts
    QT += multimedia
    QT += quick declarative

OTHER_FILES += qml/cordova-sailfish.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/cordova-sailfish.changes.in \
    rpm/cordova-sailfish.spec \
    rpm/cordova-sailfish.yaml \
    translations/*.ts \
    cordova-sailfish.desktop \
    qml/main_qt5.qml \
    qml/main_harmattan_qt5.qml \
    qml/cordova_wrapper.js \
    xml/plugins.xml \
    www/index.html


# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/cordova-sailfish-fr.ts

RESOURCES += \
    resources.qrc

