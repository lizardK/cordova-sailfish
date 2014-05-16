import QtQuick 2.0
import QtFeedback 5.0

Item{
    id: vibrationPlugin

    HapticsEffect {
        id: vibration
        attackIntensity: 0.0
        attackTime: 250
        intensity: 1.0
        duration: 500
        fadeTime: 250
        fadeIntensity: 0.0
    }

    function vibrate(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        vibration.duration = options.params.shift()
        vibration.start()
        var result = true
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }
}
