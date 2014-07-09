#include "image_utils.h"
#include <QImage>
#include <QFileInfo>
#include <QDir>

ImageUtils::ImageUtils(QObject *parent) :
  QObject(parent)
{
}

bool ImageUtils::resize(const QSize &size, const QString &file)
{
  QFileInfo fi (file);
  if(!fi.exists())
    return false;

  QString ext = fi.completeSuffix();

  QImage img(file);
  img = img.scaled(size.width(),size.height(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation);
  return img.save(file,ext.toUpper().toStdString().c_str());
}

QString ImageUtils::encode(const QString &encodingType, const QString &file)
{
  QFileInfo fi (file);
  if(!fi.exists())
    return QString();

  QImage img(file);
  QString destination = fi.absoluteDir().absolutePath() + QDir::separator() + fi.baseName() + encodingType.toLower();
  if(!img.save(destination,encodingType.toUpper().toStdString().c_str()))
    return QString();

  if(!QFile(file).remove())
    return QString();

  return destination;
}

bool ImageUtils::rotate(qreal angle, const QString &file)
{
  QFileInfo fi (file);
  if(!fi.exists())
    return false;

  QString ext = fi.completeSuffix();

  QImage img(file);
  QMatrix matrix;
  matrix.rotate(angle);
  img = img.transformed(matrix,Qt::SmoothTransformation);
  return img.save(file,ext.toUpper().toStdString().c_str());
}
