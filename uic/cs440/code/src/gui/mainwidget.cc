/*****************************************************************
 * Name:          Samir Faci
 * Class:         CS440
 * Assignment:    Project
 * Description:   Creates a QT frontend for stego 1.0.  Catches 
 * 				   various events and deals with them accordingly
*******************************************************************/
/**********************************************************************
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
 *
*******************************************************************/
#include "mainwidget.h"
/*****************************************************************
 * Method:         MainWidget()
 * Arguments:      QMainWindow object
 *           	   
 * Returns:        None
 * Function:       Class Constructor
*******************************************************************/

MainWidget::MainWidget(QMainWindow *parent) : QMainWindow(parent) 
{
    setupUi(this);
	//connects function IImageClicked to the clicking action
    connect(IImage,SIGNAL(clicked()),this,SLOT(IImageClicked()));
	//connects function file_exit to the clicking of the file menu Exit
    connect(actionExit_2,SIGNAL(triggered()),this,SLOT(on_bExit_clicked()));
//  bool that checks if tab2 has been accessed
	tab2_used = false;
	// command string builds up the command to be executed
	command = "./stego ";
	input = "";
	output = "";
	embed = "";

} 
// Embed Image Actions
/*****************************************************************
 * Method:         IimageClicked()
 * Arguments:      None
 * Returns:        None
 * Function:       Retrieves a file to be used as the template
 * 				   for the image being created that will store 
 * 				   the data.
*******************************************************************/
void MainWidget::IImageClicked() 
{
	
	// only execute if tab2 hasn't already been used
	if (tab2_used == false)
	{
	 QString s = QFileDialog::getOpenFileName(
	  this,
        "Choose an Input Image File "
        "/home",
        "Images (*.png *.tiff *.jpg *.gif)");

     input = s.toStdString ();
	 QString qcmd = "./stego --input";
	 qcmd.append(s);

	// updates label as it builds up the command for user view
	label1->setText(qcmd);

 	 OImage->setEnabled(true);
	}
	else
     QMessageBox::information(this, "Stego Error",
    "The Extract Tab is already in use.  Please complete the extract process or restart the program.\n  Only one action can be performed at a time.");
}
/*****************************************************************
 * Method:         OImage_clicked()
 * Arguments:      None
 * Returns:        None
 * Function:       Obtains a file to be used to store the image
 * 				   and the data file that will be embedded within
 * 				   it.
*******************************************************************/
void MainWidget::on_OImage_clicked() 
{

  // ensures that tab2 has not been accessed yet.
  if (tab2_used == false)
	{
	 QString s = QFileDialog::getSaveFileName(
	  this,
        "Choose an Input Image File "
        "/home",
        "Images (*.png *.tiff *.jpg *.gif)");

     output= s.toStdString ();  // sets class variable
	 // updates the current command buing built
	 QString qcmd = "--output ";
	 qcmd.append(s);
	 label2->setText(qcmd);

 	 EData->setEnabled(true);
	}
	else
     QMessageBox::information(this, "Stego Error",
    "The Extract Tab is already in use.  Please complete the extract process or restart the program.\n  Only one action can be performed at a time.");
}
/*****************************************************************
 * Method:         on_EData_clicked
 * Arguments:      None
 * Returns:        None
 * Function:       Obtains a file to embed in image
 * 				   
*******************************************************************/
void MainWidget::on_EData_clicked() 
{

  // ensures that tab2 has not been accessed yet.
  if (tab2_used == false)
	{
	 QString s = QFileDialog::getOpenFileName(
	  this,
        "Choose a Data File to embed"
        "/home",
        "Images (*.png *.tiff *.jpg *.gif)");

     embed = s.toStdString ();
	 command = "./stego --input " + input + "  --output " + output + " --embed " + embed;

	 QString qcmd = "--embed ";
	 qcmd.append(s);
	 // updates label for user view
	 label3->setText(qcmd);

	 if (!bRun->isEnabled())
 	   bRun->setEnabled(true);
	}
	else
	{
     QMessageBox::information(this, "Stego Error",
    "Cannot activate the Execute button.  It is already activated.  Program Now Exiting");
	exit(-999);
	}
}
//Extract Image Actions
/*****************************************************************
 * Method:         on_OpenEmbed_clicked()
 * Arguments:      None
 * Returns:        None
 * Function:       selects an image to retrieve data from 
 * 				   
*******************************************************************/
void MainWidget::on_OpenEmbed_clicked() 
{

   // check status of other tab
   bool tab2 = true;
   // checks to see if button 2 has been enabled
   tab2 = OImage->isEnabled();

   // if tab2 is already in use, then I can't proceed
   if (tab2 == false)
   {
		QString s = QFileDialog::getOpenFileName(
		  this,
          "Choose an Image File "
          "/home",
          "Images (*.png *.tiff *.jpg *.gif)");

	// stores file name in s
    std::string str = s.toStdString ();
	
	command = "./stego  --extract " + str;

	 QString qcmd = "./stego --extract";
	 qcmd.append(s);
	 extract = qcmd.toStdString();

	// update label for user view with current command
	label1->setText(qcmd);

	// enable execute button
   	bRun->setDisabled(false);  
	tab2_used = true;
   }
   else
   {
    QMessageBox::information(this, "Stego Error",
    "The Embed Tab is already in use.  Please complete the Embed process or restart the program.\n  Only one action can be performed at a time.");
   }

}
// Other Actions
/*****************************************************************
 * Method:         on_bRun_clicked()
 * Arguments:      None
 * Returns:        None
 * Function:       execute program once button is clicked and ensures
 * 					it executes without throwing any errors
 * 				   
*******************************************************************/
void MainWidget::on_bRun_clicked() 
{
	QString qcommand(command.c_str());
	QString fyi = "I've execute the following command:  ";
	fyi.append(qcommand);
	fyi.append("see log.txt for more info.");
	int status=0; // exit code returned upon program execution
	int return_code=0; // status code returned upon program execution

	return_code = system(command.c_str());
    status=WEXITSTATUS(return_code);
	// Error Checks on execution of console program
	if(status == 2)
	{
		QMessageBox::information(this,"Parms Error",
	"Program Called with invalid parmeters passed in.  Program Exiting");
		exit(2);
	}
	else if(status ==3)
	{
		QMessageBox::information(this,"Access Error",
	"Cannot Open or Create file.  Check your arguments and permissions and try again.");
		exit(3);
	}
	else if(status ==4)
	{
		QMessageBox::information(this,"Embed Content Error",
	"No Embedded content was found in image.  Abort!  Program Exiting!");
		exit(4);
	}
	else if(status ==5)
	{
		QMessageBox::information(this,"File Type Mismatch",
	"You specified two file types that are not comptible.  The Image types must be consitant");
		exit(5);
	}
	else if(status ==6)
	{
		QMessageBox::information(this,"Same File Parms",
	"You specified the same file for both input and output parameters.  Files must be different");
		exit(6);
	}
	else if(status == 7)
	{
		QMessageBox::information(this,"Unsupported Image type",
	"You've selected an image type that is currently not supported.  jpg, gif, png, and tiff are the only image formats that are currently supported");
		exit(7);
	}

	reset();  // prompts the user if he wishes to execute the 
			  // program again or perform another action.

	
}   
/*****************************************************************
 * Method:         on_bExit_clicked()
 * Arguments:      None
 * Returns:        None
 * Function:       Exits program when button exit is called   
 * 				
 * 				   
*******************************************************************/
void MainWidget::on_bExit_clicked() 
{
	

	//doh. exit program
	exit(0);
}
/*****************************************************************
 * Method:         reset()
 * Arguments:      None
 * Returns:        None
 * Function:       If User wishes to repeat the process, resets
 * 				   status.
 * 				   
*******************************************************************/
void MainWidget::reset() 
{
    QMessageBox mb("Repeat? -- Stego 1.0",
       "Would you like to perform another action?",
       QMessageBox::Question,
       QMessageBox::Yes | QMessageBox::Default,
       QMessageBox::No | QMessageBox::Escape,
       QMessageBox::NoButton);

    if (mb.exec() == QMessageBox::No) 
		exit(0);  
                
	//  bool that checks if tab2 has been accessed
	tab2_used = false;
	// command string builds up the command to be executed
	command = "";
	input = "";
	output = "";
	embed = "";
	extract = "";

	// disables required buttons
   	bRun->setDisabled(true);  
   	OImage->setDisabled(true);  
   	EData->setDisabled(true);  
}
