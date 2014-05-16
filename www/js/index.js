/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicity call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

document.addEventListener('deviceready', deviceReadout, false);

function deviceReadout() {
  // Test Device plugin
  document.getElementById("device").innerHTML = 'Platform :' + device.platform;

  // Test Connection plugin
  document.getElementById("connection").innerHTML = 'Connection type : ' + navigator.connection.type;

  // Test Vibration plugin
  navigator.notification.vibrate(1000);

  // Test Compass plugin
  function onCompassSuccess(heading) {
    document.getElementById("compass").innerHTML = 'Compass Heading: ' + heading.magneticHeading;
  };

  function onCompassError(error) {
    document.getElementById("compass").innerHTML = 'CompassError: ' + error.code;
  };

  navigator.compass.getCurrentHeading(onCompassSuccess, onCompassError);

  // Test Battery plugin
  window.addEventListener("batterystatus", onBatteryStatus, false);

  function onBatteryStatus(info) {
    document.getElementById("battery").innerHTML = 'Battery :' + info.level + '%';
  }

  // Test notification
  function alertDismissed() {
    // do something
  }

  document.getElementById('btn-alert').addEventListener('click',function() {
    navigator.notification.alert(
      'You are the winner!',  // message
      alertDismissed,         // callback
      'Game Over',            // title
      'Done'                  // buttonName
    );
  },false);

  // process the confirmation dialog result
  function onConfirm(buttonIndex) {

  }

  // Show a custom confirmation dialog
  document.getElementById('btn-confirm').addEventListener('click',function() {
    navigator.notification.confirm(
      'You are the winner!', // message
      onConfirm,            // callback to invoke with index of button pressed
      'Game Over',           // title
      ['Restart','Exit']         // buttonLabels
    );
  },false);

  // process the promp dialog results
  function onPrompt(results) {
    alert("You selected button number " + results.buttonIndex + " and entered " + results.input1);
  }

  // Show a custom prompt dialog
  document.getElementById('btn-prompt').addEventListener('click',function() {
    navigator.notification.prompt(
      'Please enter your name',  // message
      onPrompt,                  // callback to invoke
      'Registration',            // title
      ['Ok','Exit'],             // buttonLabels
      'Jane Doe'                 // defaultText
    );
  },false);

  // Test plugin accelerometer
  function onAccelerometerSuccess(acceleration) {
    document.getElementById('accelerometer').innerHTML = [
      'Acceleration X: ', acceleration.x,'<br/>',
      'Acceleration Y: ', acceleration.y, '<br/>',
      'Acceleration Z: ', acceleration.z, '<br/>',
      'Timestamp: '     , acceleration.timestamp, '<br/>'].join('');
  };

  function onAccelerometerError() {
    document.getElementById('accelerometer').innerHTML = 'onError!';
  };

  navigator.accelerometer.getCurrentAcceleration(onAccelerometerSuccess,onAccelerometerError);
  //navigator.accelerometer.watchAcceleration(onAccelerometerSuccess, onAccelerometerError,{ frequency: 500 });

  // Test in-app browser
  document.getElementById('btn-inappbrowser').addEventListener('click',function(){
    var ref = window.open('http://apache.org', '_blank', 'location=yes');
  },false);


}