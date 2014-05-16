import QtQuick 2.0
import QtSensors 5.0

Item {
    id: compassPlugin
    property double azimuth: 0
    property double angle: 0

    Compass {
        id: compass
        dataRate: 1
        active: true
        onReadingChanged: {
            compassPlugin.azimuth = reading.azimuth
            compassPlugin.angle  = (compassPlugin.azimuth /(2*Math.PI))
        }
    }

    function getHeading(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = {
            magneticHeading: compassPlugin.azimuth,
            trueHeading: true,
            headingAccuracy: 100,
            timestamp: new Date()
        }
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }
}
