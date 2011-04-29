
#ifndef business_h
#define business_h
class business: meeting
{
  private:
  	QString description;
	// change emergency to instance of contact
	QString emergency;
    QDateTimeEdit deadline;
	QString specs;
	QString advisorNotes;

  public:
	void setDescription(QString input );
	void setEmergency(QString input );
	void setDeadline(QDateTimeEdit input );
	void setSpecs(QString input );
	void setAdvisorNotes(QString input );
	QString setDescription(QString input );
	QString setEmergency(QString input );
	QDateTimeEdit setDeadline(QString input );
	QString setSpecs(QString input );
	QString setAdvisorNotes(QString input );

};
// Set Accessors
void business::setDescription(QString input )
{
	description = input;
}

void business::setEmergency(QString input )
{
	emergency = input;
}

void business::setDeadline(QDateTimeEdit input )
{
	deadline = input;

}

void business::setSpecs(QString input )
{
	specs = input;
}

void business::setAdvisorNotes(QString input )
{
	advisorNotes = input;
}

// Get Accessors
QString business::setDescription(QString input )
{
	return description;
}

QString business::setEmergency(QString input )
{
	return emergency;
}

QDateTimeEdit business::setDeadline(QString input )
{
	return deadline;
}

QString business::setSpecs(QString input )
{
	return specs;
}

QString business::setAdvisorNotes(QString input )
{
	return advisorNotes;
}
#endif
