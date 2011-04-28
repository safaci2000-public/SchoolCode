#ifndef UI_FORM_H
#define UI_FORM_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QGridLayout>
#include <QtGui/QLabel>
#include <QtGui/QMainWindow>
#include <QtGui/QMenu>
#include <QtGui/QMenuBar>
#include <QtGui/QPushButton>
#include <QtGui/QStatusBar>
#include <QtGui/QTabWidget>
#include <QtGui/QWidget>

class Ui_mainWindow
{
public:
    QAction *actionExit;
    QAction *actionAbout;
    QAction *actionExit_2;
    QWidget *centralwidget;
    QTabWidget *tabWidget;
    QWidget *tab;
    QGridLayout *gridLayout;
    QLabel *label_4;
    QLabel *label_3;
    QLabel *label_2;
    QPushButton *EData;
    QPushButton *OImage;
    QPushButton *IImage;
    QWidget *tab_2;
    QLabel *label;
    QPushButton *OpenEmbed;
    QLabel *label_5;
    QLabel *label1;
    QLabel *label3;
    QPushButton *bExit;
    QPushButton *bRun;
    QLabel *label2;
    QStatusBar *statusbar;
    QMenuBar *menuBar;
    QMenu *menu_File;

    void setupUi(QMainWindow *mainWindow)
    {
    mainWindow->setObjectName(QString::fromUtf8("mainWindow"));
    mainWindow->resize(QSize(648, 502).expandedTo(mainWindow->minimumSizeHint()));
    actionExit = new QAction(mainWindow);
    actionExit->setObjectName(QString::fromUtf8("actionExit"));
    actionAbout = new QAction(mainWindow);
    actionAbout->setObjectName(QString::fromUtf8("actionAbout"));
    actionExit_2 = new QAction(mainWindow);
    actionExit_2->setObjectName(QString::fromUtf8("actionExit_2"));
    centralwidget = new QWidget(mainWindow);
    centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
    tabWidget = new QTabWidget(centralwidget);
    tabWidget->setObjectName(QString::fromUtf8("tabWidget"));
    tabWidget->setGeometry(QRect(30, 20, 541, 261));
    tab = new QWidget();
    tab->setObjectName(QString::fromUtf8("tab"));
    gridLayout = new QGridLayout(tab);
    gridLayout->setSpacing(6);
    gridLayout->setMargin(9);
    gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
    label_4 = new QLabel(tab);
    label_4->setObjectName(QString::fromUtf8("label_4"));

    gridLayout->addWidget(label_4, 2, 1, 1, 1);

    label_3 = new QLabel(tab);
    label_3->setObjectName(QString::fromUtf8("label_3"));

    gridLayout->addWidget(label_3, 1, 1, 1, 1);

    label_2 = new QLabel(tab);
    label_2->setObjectName(QString::fromUtf8("label_2"));

    gridLayout->addWidget(label_2, 0, 1, 1, 1);

    EData = new QPushButton(tab);
    EData->setObjectName(QString::fromUtf8("EData"));
    EData->setEnabled(false);

    gridLayout->addWidget(EData, 2, 0, 1, 1);

    OImage = new QPushButton(tab);
    OImage->setObjectName(QString::fromUtf8("OImage"));
    OImage->setEnabled(false);

    gridLayout->addWidget(OImage, 1, 0, 1, 1);

    IImage = new QPushButton(tab);
    IImage->setObjectName(QString::fromUtf8("IImage"));

    gridLayout->addWidget(IImage, 0, 0, 1, 1);

    tabWidget->addTab(tab, QApplication::translate("mainWindow", "Embed Data", 0, QApplication::UnicodeUTF8));
    tab_2 = new QWidget();
    tab_2->setObjectName(QString::fromUtf8("tab_2"));
    label = new QLabel(tab_2);
    label->setObjectName(QString::fromUtf8("label"));
    label->setGeometry(QRect(30, 20, 321, 19));
    OpenEmbed = new QPushButton(tab_2);
    OpenEmbed->setObjectName(QString::fromUtf8("OpenEmbed"));
    OpenEmbed->setGeometry(QRect(30, 60, 131, 31));
    tabWidget->addTab(tab_2, QApplication::translate("mainWindow", "Extract Data", 0, QApplication::UnicodeUTF8));
    label_5 = new QLabel(centralwidget);
    label_5->setObjectName(QString::fromUtf8("label_5"));
    label_5->setGeometry(QRect(30, 330, 91, 51));
    label1 = new QLabel(centralwidget);
    label1->setObjectName(QString::fromUtf8("label1"));
    label1->setGeometry(QRect(160, 340, 411, 19));
    label3 = new QLabel(centralwidget);
    label3->setObjectName(QString::fromUtf8("label3"));
    label3->setGeometry(QRect(160, 420, 421, 19));
    bExit = new QPushButton(centralwidget);
    bExit->setObjectName(QString::fromUtf8("bExit"));
    bExit->setGeometry(QRect(260, 290, 104, 31));
    bRun = new QPushButton(centralwidget);
    bRun->setObjectName(QString::fromUtf8("bRun"));
    bRun->setEnabled(false);
    bRun->setGeometry(QRect(130, 290, 104, 31));
    label2 = new QLabel(centralwidget);
    label2->setObjectName(QString::fromUtf8("label2"));
    label2->setGeometry(QRect(160, 380, 411, 19));
    mainWindow->setCentralWidget(centralwidget);
    statusbar = new QStatusBar(mainWindow);
    statusbar->setObjectName(QString::fromUtf8("statusbar"));
    mainWindow->setStatusBar(statusbar);
    menuBar = new QMenuBar(mainWindow);
    menuBar->setObjectName(QString::fromUtf8("menuBar"));
    menuBar->setGeometry(QRect(0, 0, 648, 31));
    menu_File = new QMenu(menuBar);
    menu_File->setObjectName(QString::fromUtf8("menu_File"));
    mainWindow->setMenuBar(menuBar);
    QWidget::setTabOrder(IImage, OImage);
    QWidget::setTabOrder(OImage, EData);

    menuBar->addAction(menu_File->menuAction());
    menu_File->addAction(actionExit_2);
    retranslateUi(mainWindow);

    tabWidget->setCurrentIndex(0);


    QMetaObject::connectSlotsByName(mainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *mainWindow)
    {
    mainWindow->setWindowTitle(QApplication::translate("mainWindow", "Stego ver. 1.0", 0, QApplication::UnicodeUTF8));
    actionExit->setText(QApplication::translate("mainWindow", "&Exit", 0, QApplication::UnicodeUTF8));
    actionExit->setStatusTip(QApplication::translate("mainWindow", "", "Exit", QApplication::UnicodeUTF8));
    actionExit->setShortcut(QApplication::translate("mainWindow", "Alt+F4", 0, QApplication::UnicodeUTF8));
    actionAbout->setText(QApplication::translate("mainWindow", "&About", 0, QApplication::UnicodeUTF8));
    actionAbout->setStatusTip(QApplication::translate("mainWindow", "", "About", QApplication::UnicodeUTF8));
    actionAbout->setShortcut(QApplication::translate("mainWindow", "F1", 0, QApplication::UnicodeUTF8));
    actionExit_2->setText(QApplication::translate("mainWindow", "Exit", 0, QApplication::UnicodeUTF8));
    actionExit_2->setShortcut(QApplication::translate("mainWindow", "Ctrl+W", 0, QApplication::UnicodeUTF8));
    tabWidget->setToolTip(QApplication::translate("mainWindow", "Choose the appropriate tab for the action you wish to perform", 0, QApplication::UnicodeUTF8));
    label_4->setText(QApplication::translate("mainWindow", "Choose a text or binary file to embed", 0, QApplication::UnicodeUTF8));
    label_3->setText(QApplication::translate("mainWindow", "Choose an Image file of the same type", 0, QApplication::UnicodeUTF8));
    label_2->setText(QApplication::translate("mainWindow", "Choose an Image File", 0, QApplication::UnicodeUTF8));
    EData->setToolTip(QApplication::translate("mainWindow", "Choose Data to Embed", 0, QApplication::UnicodeUTF8));
    EData->setText(QApplication::translate("mainWindow", "Choose &Data to Embed", 0, QApplication::UnicodeUTF8));
    OImage->setToolTip(QApplication::translate("mainWindow", "Choose An Output Image", 0, QApplication::UnicodeUTF8));
    OImage->setText(QApplication::translate("mainWindow", "Choose An O&utput Image", 0, QApplication::UnicodeUTF8));
    IImage->setToolTip(QApplication::translate("mainWindow", "Load Input Image", 0, QApplication::UnicodeUTF8));
    IImage->setText(QApplication::translate("mainWindow", "Load &Input Image", 0, QApplication::UnicodeUTF8));
    tabWidget->setTabText(tabWidget->indexOf(tab), QApplication::translate("mainWindow", "Embed Data", 0, QApplication::UnicodeUTF8));
    label->setText(QApplication::translate("mainWindow", "Choose a file that contains embedded data.", 0, QApplication::UnicodeUTF8));
    OpenEmbed->setToolTip(QApplication::translate("mainWindow", "Open File ", 0, QApplication::UnicodeUTF8));
    OpenEmbed->setText(QApplication::translate("mainWindow", "&Open File", 0, QApplication::UnicodeUTF8));
    tabWidget->setTabText(tabWidget->indexOf(tab_2), QApplication::translate("mainWindow", "Extract Data", 0, QApplication::UnicodeUTF8));
    label_5->setText(QApplication::translate("mainWindow", "Command to\n"
"Execute", 0, QApplication::UnicodeUTF8));
    label1->setText(QApplication::translate("mainWindow", "./stego", 0, QApplication::UnicodeUTF8));
    label3->setText(QApplication::translate("mainWindow", "", 0, QApplication::UnicodeUTF8));
    bExit->setToolTip(QApplication::translate("mainWindow", "Exit", 0, QApplication::UnicodeUTF8));
    bExit->setText(QApplication::translate("mainWindow", "E&xit", 0, QApplication::UnicodeUTF8));
    bRun->setToolTip(QApplication::translate("mainWindow", "Execute or Run", 0, QApplication::UnicodeUTF8));
    bRun->setText(QApplication::translate("mainWindow", "&Execute", 0, QApplication::UnicodeUTF8));
    label2->setText(QApplication::translate("mainWindow", "", 0, QApplication::UnicodeUTF8));
    menu_File->setTitle(QApplication::translate("mainWindow", "&File", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class mainWindow: public Ui_mainWindow {};
} // namespace Ui

#endif // UI_FORM_H
