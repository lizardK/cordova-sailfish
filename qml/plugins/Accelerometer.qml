import QtQuick 2.0
import QtSensors 5.0

Item{
    id: accelerometerPlugin
    property double acc_x: 0.0
    property double acc_y: 0.0
    property double acc_z: 0.0

    Accelerometer {
        id:accelerometer
        active: true
        onReadingChanged: {
            accelerometerPlugin.acc_x = reading.x
            accelerometerPlugin.acc_y = reading.y
            accelerometerPlugin.acc_z = reading.z
        }
    }

    function start(options) {
        if(!accelerometer.active)
            accelerometer.start()
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = {
            x: accelerometerPlugin.acc_x,
            y: accelerometerPlugin.acc_y,
            z: accelerometerPlugin.acc_z
        }
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }

    function stop(options) {
        if(accelerometer.active)
            accelerometer.stop()
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = {}
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }
}
