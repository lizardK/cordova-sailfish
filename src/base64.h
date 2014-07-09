#ifndef BASE64_H
#define BASE64_H

#include <QObject>
#include <QByteArray>

class Base64 : public QObject
{
  Q_OBJECT
public:
  explicit Base64(QObject *parent = 0);

  Q_INVOKABLE QString encodeFile(const QString & filePath);
  Q_INVOKABLE QString decodeFile(const QString & filePath);

  Q_INVOKABLE QString encodeString(const QString & str);
  Q_INVOKABLE QString decodeString(const QString & str);
};

#endif // BASE64_H
