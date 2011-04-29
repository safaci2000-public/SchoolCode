#include <cstdio>
#include <cstdlib>
#include <iostream>
/*****************************************************************
 * Name:     
 * Class:
 * Assignment:
 * Description:  
 *
*******************************************************************/
#include "mainwidget.h"

#define test 0
int main(int argc, char *argv[])
{
 /*
 if(argc == 0)
 {
   std::cout << "To run the gui mode of this application please run ./main -gui"  << std::endl;
 }

 if(argc > 1 && (strcmp(argv[1], "-gui") == 0))
 {
 */
   QApplication app(argc, argv, TRUE);
   QMainWindow *window = new MainWidget(0);
   window->show();
   return app.exec();

 #if test
 }
 else
 {
   Calendar_Record var;
   var.x = 5;
   std::cout << "class var value is:  " << var.x << std::endl;
   std::cout << "Coming Soon" << std::endl;
 }
#endif
 return 0;
}

