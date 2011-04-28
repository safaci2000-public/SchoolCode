/***********************************************************************
	Program:	Assinment 5
	Author:		Samir Faci
	LogonID:	z002161
	Due Date:   08/08/2001

	Function:	reads data into an object array dyanmically allocated.
				calculates misc info such as grade, quiz, class avg...etc.
				prints the info, then sorts it based on SSN then by total_avg.
				
				the program also performs a heap sort or a quick sort 
				depending on program parametters passed.

	Input:		pgm10.in

	Output:		to screen or can be redirected to a file if necessery.

	Notes:		

***********************************************************************/


#include <string>
#include <iostream>
using namespace std;

const int NUM_OF_QUIZ = 10;
const int NUM_OF_TESTS = 2;

class students
{
private:						// should be private:
	string first_name;
	string last_name;
	string ssn;
	int quiz[10];
	int test[2];
	float quiz_avg;
	float test_avg;
	float total_avg;
	



public:


		// set methods are different methods used to change private data members //


	void setfirstname(string stud_name){first_name = stud_name;}
	void setlastname(string stud_name){last_name = stud_name;}
	void setsoc(string soc){ ssn= soc;}
	void setquiz(int quiz_score, int location) { quiz[location] = quiz_score; }
	void settest(int test_score, int location) { test[location] = test_score; }
	void setallquiz(int quiz_scores[]);
	void setalltests(int test_scores[]);


	// get methods are different access methods used to access private data memebers //
		
	
	string getfirstname() { return first_name; }
	string getlastname() { return last_name; }
	string getsoc() {return ssn; }
	float getquizavg() {return quiz_avg; }
	float gettestavg() {return test_avg; }
	float gettotalavg() {return total_avg; }
	int getquiz(int location) { return quiz[location]; }
	int gettest(int location) {return test[location]; }




	void calcAvgQuizScore();
    void calcAvgTest();
	void calcGrade();
	void calcClassAvg(students *, int );


	static students * buildAr(students *&, int);   // should be static 


	// functions below are overloaded operators, some of which actually work //  *****	
	
	students & operator=(const students & second_student);
    bool operator<(students & second_student);
    bool operator>(students & second_student);
	bool operator==(students & second_student);
    friend ostream &operator<<(ostream &stream, const students & stud);
	friend istream &operator>>(istream &stream, const students & stud);

	
	
	students();

	~students();


};


/**************************************************************************
Function:	construct that sets all variables to NULL, or zero.

Arguments:	none.
Returns:	
Notes:
**************************************************************************/
students::students()
{
 first_name = "";
 last_name = "";
 ssn = "";
 test_avg = 0;
 quiz_avg = 0;
 total_avg = 0;

	for (int counter=0; counter < 10; counter++)
		quiz[counter] = 0;


	for (int counter2 = 0; counter2 < 2; counter2++)
		test[counter2] = 0;

}


/**************************************************************************
Function:	A deconstructor that ................

Arguments:	none
Returns:	none.
Notes:
**************************************************************************/
students::~students()
{

	quiz_avg = 0;
	test_avg = 0;
	total_avg = 0;
	first_name = last_name = ssn = "";

}


/**************************************************************************
Function:	sets all quiz scores to the value of the array passed in.

Arguments:	int []
Returns:	
Notes:
**************************************************************************/
void students::setallquiz(int quiz_scores[])
{
 for (int counter = 0; counter < 10; counter++)
	 quiz[counter] = quiz_scores[counter];

}


/**************************************************************************
Function:	sets all test scores to the value of the array passed in.

Arguments:	int []
Returns:	
Notes:
**************************************************************************/
void students::setalltests(int test_scores[])
{
 for (int counter = 0; counter < 2; counter++)
	 test[counter] = test_scores[counter];

}



/**************************************************************************
Function:	calculates the average quiz grade.

Arguments:	none
Returns:	none
Notes:
**************************************************************************/
void students::calcAvgQuizScore()
{
 int sum = 0;

 for (int counter = 0; counter < 10; counter++)
	 sum += quiz[counter];

 quiz_avg = sum ;

}

/**************************************************************************
Function:	calculates the Average Test score.

Arguments:	none
Returns:	none
Notes:
**************************************************************************/
void students::calcAvgTest()
{
 int sum = 0;

 sum = (test[0] + test[1]);

 test_avg = sum / NUM_OF_TESTS;
}



/**************************************************************************
Function:	Calculate a grade for the student.

Arguments:	none
Returns:	none
Notes:
**************************************************************************/
void students::calcGrade()
{

 if (test_avg == 0 || quiz_avg == 0)
 {
	 calcAvgQuizScore();
	 calcAvgTest();
 }
 else
	 total_avg = ((0.4 * quiz_avg) + (0.6 * test_avg));


}



	/* following methods overload certain operators of the C++ language */


/**************************************************************************
Function:	to set the ssn # of one student to the ssn number of another.
			method overloads the = operator.

Arguments:	two objects of the student class.
Returns:	the value of the second object.
**************************************************************************/
students & students::operator =(const students & second_student)
{
	int counter;
	first_name = second_student.first_name;
	last_name = second_student.last_name;
	

	for (counter = 0; counter < NUM_OF_QUIZ; counter++)
		quiz[counter] = second_student.quiz[counter];
		

	for (counter = 0; counter < NUM_OF_TESTS; counter++)
		test[counter] = second_student.test[counter];
	

	ssn = second_student.ssn;
	
	quiz_avg = second_student.quiz_avg;
	test_avg = second_student.test_avg;
	total_avg = second_student.total_avg;


	return *this;


}


/**************************************************************************
Function:	

Arguments:	
Returns:	
Notes:
**************************************************************************/
bool students::operator==(students & second_student)
{
	if (ssn == second_student.ssn)
		return 1;
	else
		return 0;

}

/**************************************************************************
Function:	to compare two student's ssn, method overloads the > operator.

Arguments:	two objects of the student class.
Returns:	a bool.
Notes:
**************************************************************************/
bool students::operator>(students & second_student)
{
	if (ssn > second_student.ssn)
		return true;
	else 
		return false;

}

/**************************************************************************
Function:	to compare two student's ssn, method overloads the < operator.

Arguments:	two objects of the student class.
Returns:	a bool.
Notes:
**************************************************************************/
bool students::operator<(students & second_student)
{
	if (ssn < second_student.ssn   )
		return true;
	else 
		return false;

}

/**************************************************************************
Function:	overloads the input stream

Arguments:	stream w/h is a pointer to the input stream
			stud   w/h is an object of the students class.

Returns:	none
Notes:
**************************************************************************/
istream &operator>>(istream &stream, students &stud)
{

	string first, last, ss;	// used to store data into private variables.
	int num;				// used to store data into private variables.

	cin >> first >> last >> ss;
		
	stud.setfirstname(first);
	stud.setlastname(last);
	stud.setsoc(ss);
	

	for (int quizcounter= 0; quizcounter < NUM_OF_QUIZ; quizcounter++)
	{
		cin >> num;
		stud.setquiz(num, quizcounter);
	}


	for (int testcounter = 0; testcounter < NUM_OF_TESTS  ; testcounter++)
	{
		cin >> num;
		stud.settest(num, testcounter);
	}
		
	return stream;

} 




/**************************************************************************
Function:	overloads the output stream

Arguments:	stream w/h is a pointer to the output stream
			stud   w/h is an object of the students class.

Returns:	none
Notes:
**************************************************************************/
ostream &operator<<(ostream &stream, students & stud)
{
	
	cout << stud.getfirstname() << "  " << stud.getlastname() << endl;
	cout << stud.getsoc() << endl;

	cout.setf(ios::showpoint);
	cout.precision(4);

	cout << "Quiz Average:   " << stud.getquizavg() << "%" << endl;
	cout << "Test Average:   " << stud.gettestavg() << "%" << endl;
	cout << "Total Average:  " << stud.gettotalavg() << "%" << endl;

	return stream;


}

/**************************************************************************
Function:	

Arguments:	
			

Returns:	none
Notes:
**************************************************************************/

students * students::buildAr(students *& classptr, int size)   // should be static 
{

	students *temp;


	temp = classptr;
	classptr = new students[size];

	for (int counter = 0; counter < size; counter++)
		{
			cin >> classptr[counter];
	
		}



	return temp;

}




void students::calcClassAvg(students *classptr, int size)
{
	float class_quiz_avg = 0;
	float class_test_avg = 0;
	float class_grade_avg = 0;



	for (int counter = 0; counter < size; counter++)
	{

		class_quiz_avg += classptr[counter].quiz_avg;;
		class_test_avg += classptr[counter].test_avg;
		class_grade_avg += classptr[counter].total_avg;

	}


	class_quiz_avg /= size;
	class_test_avg /= size;
	class_grade_avg /= size;

	
	cout << "Quiz Avg\t" << "Test Avg\t" << "Total Grade Avg\t" << endl;

	cout.setf(ios::showpoint);
	


	cout << setprecision(4) << endl << class_quiz_avg << "%   \t" << 
		    class_test_avg << "%   \t" << class_grade_avg << "%" << endl;



}
