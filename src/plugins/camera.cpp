/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/

#include "cameraresolution.h"
#include "camera.h"
#include <QDebug>

// This is returned as the path to the captured image on platforms other than Symbian
#define DUMMY_IMAGE "dummy.jpg"

// These define the (only) supported resolution on platforms other than Symbian
#define DUMMY_WIDTH 1024
#define DUMMY_HEIGHT 768

Camera *Camera::m_camera = new Camera;

Camera::Camera() : CPlugin()
{
  PluginRegistry::getRegistry()->registerPlugin( "com.cordova.Camera", this );
}

Camera::~Camera()
{
  qDeleteAll(m_supportedResolutionObjects);
}

void Camera::init()
{
  getSupportedResolutions();
}

void Camera::getPicture( int scId, int ecId, QVariantMap p_options)
{
  Q_UNUSED(p_options);
  Q_UNUSED(ecId);
  QString callbackArguments = newImageFile(m_supportedResolutions.at(0).width(),m_supportedResolutions.at(0).height());
  this->callback( scId, callbackArguments );
}

QString Camera::newImageFile(int width, int height)
{
  Q_UNUSED(width);
  Q_UNUSED(height);

  return DUMMY_IMAGE;
}

QUrl Camera::newImageUrl(int width, int height)
{
  QString filename = newImageFile(width, height);
  if (filename.isEmpty())
    return QUrl();
  else
    return QUrl::fromLocalFile(filename);
}

QList<QSize> Camera::supportedResolutions()
{
  if (m_supportedResolutions.isEmpty())
    getSupportedResolutions();
  return m_supportedResolutions;
}

void Camera::getSupportedResolutions()
{
  m_supportedResolutions.append(QSize(DUMMY_WIDTH, DUMMY_HEIGHT));
  m_supportedResolutionObjects.append(new CameraResolution(DUMMY_WIDTH, DUMMY_HEIGHT));

}

QList<QObject*> Camera::supportedResolutionObjects()
{
  if (m_supportedResolutionObjects.isEmpty())
    getSupportedResolutions();
  return m_supportedResolutionObjects;
}
