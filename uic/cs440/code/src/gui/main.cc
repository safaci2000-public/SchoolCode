/*****************************************************************
 * Name:          Samir Faci
 * Class:         CS440
 * Assignment:    Project
 * Description:   Creates a QT frontend for stego 1.0.  Creates an 
 * 				  instance of QMainWindow and calls it.  Most code
 * 				  resides in mainwidget.cc and mainwidget.h
*******************************************************************/
#include "mainwidget.h"

int main( int argc, char *argv[] )
{   
    QApplication app( argc, argv, TRUE );
    QMainWindow *window = new MainWidget(0);
    window->show();
    
    return app.exec();
}
