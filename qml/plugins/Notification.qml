import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0

Item {
    id: notificationPlugin

    Dialog {
        id: dialogAlert
        property string title
        property string text
        property string btnText

        Column {
            spacing: 10
            anchors.fill: parent
            DialogHeader {
                title: dialogAlert.title
                acceptText: dialogAlert.btnText
            }
            Label {
                id: labelAlert
                width: parent.width
                text: dialogAlert.text
            }
        }
    }

    Dialog {
        id: dialogConfirm
        canAccept: true
        property string title
        property string text
        property string btnTextAccept
        property string btnTextCancel

        Column {
            spacing: 10
            anchors.fill: parent
            DialogHeader {
                title: dialogConfirm.title
                acceptText: dialogConfirm.btnTextAccept
                cancelText: dialogConfirm.btnTextCancel
            }
            Label {
                id: labelConfirm
                width: parent.width
                text: dialogConfirm.text
            }
        }
    }

    Dialog {
        id: dialogPrompt
        canAccept: true
        property string title
        property string text
        property string defaultText
        property string btnTextAccept
        property string btnTextCancel

        Column {
            spacing: 10
            anchors.fill: parent
            DialogHeader {
                title: dialogPrompt.title
                acceptText: dialogPrompt.btnTextAccept
                cancelText: dialogConfirm.btnTextCancel
            }
            Label {
                id: labelPrompt
                width: parent.width
                text: dialogPrompt.text
            }
            TextField {
                id: txtfieldPrompt
                width: parent.width
                placeholderText: dialogPrompt.defaultText
            }
        }
    }

    function alert(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var text = options.params.shift()
        var title = options.params.shift()
        var btn = options.params.shift()
        dialogAlert.title = title
        dialogAlert.text = text
        dialogAlert.btnText = btn
        dialogAlert.open()

        //webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }

    function confirm(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var text = options.params.shift()
        var title = options.params.shift()
        var btns = options.params.shift()
        if(!Array.isArray(btns))
            btns = btns.split(",")
        dialogConfirm.title = title
        dialogConfirm.text = text
        dialogConfirm.btnTextAccept = btns[0].trim()
        dialogConfirm.btnTextCancel = btns[1].trim()
        dialogConfirm.open()

        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg("accept"));
    }

    function prompt(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var text = options.params.shift()
        var title = options.params.shift()
        var btns = options.params.shift()
        if(!Array.isArray(btns))
            btns = btns.split(",")
        var defaultText = options.params.shift()
        dialogPrompt.title = title
        dialogPrompt.text = text
        dialogPrompt.defaultText = defaultText
        dialogPrompt.btnTextAccept = btns[0].trim()
        dialogPrompt.btnTextCancel = btns[1].trim()
        dialogPrompt.open()

        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(text));
    }

    function beep(options) {
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var count = options.params.shift()
        //TODO : generate beep
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(count));
    }
}
