import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0

Item {
    id: cameraPlugin
    property variant webview
    property string  callbackID
    property string  errCallbackID
    property variant cameraOptions

    Dialog {
        id: dialogCamera
        canAccept: false

        Column {
            spacing: 10
            anchors.fill: parent

            DialogHeader {
                title: qsTr("Take picture")
            }

            Camera {
                id: camera

                exposure {
                    exposureCompensation: -1.0
                    exposureMode: Camera.ExposurePortrait
                }

                imageCapture {
                    onImageSaved: {
                        var uri = camera.imageCapture.capturedImagePath

                        //FIXME: I have to rotate image because photo is always taken in landscape
                        if(!ImageUtils.rotate(90,uri))
                            console.error("Unable to rotate photo")

                        if(cameraPlugin.cameraOptions.targetWidth !== -1 && cameraPlugin.cameraOptions.targetHeight !== -1)
                            if(!ImageUtils.resize(Qt.size(cameraPlugin.cameraOptions.targetWidth,cameraPlugin.cameraOptions.targetHeight),uri))
                                console.error('Unable to resize photo')

                        if(cameraPlugin.cameraOptions.encodingType !== 0)
                            uri = ImageUtils.encode("PNG",uri)

                        if(parseInt(cameraPlugin.cameraOptions.destinationType) === 0)
                            uri = Base64.encodeFile(uri)

                        cameraPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,'%2')".arg(cameraPlugin.callbackID).arg(uri));
                    }

                    onCaptureFailed: cameraPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,'%2')".arg(cameraPlugin.errCallbackID).arg(camera.imageCapture.errorString));
                }
            }

            VideoOutput {
                source: camera
                focus: visible
                width: parent.width
                height: parent.height

                MouseArea {
                    anchors.fill: parent;
                    onClicked: camera.imageCapture.capture()
                }
            }

            Component.onCompleted: camera.start()
        }
    }

    function takePicture(options) {
        cameraPlugin.webview = options.webview
        cameraPlugin.callbackID = options.params.shift()
        cameraPlugin.errCallbackID = options.params.shift()

        // Camera options
        //[quality, destinationType, sourceType, targetWidth, targetHeight, encodingType,
        //mediaType, allowEdit, correctOrientation, saveToPhotoAlbum, popoverOptions, cameraDirection];
        console.log(options.params)
        cameraPlugin.cameraOptions = {
            quality: options.params[0],
            destinationType: options.params[1],
            sourceType: options.params[2],
            targetWidth: options.params[3],
            targetHeight: options.params[4],
            encodingType: options.params[5],
            mediaType: options.params[6],
            allowEdit: options.params[7],
            correctOrientation: options.params[8],
            saveToPhotoAlbum: options.params[9],
            popoverOptions: options.params[10],
            cameraDirection: options.params[11]
        }

        dialogCamera.open()
    }
}
