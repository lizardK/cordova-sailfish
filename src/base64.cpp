#include "base64.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

Base64::Base64(QObject *parent) :
  QObject(parent)
{
}

QString Base64::encodeFile(const QString &filePath)
{
  QString ba;
  QFile f(filePath);
  if(f.open(QIODevice::ReadOnly))
    {
      QByteArray fContent = f.readAll();
      ba = QString(fContent.toBase64());
      f.close();
    }
  return ba;
}

QString Base64::decodeFile(const QString &filePath)
{
  QString ba;
  QFile f(filePath);
  if(f.open(QIODevice::ReadOnly))
    {
      QByteArray fContent = f.readAll();
      ba = QString(QByteArray::fromBase64(fContent).data());
      f.close();
    }
  return ba;
}

QString Base64::encodeString(const QString &str)
{
  QByteArray ba;
  ba.append(str);
  return QString(ba.toBase64().data());
}

QString Base64::decodeString(const QString &str)
{
  QByteArray ba;
  ba.append(str);
  return QString(QByteArray::fromBase64(ba).data());
}
