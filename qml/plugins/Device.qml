import QtQuick 2.0
import QtSystemInfo 5.0

Item {
    id: devicePlugin

    property string platform: "SailfishOS"
    property string cordova: "3.5.0-dev"

    DeviceInfo {
        id: device
    }

    function getDeviceInfo(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = {
            "model": device.model(),
            "platform": devicePlugin.platform,
            "version": device.version(0),
            "cordova": devicePlugin.cordova,
            "uuid": device.uniqueDeviceID()
        }
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }
}
