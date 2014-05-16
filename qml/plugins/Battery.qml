import QtQuick 2.0
import QtSystemInfo 5.0

Item {
    id: batteryPlugin

    BatteryInfo {
        id: battery
    }

    function start(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = {
            level: (battery.remainingCapacity(0) / battery.maximumCapacity(0) * 100).toFixed(0),
            isPlugged: battery.chargingState(0) === BatteryInfo.Charging
        }
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }
}
