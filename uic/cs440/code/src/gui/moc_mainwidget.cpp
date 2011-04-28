/****************************************************************************
** Meta object code from reading C++ file 'mainwidget.h'
**
** Created: Thu Dec 7 21:52:34 2006
**      by: The Qt Meta Object Compiler version 59 (Qt 4.1.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "mainwidget.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 59
#error "This file was generated using the moc from 4.1.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

static const uint qt_meta_data_MainWidget[] = {

 // content:
       1,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   10, // methods
       0,    0, // properties
       0,    0, // enums/sets

 // slots: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x08,
      28,   11,   11,   11, 0x08,
      48,   11,   11,   11, 0x08,
      67,   11,   11,   11, 0x08,
      90,   11,   11,   11, 0x08,
     108,   11,   11,   11, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainWidget[] = {
    "MainWidget\0\0IImageClicked()\0on_OImage_clicked()\0on_bExit_clicked()\0"
    "on_OpenEmbed_clicked()\0on_bRun_clicked()\0on_EData_clicked()\0"
};

const QMetaObject MainWidget::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWidget,
      qt_meta_data_MainWidget, 0 }
};

const QMetaObject *MainWidget::metaObject() const
{
    return &staticMetaObject;
}

void *MainWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainWidget))
	return static_cast<void*>(const_cast<MainWidget*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: IImageClicked(); break;
        case 1: on_OImage_clicked(); break;
        case 2: on_bExit_clicked(); break;
        case 3: on_OpenEmbed_clicked(); break;
        case 4: on_bRun_clicked(); break;
        case 5: on_EData_clicked(); break;
        }
        _id -= 6;
    }
    return _id;
}
