# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = untitled2

CONFIG += sailfishapp

SOURCES += src/untitled2.cpp

DISTFILES += qml/untitled2.qml \
    qml/cover/CoverPage.qml \
    rpm/untitled2.changes.in \
    rpm/untitled2.changes.run.in \
    rpm/untitled2.spec \
    qml/pages/MoviePage.qml \
    rpm/untitled2.yaml \
    translations/*.ts \
    untitled2.desktop \
    qml/pages/BookPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/GoodsPage.qml \
    qml/pages/ShowGoods.qml \
    qml/DB.js

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/untitled2-de.ts
