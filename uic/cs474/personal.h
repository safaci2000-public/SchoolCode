#ifndef personal_h
#define personal_h

class personal : meeting
{
  private:
  	QString directions;
	QString transportation;
	double budget;

  public:
	void setDirections(QString input );
	void setTransportation(QString input );
	void setBudget(QString input );
	QString getDirections();
	QString getTransportation();
	QString getBudget();
};

void personal::setDirections(QString input )
{
	directions = input;
}
void personal::setTransportation(QString input )
{
	transportation  = input;
}
void personal::setBudget(double input )
{
	budget = input;
}
QString personal:: getDirections()
{
	return directions;
}
QString personal:: getTransportation()
{
	return transportation;
}
double personal:: getBudget()
{
	return budget;
}
#endif
