/***************************************************************** 
 * Name:          Samir Faci
 * Class:         CS440
 * Assignment:    Project
 * Description:   Creates a QT frontend for stego 1.0.  Catches 
 * 				   various events and deals with them accordingly
*******************************************************************/
#include "mainwidget.h"
#include "calendar.h"
/*****************************************************************
 * Method:         MainWidget()
 * Arguments:      QMainWindow object
 *           	   
 * Returns:        None
 * Function:       Class Constructor
*******************************************************************/

MainWidget::MainWidget(QMainWindow *parent,bool flag) : QMainWindow(parent) 
{
    setupUi(this);
	//Populate states
	populateStates();
	//Parse Configuration File, if any exists.
	filename = parseConfig();
	if (filename.compare("error") == 0)
	{
       QMessageBox::information(this, "Warning:", "Configuration File, not Found.  All data will be written to calendar.474");
	   filename = "calendar.474";
	}  
	setupConnections(flag);
}

void MainWidget::setupConnections(bool flag)
{
	//manually connect menu Actions
    connect(action_Exit,SIGNAL(triggered()),this,SLOT(terminateProg()));
    connect(actionSave,SIGNAL(triggered()),this,SLOT(on_bt_save_clicked()));
    connect(actionOpen,SIGNAL(triggered()),this,SLOT(OpenFile()));
    connect(actionAbout,SIGNAL(triggered()),this,SLOT(About()));
	//Enable drop down calendar popups
	lb_sdate->setCalendarPopup(true);
	lb_edate->setCalendarPopup(true);
	//Initialize QDateTimeEdit
	lb_sdate->setMinimumDate(QDate::currentDate());
	connect(lb_sdate,SIGNAL(dateChanged(const QDate& )),this,SLOT(update_sdate()));
	lb_edate->setMinimumDate(QDate::currentDate());
	//Hide Panel
	tab_control->hide();
	std::cout << "flag passed in is: " << flag << std::endl;
	if(flag == true)
	{
		tab_control->show();
		bt_browse->hide();
		bt_new->hide();
		tab_control->removeTab(1);
	}
	rd_business->setChecked(true);
	connect(bt_browse,SIGNAL(clicked(bool  )),this,SLOT(browse_items()));
	connect(bt_new,SIGNAL(clicked(bool  )),this,SLOT(new_item()));
	//Deal with Tabs
	connect(tab_control,SIGNAL(currentChanged(int)),this,SLOT(find_tab()));
	//Radio Butons
	connect(rd_business,SIGNAL(clicked(bool  )),this,SLOT(setupBusinessPane()));
	connect(rd_personal,SIGNAL(clicked(bool  )),this,SLOT(setupPersonalPane()));
	//Push Buttons
    connect(lb_save,SIGNAL(clicked()),this,SLOT(on_bt_save_clicked()));
	lb_transportation->hide();
	lb_budget->hide();
	budget_label->hide();
	connect(lb_new_contact,SIGNAL(clicked()),this,SLOT(new_contact()));
}


/*****************************************************************
 * Method:         terminateProg()
 * Arguments:      None
 * Returns:        None
 * Function:       terminate execution of program
*******************************************************************/
void MainWidget::terminateProg()
{
   //exit(0);
   Write();
   this->close();

}
/*****************************************************************
 * Method:         IimageClicked()
 * Arguments:      None
 * Returns:        None
 * Function:       Retrieves a file to be used as the template
 * 				   for the image being created that will store 
 * 				   the data.
*******************************************************************/
void MainWidget::on_bt_save_clicked() 
{

	int x = tab_control->currentIndex();
	if (x == 0)
	{
      QString fname, lname, addr1, addr2, city, state, zip, hphone,cphone,email;
	   fname = le_fname->text();
	   lname = le_lname->text();
	   addr1 = le_addr1->text();
	   addr2 = le_addr2->text();
	   city = le_city->text();
	   hphone = le_hphone->text();
	   cphone = le_cphone->text();
	   email = le_email->text();
	   state = le_state->currentText();
	   zip = le_zip->text();

	   QString temp(fname);
	   temp += lname + addr1 + addr2 + city + hphone + cphone + email + state + zip;
	   entry.addContact(fname,lname,addr1,addr2,city,hphone,cphone,email,state,zip);
       QMessageBox::information(this, "Hello", "Record Saved");
	 }
	 else if(x == 1)
	 {
       QMessageBox::information(this, "Hello", "Saved");
	 }
}
/*****************************************************************
 * Method:         populateStates()
 * Arguments:      None
 * Returns:        None
 * Function:       Populates a QStringList with all the us state
 * 				   abbreviations.
*******************************************************************/
void MainWidget::populateStates()
{
  QStringList states;
  states << "AL"<< "AK"<< "AZ"<< "AR"<< "CA"<< "CO"<< "CT"<< "DE"<< "FL"<< "GA"<< "HI"<< "ID"<< "IL"<< "IN"<< "IA"<< "KS"<< "KY"<< "LA"<< "ME"<< "MD"<< "MA"<< "MI"<< "MN"<< "MS"<< "MO"<< "MT"<< "NE"<< "NV"<< "NH"<< "NJ"<< "NM"<< "NY"<< "NC"<< "ND"<< "OH"<< "OK"<< "OR"<< "PA"<< "RI"<< "SC"<< "SD"<< "TN"<< "TX"<< "UT"<< "VT"<< "VA"<< "WA"<< "WV"<< "WI"<< "WY"; 

  le_state->insertItems(0,states);
  le_state_2->insertItems(0,states);
}

void MainWidget::OpenFile()
{
	 QString s = QFileDialog::getOpenFileName(
	  this,tr("Choose an Input Calendar File"),
        "",
        tr("Calendars (*.474)"));
	
    QMessageBox::information(this, "Calendar Selected",s );


}

//Update to run when sdate is changed
void MainWidget::update_sdate()
{
	lb_edate->setMinimumDate(lb_sdate->date());
}
std::string  MainWidget::parseConfig()
{
	std::ifstream input;

	input.open("config.ini");
	if(input == NULL)
	 {
		std::cerr << "error, could not open config.ini" << std::endl;
		return "error";
	 }
	 char *buffer = new char[80];

	 input.getline(buffer,80);
	 while(buffer[0] != '=')
	 {
		if(buffer[0] == '\n')
		{
			std::cout << "Error, invalid config format\n";
			return "error";
		}
	 	buffer++;
	 }
	 buffer++;  // increment pointer past the equal sign
	 
	 std::cout << "\nfilename is: " << buffer << std::endl;
	 input.close();
	 return std::string(buffer);

}
void MainWidget::test()
{
   	QMessageBox::information(this, "Calendar", "booh!");

}

void MainWidget::find_tab()
{
	int x = tab_control->currentIndex();
	if(x == 1)
		std::cout<< "tab 1 selected\n";
	else
		std::cout<< "tab 0 selected\n";

}

void MainWidget::setupPersonalPane()
{

	//Disable Input text Fields
	lb_deadline->hide();
	lb_emergency->hide();
    tb_requirements->hide();
	lb_transportation->show();
	lb_budget->show();
	budget_label->show();
	//Remove Labels
	label_8->setText("Transportation:");
	label_9->hide();
	label_10->hide();
	label_7->setText("Directions:");

}
void MainWidget::setupBusinessPane()
{

	//Disable Input text Fields
	lb_deadline->show();
	lb_emergency->show();
    tb_requirements->show();
	lb_transportation->hide();
	lb_budget->hide();
	budget_label->hide();
	//Remove Labels
	label_8->setText("Deadline:");
	label_9->show();
	label_10->show();
	label_7->setText("Description:");

}
void MainWidget::new_item()
{
 new_enable_item();
}
void MainWidget::new_enable_item()
{
 //Sets up the widgets to show/Hide upon entering new mode
 tab_control->show();
 le_next->hide();
 le_prev->hide();
 bt_prev->hide();
 bt_next->hide();
 //Sets all items in browse mode to be writable.
 //Set New Contact Widgets
 le_fname->setReadOnly(false);
 le_lname->setReadOnly(false);
 le_addr1->setReadOnly(false);
 le_addr2->setReadOnly(false);
 le_city->setReadOnly(false);
 le_state->setEnabled(true);
 le_hphone->setReadOnly(false);
 le_cphone->setReadOnly(false);
 le_email->setReadOnly(false);
 le_zip->setReadOnly(false);
 //Set New Appointment Widgets
 lb_sdate->setEnabled(true);
 lb_edate->setEnabled(true);
 lb_addr1->setReadOnly(false);
 lb_addr2->setReadOnly(false);
 lb_city1->setReadOnly(false);
 le_state_2->setEnabled(true);
 tb_requirements->setReadOnly(false);
 lb_desc->setReadOnly(false);
 lb_zip1->setReadOnly(false);
 lb_deadline->setReadOnly(false);
 lb_emergency->setEnabled(true);
 tb_requirements->setReadOnly(false);
 lb_guests->setEnabled(true);
 lb_transportation->setReadOnly(false);
 lb_budget->setReadOnly(false);

}
void MainWidget::browse_items()
{
 browse_enable_items();
}
void MainWidget::browse_enable_items()
{
 //Sets up the Widgets to show /Hide upon entering browse mode
 tab_control->show();
 le_next->show();
 le_prev->show();
 bt_prev->show();
 bt_next->show();
 //Sets all items in browse mode to read-only.
 le_fname->setText("");
 le_fname->setReadOnly(true);
 le_lname->setText("");
 le_lname->setReadOnly(true);
 le_addr1->setText("");
 le_addr1->setReadOnly(true);
 le_addr2->setText("");
 le_addr2->setReadOnly(true);
 le_city->setText("");
 le_city->setReadOnly(true);
 le_state->setEnabled(false);
 le_hphone->setText("");
 le_hphone->setReadOnly(true);
 le_cphone->setText("");
 le_cphone->setReadOnly(true);
 le_email->setText("");
 le_email->setReadOnly(true);
 le_zip->setText("");
 le_zip->setReadOnly(true);
 //Set New Appointment Widgets
 lb_sdate->setEnabled(false);
 lb_edate->setEnabled(false);
 lb_addr1->setText("");
 lb_addr1->setReadOnly(true);
 lb_addr2->setText("");
 lb_addr2->setReadOnly(true);
 lb_city1->setReadOnly(true);
 lb_city1->setText("");
 le_state_2->setEnabled(false);
 tb_requirements->setReadOnly(false);
 tb_requirements->setText("");
 lb_desc->setReadOnly(true);
 lb_desc->setText("");
 lb_zip1->setReadOnly(true);
 lb_deadline->setReadOnly(true);
 lb_emergency->setEnabled(false);
 tb_requirements->setReadOnly(true);
 lb_guests->setEnabled(false);
 lb_transportation->setReadOnly(true);
 lb_budget->setReadOnly(true);
}
void MainWidget::About()
{
   	QMessageBox::information(this, "Copyright", "Calendar Application, Copyright UIC, CS474!!");


}

void MainWidget::new_contact()
{
  
   QMainWindow *window = new MainWidget(0,true);
   window->show();


}

void MainWidget::Write()
{
 std::cout << "Write All Changes" << std::endl;
 std::ofstream out;
 out.open(filename.c_str(), std::ios::out| std::ios::binary );
 if(out == NULL)
 {
	std::cerr << "error, could not save Calendar file." << std::endl;
	exit(-1);
 }
 entry.write(out);
 out.close();
 out.open("config.ini");
 if(out == NULL)
 {
	std::cerr << "error, could not open config.ini" << std::endl;
	exit(-2);
 }
 out << "myfile=" << filename;
 out.close();

}
