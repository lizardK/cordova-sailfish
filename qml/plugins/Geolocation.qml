import QtQuick 2.0
import QtPositioning 5.2
//import QtLocation 5.0

Item{
    id: geolocationPlugin
    function getLocation(args){
        positionSource.start()
        return {
            coords: {
                latitude: positionSource.position.coordinate.latitude,
                longitude: positionSource.position.coordinate.longitude,
                altitude: positionSource.position.coordinate.altitude,
                accuracy: positionSource.position.horizontalAccuracy,
                altitudeAccuracy: positionSource.position.verticalAccuracy,
                speed: positionSource.position.speed,
                heading: -1,
                timestamp: new Date()
            }
        }
    }

    PositionSource {
        id: positionSource
        /*updateInterval: 1000
        active: true
        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
        }*/
    }
}
