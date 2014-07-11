import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: notificationPlugin
    property variant webview
    property string alertCallbackID
    property string errAlertCallbackID
    property string confirmCallbackID
    property string errConfirmCallbackID
    property string promptCallbackID
    property string errPromptCallbackID

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
        onAccepted: notificationPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,'%2')".arg(notificationPlugin.alertCallbackID).arg(''));
        onRejected: notificationPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,'%2')".arg(notificationPlugin.alertCallbackID).arg(''));
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
        onAccepted:  notificationPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(notificationPlugin.confirmCallbackID).arg('0'));
        onRejected:  notificationPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(notificationPlugin.confirmCallbackID).arg('1'));
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

        onAccepted:  {
            var result = {
                input1: txtfieldPrompt.text,
                buttonIndex: 0
            }
            notificationPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(notificationPlugin.promptCallbackID).arg(JSON.stringify(result)));
        }

        onRejected:  {
            var result = {
                input1: txtfieldPrompt.text,
                buttonIndex: 1
            }
            notificationPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(notificationPlugin.promptCallbackID).arg(JSON.stringify(result)));
        }
    }

    function alert(options) {
        notificationPlugin.webview= options.webview
        notificationPlugin.alertCallbackID = options.params.shift()
        notificationPlugin.errAlertCallbackID = options.params.shift()
        var text = options.params.shift()
        var title = options.params.shift()
        var btn = options.params.shift()
        dialogAlert.title = title
        dialogAlert.text = text
        dialogAlert.btnText = btn
        dialogAlert.open()
    }

    function confirm(options) {
        notificationPlugin.webview= options.webview
        notificationPlugin.confirmCallbackID = options.params.shift()
        notificationPlugin.errConfirmCallbackID = options.params.shift()
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
    }

    function prompt(options) {
        notificationPlugin.webview= options.webview
        notificationPlugin.promptCallbackID = options.params.shift()
        notificationPlugin.errPromptCallbackID = options.params.shift()
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
