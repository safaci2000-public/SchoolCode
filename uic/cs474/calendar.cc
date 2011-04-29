#include "calendar.h"
#include "contacts.h"
#include <iostream>
#include <vector>
#include <QVector>
#include <fstream>

//std::vector<contacts*> Calendar_Record::contact_list;
//std::vector<meeting*> Calendar_Record::meeting_list;

void Calendar_Record::addContact(QString fname,QString lname,QString addr1, QString addr2, QString city, QString state, QString zip , QString hphone, QString cphone, QString email )
{
   contacts new_node;
   new_node.setFname(fname);
   new_node.setLname(lname);
   new_node.setAddress1(addr1);
   new_node.setAddress2(addr2);
   new_node.setState(state);
   new_node.setCity(city);
   new_node.setZip(zip);
   new_node.setHphone(hphone);
   new_node.setCphone(cphone);
   new_node.setEmail(email);

   addContact(new_node);

}
void Calendar_Record::addContact(contacts input)
{
	contact_list.push_back(input);
}

void Calendar_Record::addMeeting(meeting input)
{

}


void Calendar_Record::write(std::ofstream& out)
{
 std::vector<contacts>::iterator i;
 i = contact_list.begin();
 out << contact_list.size();
 contacts a;
 a.setFname("Samir");
 a.setLname("Faci");
 out.write(reinterpret_cast<char *>(&a),sizeof(i));
/*
 while(i != contact_list.end() )
 {
 	//out.write(*i,sizeof(*i));
	out.write(reinterpret_cast<char *>(i),sizeof(*i));
	i++;
 }
*/
}

void Calendar_Record::read(std::ifstream& in )
{
 int i;
 in >> i;

 contacts a;
 in.read(reinterpret_cast<char *>(&a),sizeof(contacts)); 
 std::cout << a.getFname() << a.getLname();

}

