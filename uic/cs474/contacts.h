#include <QString>
#include <vector>

#ifndef contact_h
#define contact_h
/* contacts Class Definition */
class contacts 
{
  public:
	// Cons/Des methods
//	inline contacts();  // : QString(fname),QSring(lname),QString(address1),QString(address2),QString(city),QString(state),QString(city),QString(state),QString(zip), QString(hphone), QString(cphone), QString(wphone), QString(email) 
	inline contacts()
	{
     contactCount++; // increments number of contacts by 1;
	}


	~contacts(); // Destructor
  	//Get Accessors
	QString getFname();
	QString getLname();
	QString getAddress1();
	QString getAddress2();
	QString getCity();
	QString getState();
	QString getZip();
	QString getHphone();
	QString getCphone();
	QString getEmail();
	// Set Accessors
	void setFname(QString input);
	void setLname(QString input);
	void setAddress1(QString input);
	void setAddress2(QString input);
	void setCity(QString input);
	void setState(QString input);
	void setZip(QString input);
	void setHphone(QString input);
	void setCphone(QString input);
	void setEmail(QString input);

  private:
	int id;
	static int contactCount;
  	QString fname,
			lname,
			address1,
			address2,
			state,
			city,
			zip,
			hphone,
			cphone,
			email;

};

#endif
