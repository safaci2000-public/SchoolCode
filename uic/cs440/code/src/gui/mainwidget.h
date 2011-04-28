/*****************************************************************
 * Name:          Samir Faci
 * Class:         CS440
 * Assignment:    Project
 * Description:   header file for a class which catch event on QT
 * 				  User interface
 * 				   
 * Error Codes:
 *		2 == Error, invalid parms passed in.
 *		3 == Error, cannot open file or create file
 *		4 == no embedded content detected in image.  Or content 
 *				was not embedded by this program
 *		5 == file type mismatch
 *		6 == input and output files are the same
 *		7 ==  Invalid Image type 
 *		8 ==  Error, could not fork
 *		-999 == cannot activate exec button.  
*******************************************************************/
#include <QMainWindow>
#include <QWidget>
#include <QMessageBox>
#include <QFileDialog>
#include <iostream>
#include <string>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <iostream>
#include "ui_form.h"

class MainWidget : public QMainWindow, private Ui::mainWindow
{
    Q_OBJECT
    public:
        MainWidget(QMainWindow *parent = 0);
		void reset();

	private:
		bool tab2_used;  // checks to see if tab2 has been used already
		std::string command; // command to execute
		std::string input;	// input image
		std::string output; // output image
		std::string embed; // embed image
		std::string extract;
    private slots:
        void IImageClicked(); //manually connect this
        void on_OImage_clicked(); // this is automatically connected to the clicked() signal from button2
        void on_bExit_clicked(); // this is automatically connected to the clicked() signal from button2
        void on_OpenEmbed_clicked(); // this is automatically connected to the clicked() signal from button2
        void on_bRun_clicked(); // this is automatically connected to the clicked() signal from button2
		void on_EData_clicked();
};
