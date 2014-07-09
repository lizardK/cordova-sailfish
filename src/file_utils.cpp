#include "file_utils.h"
#include <QFile>
#include <QTextStream>
#include <QImage>
#include <QBuffer>

FileUtils::FileUtils(QObject *parent) :
  QObject(parent)
{
}

QString FileUtils::read(const QString &file)
{
  QString fContent;
  QFile f(file);
  if(f.open(QIODevice::ReadOnly))
    {
      QTextStream in(&f);
      fContent = in.readAll();
      f.close();
    }

  return fContent;
}

bool FileUtils::write(const QString &str, const QString &file)
{
  QFile f(file);
  if(!f.open(QIODevice::WriteOnly))
    return false;

  QTextStream out (&f);
  out << str;
  f.close();
  return true;
}
