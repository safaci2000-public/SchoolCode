#include <iomanip.h>
#include <stdlib.h>			// used to call the system("clear") function w/h clears the screen.
#include <iostream.h>
#include <fstream.h>
#include <string.h>


struct prof_reference
{
	int reference;
	char name[10];
	int points ;
	int credit ;
	double teacher_gpa;
	int students;
};


struct student
{
	long ss;
	int credit;
	int newCredit;
	int points;
	int newPoints;
	double oldgpa;
	double newgpa;
	int change;
	char status[10];
	char status2[10];
};

struct record
{
   int reference;			// teacher reference.
   int class_credit;		// class credit self-explanetory.
   char grade;				// grade earned by student.
   int points;				// stores the equivalent of the grade
							// obtained
							// by the student.
};

struct standing
{
	int status ;				// keeps track of how many # of students are in each standing
							// ie. freshmen, soph, junior, senior.
	int improved;			// # of each class that improved.
};

inline void clrscr();
void proffessor_function (prof_reference[], ifstream &, int &);
void student_function (student[], ifstream &, int &);
void record_function (record[], ifstream & , int &);
void teacherGPA (record[], prof_reference[], int &);
void GetStatus (student[], int &, standing[]);
int grade (char);
int calcGPA (student[], int &);


void Print (ofstream & , student[], int &, standing []);
void Print (ofstream &, prof_reference[], int &);
void Print (ofstream &, standing[], int, student[], int &);


int main(void)
{
   int code = 0;
   prof_reference proff[6];			/* see structure doc for info */
   student stud[50];
   record reff[100];
   char ch = '\0';							/* used to pause program */
   standing status[4] = { 0,0,0,0,
						  0,0,0,0}; // used to store # of fresh,
									// soph..etc.
   int total_students = 0;			// used to store total # of students.
   int counter = 0;					// used to in for loop to initialize
									// structures.
   int track = 0;					// keeps track of the which member of the
									// structure
									// array we're dealing with.
   int trackStudent = 0;			// keeps track of array element in the
									// student struct.
   int trackRecord = 0;				// keeps track of array element in the

   ifstream infile;
   ofstream outfile;
   

   clrscr ();
   cout << "this program will read data from a file.  then store the data read"<< endl;
   cout<< "in structures.  It will then arrange the data accordingly and store" << endl;
   cout<< "them in an output file.  The output file will contain 3 reports.\n"<< endl;
   cout<< "the Student Status Report, The Student Summery, and the Proffessor"<< endl;
   cout<< "report." << endl;
   cout<< "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n       Press enter yes to continue  ";
   cin>> ch;
   clrscr ();
   cout<< "reading data file...please wait!!\n";
   clrscr ();
   infile.open("pgm1.dat");
   outfile.open("z002161.pgm9.out");

   if (!infile || !outfile )
	   exit(101);

   
   for (counter = 0; counter < 6; counter++) {
      proff[counter].points = 0;	/* initialises some elements of some */
      proff[counter].credit = 0;	// structs.
      proff[counter].students = 0;
   }
   

   infile >> code;
   while (code == 0) {
      proffessor_function (proff, infile, track);
      infile >> code;
	  track++;
   }
	  

   while (1) {
	  student_function (stud, infile, trackStudent);				
      stud[trackStudent].oldgpa = ((double) stud[trackStudent].points /
				   (double) stud[trackStudent].credit);
      stud[trackStudent].newPoints = 0;
      stud[trackStudent].newCredit = 0;
      infile >> code;
	  trackStudent++;
      if (trackStudent > 30)
			break;					// fail safe.
      while (code == 2) {
	 record_function (reff, infile, trackRecord);					
	 teacherGPA (reff, proff, trackStudent);	// self-explanetory.
	 reff[trackRecord].points = grade (reff[trackRecord].grade);
	 stud[trackStudent - 1].newPoints += (reff[trackRecord].points* 4);			// switch these two statements.
	 stud[trackStudent - 1].newCredit += reff[trackRecord].class_credit;	// and this one
	 infile >> code;
	 if (code == 1) {
	    stud[trackStudent - 1].change = calcGPA (stud, trackStudent);
	    GetStatus (stud, trackStudent, status);
	 }
	 trackRecord++;
	 if (trackRecord > 70)
	    break;
      }
   }

	trackStudent -=3;

	stud[trackStudent].change = calcGPA (stud, trackStudent);
	GetStatus (stud, trackStudent, status);

   
   cout << "output written to z002161.pgm9.out" << endl;
   cout << "thanks you for using an S&F Tech. product" << endl;



   track = 1;
   for (counter = 0; counter < 28; counter++) {
      if (counter % 10 == 0) {
	 outfile << "\n\f"; 
	 outfile << "                STUDENT STATUS REPORT             PAGE " << track<< endl;
	 outfile << "SSN         GRADE LEVEL     CREDIT    POINTS     GPA     DECREASED\n";
	 track++;
      }

						/* Prints student status report */

      Print (outfile, stud, counter, status);
   }

   total_students = status[0].status + status[1].status + status[2].status + status[3].status;
   outfile << "\f\n";
   outfile << "                STUDENT SUMMERY                   PAGE" << track<< endl;
   outfile << "STATUS:         TOTAL      PERCENT(%)     IMPROVED"<< endl;
   track++;
   for (counter = 0; counter < 4; counter++)
      Print (outfile, status, total_students, stud, counter);

						/* prints student summery report */

   
   outfile << "\f\n";
   outfile << "                PROFFESSOR REPORT                 PAGE " << track<< endl;
   outfile << "NAME:         TOTAL STUDENTS        AVG. GPA"<< endl;
   track++;

						/* prints Proffessor Report */
   for (counter = 0; counter < 6; counter++) {
      Print(outfile, proff, counter);
   }






return 0;
}



 


/**************************************************************************
Function:	clears the screen
Arguments:	none
Returns:	none
Notes:		replaces the clrscr() function from the conio.h library.
**************************************************************************/
inline void clrscr()
{
 system("clear");
}

/**************************************************************************
Function:	void proffessor_function();
Arguments:	integer, char []
Returns:	none but modifies 2 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void proffessor_function (prof_reference proff[], ifstream &infile, int 
&counter)
{
	infile >> proff[counter].reference >> proff[counter].name;
}

/**************************************************************************
Function:	void student_function();
Arguments:	long int, int, int
Returns:		none but modifies 3 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void student_function (student stud[], ifstream &infile, int &counter)
{
   infile >> stud[counter].ss >> stud[counter].credit >> stud[counter].points;

}

/**************************************************************************
Function:	void record_function()
Arguments:	int, int, char
Returns:		none but modifies 3 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void record_function (record reff[], ifstream &infile, int &counter)
{
	infile >> reff[counter].reference >> reff[counter].class_credit 
		>> reff[counter].grade;

}

/**************************************************************************
Function:	gets data to calculate the teacher gpa;
Arguments:	student [], int, int
Returns:	none
Notes:		NA
**************************************************************************/

void teacherGPA (record reff[], prof_reference proff[], int &counter)
{
   if (proff[0].reference == reff[counter].reference) {
      proff[0].points += (reff[counter].points*4);
      proff[0].credit += reff[counter].class_credit;
      proff[0].students++;
   }

   else if (proff[1].reference == reff[counter].reference) {
      proff[1].points += (reff[counter].points*4);
      proff[1].credit += reff[counter].class_credit;
      proff[1].students++;
   } else if (proff[2].reference == reff[counter].reference) {
      proff[2].points += (reff[counter].points*4);
      proff[2].credit += reff[counter].class_credit;
      proff[2].students++;
   }

   else if (proff[3].reference == reff[counter].reference) {
      proff[3].points += (reff[counter].points*4);
      proff[3].credit += reff[counter].class_credit;
      proff[3].students++;
   }

   else if (proff[4].reference == reff[counter].reference) {
      proff[4].points += (reff[counter].points*4);
      proff[4].credit += reff[counter].class_credit;
      proff[4].students++;
   } else if (proff[5].reference == reff[counter].reference) {
      proff[5].points += (reff[counter].points*4);
      proff[5].credit += reff[counter].class_credit;
      proff[5].students++;
   }
}

/**************************************************************************
Function:	Gets the Status of a student based on his credits.
				mathes his credit to a fresh., soph., junior, or senior.
Arguments:	student [], int
Returns:		none
Notes:		NA
**************************************************************************/

void GetStatus (student stud[], int &counter, standing status[])
{
   if (stud[(counter) - 1].newCredit > 0
       && stud[(counter) - 1].newCredit <= 30) {
      strcpy (stud[(counter) - 1].status2, "Freshman ");
      status[0].status++;
   }
      else if (stud[(counter) - 1].newCredit > 30
	       && stud[(counter) - 1].newCredit <= 60) {
      strcpy (stud[(counter) - 1].status2, "Sophomore");
      status[1].status++;
   }
      else if (stud[(counter) - 1].newCredit > 60
	       && stud[(counter) - 1].newCredit <= 90) {
      strcpy (stud[(counter) - 1].status2, "Junior   ");
      status[2].status++;
   } else {
      strcpy (stud[(counter) - 1].status2, "Senior   ");
      status[3].status++;
   }

   if (stud[(counter) - 1].credit > 0 && stud[(counter) - 1].credit <= 30)
      strcpy (stud[(counter) - 1].status, "Freshman ");
   else if (stud[(counter) - 1].credit > 30
	    && stud[(counter) - 1].credit <=
	    60) strcpy (stud[(counter) - 1].status, "Sophomore");
   else if (stud[(counter) - 1].credit > 60
	    && stud[(counter) - 1].credit <=
	    90) strcpy (stud[(counter) - 1].status, "Junior   ");
   else
      strcpy (stud[(counter) - 1].status, "Senior   ");

}

/**************************************************************************
Function:	matches a letter grade with a numberic value.
Arguments:	char grade
Returns:	an integer...the numeric value of the letter grade.
Notes:		NA
**************************************************************************/
int grade (char grade)
{
   int value = 0;		// return the point value of letter grade.
   switch (grade) {
   case 'A':
      value = 4;
      break;
   case 'B':
      value = 3;
      break;
   case 'C':
      value = 2;
      break;
   case 'D':
      value = 1;
      break;
   case 'F':
      value = 0;
      break;
   default:
      value = 0;
   }
   return value;
}

/**************************************************************************
Function:	calculate the students new gpa and returns a 1 or 0 depending
			on whether the student improved his grades or not compared to
			his previous semester.
Arguments:	student [], int, int
Returns:	none
Notes:		NA
**************************************************************************/
int calcGPA (student stud[], int &trackStudent)
{
   stud[trackStudent - 1].newPoints += stud[trackStudent - 1].points;
   stud[trackStudent - 1].newCredit += stud[trackStudent - 1].credit;

   stud[trackStudent - 1].newgpa =
      ((double) stud[trackStudent - 1].newPoints /
       (double) stud[trackStudent - 1].newCredit);
   if (stud[trackStudent - 1].newgpa > stud[trackStudent - 1].oldgpa) {
      return 0;
   }
   if (stud[trackStudent - 1].newgpa < stud[trackStudent - 1].oldgpa) {
      return 1;
   }
   return (0);
}


/**************************************************************************
Function:	prints the student report to a file.
Arguments:	student [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
void Print (ofstream &outfile, student stud[], int &counter, standing 
status[])
{
   outfile  << stud[counter].ss << "\t" << stud[counter].status<< "\t" << stud[counter].credit
		<< "\t"<< stud[counter].points<< "\\" << hex << stud[counter].points << dec << "\t\t" << 
		setw(6) << setprecision(3) << stud[counter].oldgpa<< endl;
   
   outfile << stud[counter].ss << "\t" << stud[counter].status2 << "\t" <<stud[counter].newCredit
		<< "\t" << stud[counter].newPoints << "\\" << hex << stud[counter].newPoints << dec <<
		  "\t" << setw(6) << setprecision(3) << stud[counter].newgpa;
   
   if (stud[counter].change == 1)
   {
	   outfile << "\t\tYES";
	   if (stud[counter].status2[0] == 'F')
		   status[0].improved ++;
	   if (stud[counter].status2[0] == 'S')
		   status[1].improved++;
	   if (stud[counter].status2[0] == 'J')
		   status[2].improved++;
	   if (stud[counter].status2[0] == 'S')
		   status[3].improved++;
   }	

   
   outfile << endl<< endl;
}

/**************************************************************************
Function:	prints the teacher report to a file.
Arguments:	prof_reference [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
void Print (ofstream &outfile, prof_reference proff[], int &counter)
{
   proff[counter].teacher_gpa = double(proff[counter].points) /
      double(proff[counter].credit);
   
   outfile << proff[counter].name << "\t\t" << proff[counter].students << setprecision(2) <<
		setw(6) <<	"\t\t" << proff[counter].teacher_gpa << endl;
   
}

/**************************************************************************
Function:	prints the teacher report to a file.
Arguments:	prof_reference [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
void Print (ofstream &outfile, standing status[], int total_students,
		student stud[], int &counter)
{
   char rank[10];		// variable used to store rank of student.
   if (counter == 0)
      strcpy (rank, "Freshman");
   else if (counter == 1)
      strcpy (rank, "Sophmore");
   else if (counter == 2)
      strcpy (rank, "Junior  ");
   else
      strcpy (rank, "Senior  ");
   outfile << rank << "\t" << status[counter].status << "\t\t" << setprecision(2) << setw(6) <<
	    (double(status[counter].status) / double(total_students)*100) << "\t\t" << 
	   (status[counter].status - status[counter].improved + 1) << endl;
   
}
