/* Calendar Class Definition */
#include <QVector>
#include "contacts.h"
#include "meeting.h"
#include <vector>
#include <fstream>

#ifndef calendar_h
#define calendar_h
class Calendar_Record
{
public:
	int x;
	inline Calendar_Record() {}
	void addContact(contacts input);
	void addContact(QString,QString,QString, QString, QString, QString, QString, QString, QString, QString  );
	void addMeeting(meeting input);
	void write(std::ofstream&);
	void read(std::ifstream&);
private:
    std::vector<contacts > contact_list;
    std::vector<meeting > meeting_list;


};
#endif
