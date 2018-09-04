#include "mainviewcontroller.h"

MainViewController::MainViewController(QObject *parent) : QObject(parent)
{
}

void MainViewController::testAlert(const QString &in) {

emit signalFunc(in + "\nby Signal");
}
