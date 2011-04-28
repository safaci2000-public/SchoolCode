/***********************************************************************
	Program:	Assinment 1
	Author:		Samir Faci
	LogonID:	z002161
	Due Date:   09/20/2000

	Function:	prints a report containing a list of all students and their
				beginning of the semester status and their end of semester
				status.  data is read from a data file.

	Input:		.dat file from ~janorb/cs241/pgm/pgm1.dat

	Output:		a file called z0021611.out

	Notes:		it's been a while since i've done C, so please excuse the
				roughness of the code.

	Additional
	Note:		okay...this program is a bad 1st program.  Should have started
				earlier plus it's acting really weird.  stud[0].status
				and stud[0].status2 are both storing the same value...
				when i change one the other changes as well.  not to mention
				that fprintf() doesn't wanna skip over blank spaces...etc.
				program has too many fail safe's for comfort.

				again...sorry about this program...it's not exactly the way
				i wanted to start off in this class.

				anyways...your patience is appreciated.

				Samir F.

***********************************************************************/

#include <stdio.h>
#include <string.h>

typedef struct
{
   int reference;		// teacher reference.
   char name[10];		// teacher name
   int points;			// accumulate points earned by all students
				// in the
   // teacher's class.
   int credit;			// same as above only applies to class
				// credit.
   double teacher_gpa;		// teacher gpa calculated based on student's
				// grades.
   int students;		// number of students taking a class from
				// this teacher.
}
prof_reference;			/* used to store 1st type of record read from
				   data file.  */

typedef struct
{
   long ss;			// social security of student.
   int credit;			// accumulative credit earned by student from
   // previous year.
   int newCredit;		// accumulative credit earned by student from
   // last year and this year.
   int points;			// points...last year.
   int newPoints;		// points ..last year..and this year.
   double oldgpa;		// points divided by credit
   double newgpa;		// newpoints/ new credit.
   int change;			// positive or negative change in gpa
   char status[10];		// status of student...fresh, soph...etc
   char status2[10];		// status of student after new grades are
				// included.
}
student;			/* used to store 2nd type of record read from
				   data file.  */

typedef struct
{
   int reference;		// teacher reference.
   int class_credit;		// class credit self-explanetory.
   char grade;			// grade earned by student.
   int points;			// stores the equivalent of the grade
				// obtained
   // by the student.
}
record;

//void clrscr();
void proffessor_function (prof_reference[], FILE *, int *);
void student_function (student[], FILE *, int *);
void record_function (record[], FILE *, int *);
int grade (char);
void GetStatus (student[], int *, int[]);
int calcGPA (student[], int *);
void PrintStudentOutput (FILE *, student[], int *);
void PrintTeacherOutput (FILE *, prof_reference[], int *);
void teacherGPA (record[], prof_reference[], int *);
void PrintStudentSummery (FILE *, int[], int, student[], int *);

/**************************************************************************
Function:	int main();
Arguments:	none
Returns:		integer...don't know why yet.
Notes:		control the flow of the program.
**************************************************************************/

int
main ()
{
   int code = 0;
   prof_reference proff[6];	/* see structure doc for info */
   student stud[50];
   record reff[100];
   char ch;			/* used to pause program */
   int status[4] = { 0, 0, 0, 0 };	// used to store # of fresh,
					// soph..etc.
   int total_students;		// used to store total # of students.
   int counter;			// used to in for loop to initialize
				// structures.
   int track = 0;		// keeps track of the which member of the
				// structure
   // array we're dealing with.
   int trackStudent = 0,	// keeps track of array element in the
      // student struct.
     trackRecord = 0;		// keeps track of array element in the
   // record struct.

   FILE *f;			// pointer to input file
   FILE *out;			// pointer to output file
//   clrscr ();
   printf
      ("this program will read data from a file.  then store the data read\n");
   printf
      ("in structures.  It will then arrange the data accordingly and store\n");
   printf
      ("them in an output file.  The output file will contain 3 reports.\n\n");
   printf
      ("the Student Status Report, The Student Summery, and the Proffessor\n");
   printf ("report.  \n");
   printf
      ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n       Press enter to continue");
   scanf ("%c", &ch);
//   clrscr ();
   printf ("reading data file...please wait!!\n\f");
//   clrscr ();

   f = fopen ("pgm1.dat", "r");
   out = fopen ("pgm1.out", "w");
   if (f == NULL) {
      printf ("input file failed to open!!!\n");
      exit (0);
   }
   if (out == NULL) {
      printf ("input file failed to open!!!\n");
      exit (0);
   }

   fscanf (f, "%d", &code);	// scans in 1st code.
   for (counter = 0; counter < 6; counter++) {
      proff[counter].points = 0;	/* initialises some elements of some */
      proff[counter].credit = 0;	// structs.
      proff[counter].students = 0;
   }

   while (code == 0) {
      proffessor_function (proff, f, &track);
      fscanf (f, "%d", &code);
      track++;
   }
   while (!feof (f)) {
      student_function (stud, f, &trackStudent);
      stud[trackStudent].oldgpa = ((double) stud[trackStudent].points /
				   (double) stud[trackStudent].credit);
      stud[trackStudent].newPoints = 0;
      stud[trackStudent].newCredit = 0;
      fscanf (f, "%d", &code);
      trackStudent++;
      if (trackStudent > 70)
	 break;			// fail safe.
      while (code == 2) {
	 record_function (reff, f, &trackRecord);
	 teacherGPA (reff, proff, &trackStudent);	// self-explanetory.
	 reff[trackRecord].points = grade (reff[trackRecord].grade);
	 stud[trackStudent - 1].newPoints += reff[trackRecord].points;
	 stud[trackStudent - 1].newCredit += reff[trackRecord].class_credit;
	 fscanf (f, "%d", &code);
	 if (code == 1) {
	    stud[trackStudent - 1].change = calcGPA (stud, &trackStudent);
	    GetStatus (stud, &trackStudent, status);
	 }
	 trackRecord++;
	 if (trackRecord > 70)
	    break;
      }
   }
   track = 1;
   for (counter = 0; counter < 28; counter++) {
      if (counter % 10 == 0) {
	 fprintf (out, "\f\n");
	 fprintf (out,
		  "                STUDENT STATUS REPORT             PAGE %d\n",
		  track);
	 fprintf (out,
		  "SSN         GRADE LEVEL     CREDIT    POINTS     GPA     DECREASED\n");
	 track++;
      }

      /* Prints student status report */

      PrintStudentOutput (out, stud, &counter);
   }

   total_students = status[0] + status[1] + status[2] + status[3];
   fprintf (out, "\f\n");
   fprintf (out,
	    "                STUDENT SUMMERY                   PAGE %d\n",
	    track);
   fprintf (out, "STATUS:         TOTAL      PERCENT     IMPROVED\n");
   track++;
   for (counter = 0; counter < 5; counter++)
      PrintStudentSummery (out, status, total_students, stud, &counter);

   /* prints student summery report */

   fprintf (out, "\f\n");
   fprintf (out,
	    "                PROFFESSOR REPORT                 PAGE %d\n",
	    track);
   fprintf (out, "NAME:         TOTAL STUDENTS        AVG. GPA\n");
   track++;

   /* prints Proffessor Report */
   for (counter = 0; counter < 6; counter++) {
      PrintTeacherOutput (out, proff, &counter);
   }

   scanf ("%c", &ch);
   return 1;
}

/**************************************************************************
Function:	clears the screen
Arguments:	none
Returns:		none
Notes:		replaces the clrscr() function from the conio.h library.
**************************************************************************/
/*
void clrscr()
{
 printf("\f\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
}
  */

/**************************************************************************
Function:	void proffessor_function();
Arguments:	integer, char []
Returns:		none but modifies 2 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void
proffessor_function (prof_reference proff[], FILE * f, int *counter)
{
   fscanf (f, "%d", &proff[*counter].reference);
   fscanf (f, "%s", proff[*counter].name);
}

/**************************************************************************
Function:	void student_function();
Arguments:	long int, int, int
Returns:		none but modifies 3 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void
student_function (student stud[], FILE * f, int *counter)
{
   fscanf (f, "%ld", &stud[*counter].ss);
   fscanf (f, "%d", &stud[*counter].credit);
   fscanf (f, "%d", &stud[*counter].points);
}

/**************************************************************************
Function:	void record_function()
Arguments:	int, int, char
Returns:		none but modifies 3 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void
record_function (record reff[], FILE * f, int *counter)
{
   fscanf (f, "%d", &reff[*counter].reference);
   fscanf (f, "%d", &reff[*counter].class_credit);
   fscanf (f, "%c", &reff[*counter].grade);
   while (reff[*counter].grade == ' ') {
      fscanf (f, "%c", &reff[*counter].grade);
   }
   /* reading of file is weird...above code just make sures it didn't get a
      null character   */
}

/**************************************************************************
Function:	matches a letter grade with a numberic value.
Arguments:	char grade
Returns:		an integer...the numeric value of the letter grade.
Notes:		NA
**************************************************************************/
int
grade (char grade)
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
Function:	Gets the Status of a student based on his credits.
				mathes his credit to a fresh., soph., junior, or senior.
Arguments:	student [], int
Returns:		none
Notes:		NA
**************************************************************************/
void
GetStatus (student stud[], int *counter, int status[])
{
   if (stud[(*counter) - 1].newCredit > 0
       && stud[(*counter) - 1].newCredit <= 30) {
      strcpy (stud[(*counter) - 1].status2, "Freshman");
      status[0]++;
   }
      else if (stud[(*counter) - 1].newCredit > 30
	       && stud[(*counter) - 1].newCredit <= 60) {
      strcpy (stud[(*counter) - 1].status2, "Sophomore");
      status[1]++;
   }
      else if (stud[(*counter) - 1].newCredit > 60
	       && stud[(*counter) - 1].newCredit <= 90) {
      strcpy (stud[(*counter) - 1].status2, "Junior");
      status[2]++;
   } else {
      strcpy (stud[(*counter) - 1].status2, "Senior");
      status[3]++;
   }

   if (stud[(*counter) - 1].credit > 0 && stud[(*counter) - 1].credit <= 30)
      strcpy (stud[(*counter) - 1].status, "Freshman");
   else if (stud[(*counter) - 1].credit > 30
	    && stud[(*counter) - 1].credit <=
	    60) strcpy (stud[(*counter) - 1].status, "Sophomore");
   else if (stud[(*counter) - 1].credit > 60
	    && stud[(*counter) - 1].credit <=
	    90) strcpy (stud[(*counter) - 1].status, "Junior");
   else
      strcpy (stud[(*counter) - 1].status, "Senior");

}

/**************************************************************************
Function:	calculate the students new gpa and returns a 1 or 0 depending
				on whether the student improved his grades or not compared to
				his previous semester.
Arguments:	student [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
int
calcGPA (student stud[], int *trackStudent)
{
   stud[*trackStudent - 1].newPoints += stud[*trackStudent - 1].points;
   stud[*trackStudent - 1].newCredit += stud[*trackStudent - 1].credit;

   stud[*trackStudent - 1].newgpa =
      ((double) stud[*trackStudent - 1].newPoints /
       (double) stud[*trackStudent - 1].newCredit);
   if (stud[*trackStudent - 1].newgpa > stud[*trackStudent - 1].oldgpa) {
      return 0;
   }
   if (stud[*trackStudent - 1].newgpa < stud[*trackStudent - 1].oldgpa) {
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
void
PrintStudentOutput (FILE * out, student stud[], int *counter)
{
   fprintf (out, "%ld\t  %s\t     %d\t     %d\t  %5.2f\n", stud[*counter].ss,
	    stud[*counter].status, stud[*counter].credit,
	    stud[*counter].points, stud[*counter].oldgpa);
   fprintf (out, "%ld\t  %s\t     %d\t     %d\t  %5.2f\t", stud[*counter].ss,
	    stud[*counter].status, stud[*counter].newCredit,
	    stud[*counter].newPoints, stud[*counter].newgpa);
   if (stud[*counter].change == 1)

      fprintf (out, "\tYES\n\n");
   else
      fprintf (out, "\n");
}

/**************************************************************************
Function:	gets data to calculate the teacher gpa;
Arguments:	student [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
void
teacherGPA (record reff[], prof_reference proff[], int *counter)
{
   if (proff[0].reference == reff[*counter].reference) {
      proff[0].points += reff[*counter].points;
      proff[0].credit += reff[*counter].class_credit;
      proff[0].students++;
   }

   else if (proff[1].reference == reff[*counter].reference) {
      proff[1].points += reff[*counter].points;
      proff[1].credit += reff[*counter].class_credit;
      proff[1].students++;
   } else if (proff[2].reference == reff[*counter].reference) {
      proff[2].points += reff[*counter].points;
      proff[2].credit += reff[*counter].class_credit;
      proff[2].students++;
   }

   else if (proff[3].reference == reff[*counter].reference) {
      proff[3].points += reff[*counter].points;
      proff[3].credit += reff[*counter].class_credit;
      proff[3].students++;
   }

   else if (proff[4].reference == reff[*counter].reference) {
      proff[4].points += reff[*counter].points;
      proff[4].credit += reff[*counter].class_credit;
      proff[4].students++;
   } else if (proff[5].reference == reff[*counter].reference) {
      proff[5].points += reff[*counter].points;
      proff[5].credit += reff[*counter].class_credit;
      proff[5].students++;
   }
}

/**************************************************************************
Function:	prints the teacher report to a file.
Arguments:	prof_reference [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
void
PrintTeacherOutput (FILE * out, prof_reference proff[], int *counter)
{
   proff[*counter].teacher_gpa = (double) proff[*counter].points /
      (double) proff[*counter].credit;
   fprintf (out, "%s\t\t\t\t  %d\t\t\t\t\t %5.2f\n", proff[*counter].name,
	    proff[*counter].students, proff[*counter].teacher_gpa);

}

/**************************************************************************
Function:	prints the teacher report to a file.
Arguments:	prof_reference [], int, int
Returns:		none
Notes:		NA
**************************************************************************/
void
PrintStudentSummery (FILE * out, int status[], int total_students,
		     student stud[], int *counter)
{
   char rank[10];		// variable used to store rank of student.
   if (*counter == 0)
      strcpy (rank, "Freshman");
   else if (*counter == 1)
      strcpy (rank, "Sophmore");
   else if (*counter == 2)
      strcpy (rank, "Junior");
   else
      strcpy (rank, "Senior");
   fprintf (out, "%s \t %d \t %d \t Yes\n", rank, status[*counter],
	    (total_students / status[*counter]));
}
