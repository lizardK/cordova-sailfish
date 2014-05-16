import QtQuick 2.0
import QtSystemInfo 5.0

Item {
    id: connectionPlugin

    NetworkInfo {
        id: network
    }

    function getConnectionInfo(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = network.currentNetworkMode
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(result));
    }
}
