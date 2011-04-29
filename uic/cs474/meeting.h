#include <QDateTime>
#ifndef meeting_h
#define meeting_h
class meeting
{
  public:
  	//Constructor
	inline meeting();
	~meeting();
    // Set Accessors
  	void setSdate(QDateTime input);
  	void setEdate(QDateTime input);
  	void setSday(QString input);
  	void setEday(QString input);
  	void setAddress1(QString input);
  	void setAddress2(QString input);
  	void setCity(QString input);
  	void setState(QString input);
  	void setZip(QString input);
     // Get Accessors
  	QDateTime getSdate();
  	QDateTime getEdate();
  	QString getSday();
  	QString getEday();
  	QString getAddress1();
  	QString getAddress2();
  	QString getCity();
  	QString getState();
  	QString getZip();
 	 
  private:
     QDateTime sdate;  // handles starting date and time
	 QDateTime edate;  // handles ending date and time 
	 QString sday,			// day of week (check if implemented by date 
	 		 eday,			// class
	 		 address1,
	 		 address2,
			 city,
			 state,
			 zip;

};
#endif 
