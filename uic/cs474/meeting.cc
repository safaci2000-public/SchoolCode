#include "meeting.h"
#include <iostream>

//Constructor + Destuctors
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
inline meeting::meeting()
{

    sdate = QDateTime::currentDateTime();
    edate = QDateTime::currentDateTime();

}

meeting::~meeting()
{
	std::cout << "destructor called" << std::endl;
}
// Set Accessors
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setSdate(QDateTime input)
{
	sdate = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setEdate(QDateTime input)
{
	edate = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setSday(QString input)
{
	sday = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setEday(QString input)
{
	eday = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setAddress1(QString input)
{
	address1 = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setAddress2(QString input)
{
	address2 = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setCity(QString input)
{
	city = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setState(QString input)
{
	state = input;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
void meeting::setZip(QString input)
{
	zip = input;

}
// Get Accessors
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QDateTime meeting::getSdate()
{
	return sdate;	

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QDateTime meeting::getEdate()
{
	return edate;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getSday()
{
	return sday;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getEday()
{
	return eday;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getAddress1()
{
	return address1;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getAddress2()
{
	return address2;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getCity()
{
	return city;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getState()
{
	return state;

}
/*****************************************************************
 * Method:         
 * Arguments:      
 * Returns:        
 * Function:       
 * 				   
*******************************************************************/
QString meeting:: getZip()
{
	return zip;

}
