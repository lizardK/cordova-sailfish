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
QT += multimedia

TARGET = cordova-sailfish

CONFIG += sailfishapp

SOURCES += src/cordova-sailfish.cpp \
    src/base64.cpp \
    src/file_utils.cpp \
    src/image_utils.cpp

OTHER_FILES += qml/cordova-sailfish.qml \
    qml/cover/CoverPage.qml \
    qml/plugins/device.qml \
    rpm/cordova-sailfish.changes.in \
    rpm/cordova-sailfish.spec \
    rpm/cordova-sailfish.yaml \
    translations/*.ts \
    cordova-sailfish.desktop \
    qml/pages/CordovaPage.qml \
    qml/plugins/Device.qml \
    qml/plugins/Accelerometer.qml \
    qml/plugins/Vibration.qml \
    qml/plugins_manager.js \
    www/index.html \
    qml/plugins/NetworkStatus.qml \
    qml/plugins/Compass.qml \
    qml/plugins/Battery.qml \
    qml/plugins/Notification.qml \
    qml/plugins/Contacts.qml \
    qml/plugins/InAppBrowser.qml \
    qml/plugins/Geolocation.qml \
    qml/plugins/Camera.qml \

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/cordova-sailfish-de.ts

RESOURCES += \
    resources.qrc

HEADERS += \
    src/base64.h \
    src/file_utils.h \
    src/image_utils.h

