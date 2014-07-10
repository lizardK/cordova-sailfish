/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import "../plugins"
import "../plugins_manager.js" as PluginsManager

Page {
    id: cordovaPage

    SilicaWebView {
        id: webView
        anchors.fill: parent

        // Set preferences
        experimental.preferences.developerExtrasEnabled: true
        experimental.preferences.navigatorQtObjectEnabled: true
        experimental.preferences.localStorageEnabled: true
        experimental.preferences.offlineWebApplicationCacheEnabled: true
        experimental.preferences.universalAccessFromFileURLsAllowed: true
        experimental.preferences.webGLEnabled: true
        //experimental.transparentBackground: true

        // Listen to messages from JS
        experimental.onMessageReceived: {
            var msg = JSON.parse(message.data)
            console.log("WebView received Message: " + JSON.stringify(msg))
            var p = PluginsManager.PluginsManager.plugin(msg.plugin)

            if(p[msg.func]){
                p[msg.func].call(this,{webview: webView, params: msg.params});
            } else {
                console.error("No such function ", msg.func, " in plugin ", msg.plugin)
            }
        }

        Component.onCompleted: {
            // Loading plugins
            // TODO: externalize to plugins.json
            PluginsManager.PluginsManager.addPlugin("Device");
            PluginsManager.PluginsManager.addPlugin("Vibration");
            PluginsManager.PluginsManager.addPlugin("NetworkStatus");
            PluginsManager.PluginsManager.addPlugin("Compass");
            PluginsManager.PluginsManager.addPlugin("Battery");
            PluginsManager.PluginsManager.addPlugin("Notification");
            PluginsManager.PluginsManager.addPlugin("Accelerometer");
            PluginsManager.PluginsManager.addPlugin("InAppBrowser");
            PluginsManager.PluginsManager.addPlugin("Geolocation");
            PluginsManager.PluginsManager.addPlugin("Camera");
            //PluginsManager.PluginsManager.addPlugin("Contacts");

            // Loading index.html
            webView.url = Qt.resolvedUrl("qrc:/www/index.html")
        }
    }
}


