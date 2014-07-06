import QtQuick 2.0
import QtPositioning 5.2
import QtLocation 5.0

Item{
    id: geolocationPlugin
    property var coords

    PositionSource {
        id: positionSource
        updateInterval: 1000
        active: true

        onPositionChanged: {
            var coord = positionSource.position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
            coords = {
                latitude: coord.latitude,
                longitude: coord.longitude,
                altitude: coord.altitude,
                accuracy: coord.horizontalAccuracy,
                altitudeAccuracy: coord.verticalAccuracy,
                speed: coord.speed,
                heading: -1,
                timestamp: new Date()
            }
        }
    }

    function getLocation(options) {
        if(!positionSource.active)
            positionSource.start()
        var webView = options.webview
        var callbackID = options.params.shift()
        var errCallbackID = options.params.shift()
        var result = {
            coords: geolocationPlugin.coords
        }
        console.log(JSON.stringify(result))
        webView.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(callbackID).arg(JSON.stringify(result)));
    }
}
