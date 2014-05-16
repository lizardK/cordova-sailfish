import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0

Item {
    id: inAppBrowserPlugin

    Dialog {
        id: dialogInAppWebView
        property string url
        property string text
        property string btnText

        Column {
            spacing: 10
            anchors.fill: parent
            /*DialogHeader {
                title: "dialogAlert.title"
                acceptText: "dialogAlert.btnText"
            }*/
            SilicaWebView {
                id: inAppWebView
                width: parent.width
                height: parent.height
                url: dialogInAppWebView.url
            }
        }
    }

    function open(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var url = options.params.shift()

        //var title = options.params.shift()
        //var btn = options.params.shift()
        dialogInAppWebView.url = url
        dialogInAppWebView.open()

        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(true));
    }
}
