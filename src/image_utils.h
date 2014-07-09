#ifndef IMAGE_UTILS_H
#define IMAGE_UTILS_H

#include <QObject>

class ImageUtils : public QObject
{
  Q_OBJECT
public:
  explicit ImageUtils(QObject *parent = 0);

  Q_INVOKABLE bool resize(const QSize & size, const QString & file);
  Q_INVOKABLE QString encode(const QString & encodingType, const QString & file);
  Q_INVOKABLE bool rotate(qreal angle, const QString & file);
};

#endif // IMAGE_UTILS_H
