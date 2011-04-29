/*****************************************************************
 * Name:          Samir Faci
 * Class:         CS474
 * Assignment:    MP4
 * Description:   
*******************************************************************/

#ifndef MainWidget_H
#define MainWidget_H

#include <QDialog>
#include <QMainWindow>
#include <QWidget>
#include <QMessageBox>
#include <QFileDialog>
#include <QCalendarWidget>
#include <iostream>
#include <string>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <iostream>
#include "ui_main.h"
#include <QDateTimeEdit>
#include <fstream>
#include "calendar.h"




class MainWidget : public QMainWindow, private Ui::MainWindow
{
    Q_OBJECT
	private:
		std::string filename;
		QCalendarWidget *cal;
		QDate temp; // working string accesssible within class
		Calendar_Record entry;
    public:
        MainWidget(QMainWindow *parent = 0,bool flag=false);
		void populateStates();
		std::string parseConfig();
		void setupConnections(bool flag= false);
    private slots:
		//Updates Pane based on 
		void setupPersonalPane();
		void setupBusinessPane();
		void test();			// Testing slot
		void new_contact();			// Testing slot
		void find_tab();
		void update_sdate(); //Sets Edate Minimum to sdate current date
		void terminateProg();
        void on_bt_save_clicked(); // this is automatically connected to the clicked() signal from bt_save
		void new_item();
		void new_enable_item();
		void browse_items();
		void browse_enable_items();
		void OpenFile();  // manually connected slot
		void About();
		void Write();  // Write Calendar to file stored in "filename"
		void Read();  // Read Calendar from file stored in "filename"
};
#endif
