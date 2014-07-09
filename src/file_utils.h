#ifndef FILE_UTILS_H
#define FILE_UTILS_H

#include <QObject>
#include <QByteArray>

class FileUtils : public QObject
{
  Q_OBJECT
public:
  explicit FileUtils(QObject *parent = 0);

  Q_INVOKABLE QString read(const QString & file);
  Q_INVOKABLE bool write(const QString & str, const QString & file);

};

#endif // FILE_UTILS_H
