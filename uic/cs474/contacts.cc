#include "contacts.h"


int contacts::contactCount = 0;
//Constructor
contacts::~contacts()
{
   contactCount--; // increments number of contacts by 1;

}

//Define Accessors
QString contacts::getFname()
{
 return fname;
}
QString contacts::getLname()
{
 return lname;
}
QString contacts::getAddress1()
{
 return address1;
}
QString contacts::getAddress2()
{
 return address2;
}
QString contacts::getCity()
{
 return city;
}
QString contacts::getState()
{
 return state;
}
QString contacts::getZip()
{
 return zip;
}
QString contacts::getHphone()
{
 return hphone;
}
QString contacts::getCphone()
{
 return cphone;
}
QString contacts::getEmail()
{
 return email;
}


void contacts::setFname(QString input)
{
  fname = input;

}
void contacts::setLname(QString input)
{
   lname = input;

}
void contacts::setAddress1(QString input)
{
  address1 = input;

}
void contacts::setAddress2(QString input)
{
  address2 = input;

}
void contacts::setCity(QString input)
{
	city = input;
}
void contacts::setState(QString input)
{
  state = input;

}
void contacts::setZip(QString input)
{
  zip = input;

}
void contacts::setHphone(QString input)
{
  hphone = input;

}
void contacts::setCphone(QString input)
{

  cphone = input;

}
void contacts::setEmail(QString input)
{
  email = input;

}
