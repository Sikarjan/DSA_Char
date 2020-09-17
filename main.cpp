#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QFontDatabase>
#include <QDebug>

#include "documenthandler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setOrganizationName("Innobiz");
    app.setOrganizationDomain("innobiz.de");
    app.setApplicationName("DSA_Character_Sheet");

    QString locale = QLocale::system().name();

    QTranslator* translator = new QTranslator(0);
    if(translator->load("DSA_Char_"+locale,":/lang/language/")){
        app.installTranslator(translator);
    }

    QFontDatabase fontDatabase;
    if (fontDatabase.addApplicationFont(":/fonts/fonts/fontello.ttf") == -1)
        qWarning() << "Failed to load fontello.ttf";

    qmlRegisterType<DocumentHandler>("io.qt.examples.texteditor", 1, 0, "DocumentHandler");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
