#ifndef MAINVIEWCONTROLLER_H
#define MAINVIEWCONTROLLER_H

#include <QObject>

class MainViewController : public QObject
{
    Q_OBJECT
public:
    explicit MainViewController(QObject *parent = nullptr);

signals:
    void signalFunc(QString msg);

public slots:
    void testAlert(const QString& in);
};

#endif // MAINVIEWCONTROLLER_H
