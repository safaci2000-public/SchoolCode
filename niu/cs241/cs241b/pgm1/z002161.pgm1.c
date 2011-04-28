/***********************************************************************
	Program:	Assinment 1
	Author:		Samir Faci
	LogonID:	z002161
	Due Date:   06/29/2001

	Function:	prints a report containing a list of all students and their
				beginning of the semester status and their end of semester
				status.  data is read from a data file.

	Input:		.dat file from ~janorb/cs241/pgm/pgm1.dat

	Output:		a file called z002161.pgm1.out

	Notes:		both input/output are done through file redirection.

***********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CODE0 0					// value of code 0
#define CODE1 1					// value of code 1
#define CODE2 2					// value of code 2
#define STUDENT_PER_PAGE 10		// number of students to be printed per page.
#define PROFF_ARRAY_SIZE 6		// array size of proff struct array
#define MISC_TEACHER_ARRAY_SIZE 30 // array size of Misc teacher struct array
#define STUD_SUMMERY_PAGE_NUM 4	   // number of pages for the student report.
#define STUD_ARRAY_SIZE	50		   // array size of student struct array.
#define REFF_ARRAY_SIZE 100        // array size of reference struct array.

typedef struct
{
   int reference;		// teacher reference.
   char name[10];		// teacher name
   int points;			// accumulate points earned by all students
						// in the
					   // teacher's class.
   int credit;			// same as above only applies to class
						// credit.
   int students;		// keeps track of number of students
   double teacher_gpa;
}
prof_reference;			/* used to store 1st type of record read from
						   data file.  */


typedef struct
{
   long ss;				// social security of student.
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
   int reference;       // reference of teacher of one of the classes the student is taking.
   char status2[10];	// status of student after new grades are
						// included.

}
student;			/* used to store 2nd type of record read from
					   data file.  */

typedef struct
{
   int reference;		// teacher reference.
   int class_credit;	// class credit self-explanetory.
   char grade;			// grade earned by student.
   int points;			// stores the equivalent of the grade
						// obtained
						// by the student.
}
record;

typedef struct
{
	int reference;		// reference number of teacher
	int credit;			// number of credits earned by students
	int points;			// number of points earned by students
	double gpa;			// avg gpa of teacher.
	int students;       // keeps track of # of students this 
	                    // proffessors has.
} 
misc_teachers;			/*  structures that stores info of teachers
						 *  whose reference number isn't associated 
						 *  with a name
						 */



void proffessor_function (FILE *,prof_reference[], int *);
void student_function (FILE *, student[], int *);
void record_function (FILE *, record[], int *);
int grade (char);
void GetStatus (student [], int *);
void GetNewStatus (student[], int *, int[], int[]);
int calcGPA (student[], int *);
void PrintStudentOutput (student[], int *);
void PrintTeacherOutput (prof_reference[], int *);
void teacherGPA (record[], prof_reference[], int *, misc_teachers[]);
void PrintStudentSummery (int[], int, student[], int *, int []);
void PrintMiscTeachers   (misc_teachers[]);

/**************************************************************************
Function:	int main();
Arguments:	none
Returns:	integer
Notes:		control the flow of the program.
**************************************************************************/

int main ()
{
   int code = 0;
   prof_reference proff[PROFF_ARRAY_SIZE];	/* see structure doc for info */
   student stud[STUD_ARRAY_SIZE];
   record reff[REFF_ARRAY_SIZE ];
   misc_teachers teacher[MISC_TEACHER_ARRAY_SIZE];

   FILE *input_file;				// pointer to input file.
   int num_of_prof      = 0;        // number of proffessors 
					// associated with a name
   int status[4] = { 0, 0, 0, 0 };	// used to store # of fresh,
									// soph..etc.
   int improved[4] =  {0,0,0,0};    // keeps track of # of fresh,
                                    // soph, junior..etc that improved.
   int total_students;				// used to store total # of students.
   int counter;						// used to in for loop to initialize
									// structures.
   int track = 0;					// keeps track of the which member of the
									// structure
									// array we're dealing with.
   int trackStudent = 0,			// keeps track of array element in the
									// student struct.
     trackRecord = 0;				// keeps track of array element in the
									// record struct.
   input_file = fopen ("pgm1.dat", "r");

   if (input_file == NULL) {
      printf ("input file failed to open!!!\n");
      exit (0);
   }


   fscanf (input_file, "%d", &code);			// scans in 1st code.



   for (counter = 0; counter < PROFF_ARRAY_SIZE; counter++) {
      proff[counter].points = 0;	// initialises some elements of the proffessor
      proff[counter].credit = 0;	// struct.
      proff[counter].students = 0;
   }

	for (counter = 0; counter < MISC_TEACHER_ARRAY_SIZE; counter++)
		{
			teacher[counter].reference = 0;		// initializes some elements of the
			teacher[counter].points = 0;		// misc_teachers struct.
			teacher[counter].credit = 0;
			teacher[counter].gpa = 0.0;
			teacher[counter].students = 0;
		}
			
   
   while (code == CODE0) 
  {
      proffessor_function (input_file ,proff, &track);
      fscanf (input_file, "%d", &code);
      track++;
   }

   /*  code above reads in the proffessor data */
   

   
   while (!feof(input_file) && code == CODE1) 
   {
      student_function (input_file ,stud, &trackStudent);		// reads in the student data.


      stud[trackStudent].oldgpa = ((double) stud[trackStudent].points /
				   (double) stud[trackStudent].credit);

			/* code above calculates student gpa based on older credits 
			 * and points
			 */


      stud[trackStudent].newPoints = 0;		// statment initializes newPoints/Credits
      stud[trackStudent].newCredit = 0;

	  
	  GetStatus (stud, &trackStudent);

	  /*  Determine's student grade level  */

	  fscanf (input_file ,"%d", &code);					// scans in the next code.

      trackStudent++;						// increments the number of students by one.

      
	  while (!feof(input_file) && code == CODE2)  
		{

		 record_function (input_file ,reff, &trackRecord);	// reads in the reference record.

		 reff[trackRecord].points = grade (reff[trackRecord].grade);

			/*  gets the equivalent number of points earned for the class
			 *  by converting a letter grade to points
			 */


		 stud[trackStudent - 1].newPoints += (reff[trackRecord].points * reff[trackRecord].class_credit);
		 stud[trackStudent - 1].newCredit += reff[trackRecord].class_credit;

			/* two statments above tally up the new points and new credits earned */

		 teacherGPA (reff, proff, &trackRecord, teacher);	// calculates teacher GPA.
		 

		 fscanf (input_file , "%d", &code);				// reads in next code.

		 if (code == CODE1) 
		 {
		    stud[trackStudent - 1].change = calcGPA (stud, &trackStudent);

				/* code above checks to see if student gpa increased or
				 * decreased
				 */

			GetNewStatus (stud, &trackStudent, status, improved);
				/* gets students new status once all grades have been added */
		 }   
	 trackRecord++;		// increments the record number.
	}
  }
   

     stud[trackStudent - 1].change = calcGPA (stud, &trackStudent);
     GetNewStatus(stud, &trackStudent, status, improved);

	 /*  code above fixes discrepenscies not caught by above loops */
   

   
   track = 1;
   for (counter = 0; counter < trackStudent; counter++) {
      if (counter % STUDENT_PER_PAGE == 0) {
	 printf ("\n");
	 printf ("                STUDENT STATUS REPORT               PAGE %d\n\n",
		  track);
	 printf (
		  "SSN            GRADE LEVEL     CR    PTS     GPA   DECREASED\n\n");
	 track++;			// increment page number
      }

      /* Prints student status report */

      PrintStudentOutput (stud, &counter);
   }

   total_students = status[0] + status[1] + status[2] + status[3];
   printf ("\f\n");
   printf (
	    "                STUDENT SUMMERY                   PAGE %d\n",
	    track);

   printf("\n\n\tTOTAL STUDENTS: \t %d\n\n", total_students);   
   printf ("STATUS:         TOTAL      PERCENT     IMPROVED\n\n");
   track++;			// increment page number




   for (counter = 0; counter < STUD_SUMMERY_PAGE_NUM; counter++)
      PrintStudentSummery (status, total_students, stud, &counter, improved);

   /* prints student summery report */

   printf ("\f\n");
   printf (
	    "                PROFFESSOR REPORT                 PAGE %d\n",
	    track);
   printf ("NAME:         TOTAL STUDENTS        AVG. GPA\n\n");
   track++;			// increment page number

   /* prints Proffessor Report */


   for (counter = 0; counter < PROFF_ARRAY_SIZE; counter++) {
      PrintTeacherOutput (proff, &counter);
   }
   printf("\n\n NOTES:  \n");

   printf("\f\n");
   printf (
	    "              MISC PROFFESSORS REPORT             PAGE %d\n",
	    track);
   printf ("Ref. #:         TOTAL STUDENTS        AVG. GPA\n\n");

   track++;			// increment page number

   PrintMiscTeachers(teacher);

   return 1;
}

/**************************************************************************
Function:	void proffessor_function();
Arguments:	 FILE *, integer, prof_reference []
Returns:	none but modifies 2 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void
proffessor_function (FILE *input_file, prof_reference proff[], int *counter)
{
   fscanf (input_file , "%d", &proff[*counter].reference);
   fscanf (input_file ,"%s", proff[*counter].name);
}

/**************************************************************************
Function:	void student_function();
Arguments:	FILE *, student [], int *
Returns:	none but modifies 3 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void
student_function (FILE *input_file ,student stud[], int *counter)
{
   fscanf (input_file ,"%ld", &stud[*counter].ss);
   fscanf (input_file ,"%d", &stud[*counter].credit);
   fscanf (input_file ,"%d", &stud[*counter].points);

}

/**************************************************************************
Function:	void record_function()
Arguments:	FILE *, int, record []
Returns:	none but modifies 3 object of a struct using pointers.
Notes:		reads data from file and store 'em to variables.
**************************************************************************/
void
record_function (FILE *input_file ,record reff[], int *counter)
{
   fscanf (input_file ,"%d", &reff[*counter].reference);
   fscanf (input_file ,"%d", &reff[*counter].class_credit);
   fscanf (input_file ,"%c", &reff[*counter].grade);
   while (reff[*counter].grade == ' ') {
      fscanf (input_file , "%c", &reff[*counter].grade);
   }
   /* reading of file is weird...above code just make sures it didn't get a
      null character or a space  */
}

/**************************************************************************
Function:	matches a letter grade with a numberic value.
Arguments:	char grade
Returns:	an integer...the numeric value of the letter grade.
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
Arguments:	student [], int *
Returns:		none
Notes:		NA
**************************************************************************/
void
GetStatus (student stud[], int *counter)
{
   if (stud[*counter].credit > 0
       && stud[*counter].credit <= 30) {
      strcpy (stud[*counter].status, "Freshman");
   }
      else if (stud[*counter].credit > 30
	       && stud[*counter].credit <= 60) {
      strcpy (stud[*counter].status, "Sophomore");
   }
      else if (stud[*counter].credit > 60
	       && stud[*counter].credit <= 90) {
      strcpy (stud[*counter].status, "Junior");
   } else {
      strcpy (stud[*counter].status, "Senior");
   }



}


/**************************************************************************
Function:	Gets the Status of a student based on his credits.
			mathes his credit to a fresh., soph., junior, or senior.
Arguments:	student [], int *, int [], int []
Returns:	none
Notes:		NA
**************************************************************************/
void
GetNewStatus (student stud[], int *counter, int status[], int improved[])
{
   if (stud[(*counter) - 1].newCredit > 0
       && stud[(*counter) - 1].newCredit <= 30) {
      strcpy (stud[(*counter) - 1].status2, "Freshman");
      status[0]++;
	  if (stud[(*counter) - 1].change != 1)
		  improved[0]++;
   }
      else if (stud[(*counter) - 1].newCredit > 30
	       && stud[(*counter) - 1].newCredit <= 60) {
      strcpy (stud[(*counter) - 1].status2, "Sophomore");
      status[1]++;
	  if (stud[(*counter) - 1].change != 1)
		  improved[1]++;
   }
      else if (stud[(*counter) - 1].newCredit > 60
	       && stud[(*counter) - 1].newCredit <= 90) {
      strcpy (stud[(*counter) - 1].status2, "Junior");
      status[2]++;
	  if (stud[(*counter) - 1].change != 1)
		  improved[2]++;

   } else {
      strcpy (stud[(*counter) - 1].status2, "Senior");
      status[3]++;
	  if (stud[(*counter) - 1].change != 1)
		  improved[3]++;

   }



}


/**************************************************************************
Function:	calculate the students new gpa and returns a 1 or 0 depending
			on whether the student improved his grades or not compared to
			his previous semester.
Arguments:	student [], int *
Returns:	none
Notes:		NA
**************************************************************************/
int
calcGPA (student stud[], int *trackStudent)
{
   stud[(*trackStudent) - 1].newPoints += stud[(*trackStudent) - 1].points;
   stud[(*trackStudent) - 1].newCredit += stud[(*trackStudent) - 1].credit;

   stud[(*trackStudent) - 1].newgpa =
      ((double) stud[(*trackStudent) - 1].newPoints /
       (double) stud[(*trackStudent) - 1].newCredit);
   if (stud[(*trackStudent) - 1].newgpa > stud[(*trackStudent) - 1].oldgpa) {
      return 0;
   }
   if (stud[(*trackStudent) - 1].newgpa < stud[(*trackStudent) - 1].oldgpa) {
      return 1;
   }
   return (0);
}

/**************************************************************************
Function:	prints the student report to a file.
Arguments:	student [], int*
Returns:	none
Notes:		NA
**************************************************************************/
void
PrintStudentOutput (student stud[], int *counter)
{
   printf ("%ld\t%-10s    %3d    %3d    %5.2f\n", 
stud[*counter].ss,
	    stud[*counter].status, stud[*counter].credit,
	    stud[*counter].points, stud[*counter].oldgpa);
   printf ("%ld\t%-10s    %3d    %3d    %5.2f   ", 
stud[*counter].ss,
	    stud[*counter].status2, stud[*counter].newCredit,
	    stud[*counter].newPoints, stud[*counter].newgpa);


   if (stud[*counter].change == 1)

      printf (" ^^^^^^\n\n");
   else
      printf ("\n\n");
}

/**************************************************************************
Function:	gets data to calculate the teacher gpa;
Arguments:	student [], record_reff [], int *, int []
Returns:	none
Notes:		NA
**************************************************************************/
void
teacherGPA (record reff[], prof_reference proff[], int *counter, misc_teachers teacher[])
{
	int teacher_count;		// variable that loops throught the 6 proffessors.
	int flag = 0;			// flag changed to 1 if teacher is associated w/ a name.
	int went_through_while_loop = 0;	// changed to 1 if misc_teacher was already
										// read in @ least once already.
	


	for (teacher_count = 0; teacher_count <= 5; teacher_count++)
	{
	
		if (proff[teacher_count].reference == reff[(*counter)].reference) 
		{
	      proff[teacher_count].points += (reff[(*counter)].points * reff[(*counter)].class_credit);
	      proff[teacher_count].credit += reff[(*counter)].class_credit;
	      proff[teacher_count].students++;
		  flag = 1;	      
		}
	}


    teacher_count = 0;

	if (flag == 0)
	{
		while ( teacher[teacher_count].reference != 0)
		{
			if (teacher[teacher_count].reference == reff[(*counter)].reference )
			{
		      teacher[teacher_count].points += (reff[(*counter)].points * reff[(*counter)].class_credit);
		      teacher[teacher_count].credit += reff[(*counter)].class_credit;
		      teacher[teacher_count].students++;
			  went_through_while_loop++;
			}

		  teacher_count++;

		}

	  if (went_through_while_loop == 0 )          // checks this...this code doesn't work.
		  {
		  teacher[teacher_count].reference = reff[(*counter) ].reference;
		  teacher[teacher_count].points += (reff[(*counter)].points * reff[(*counter)].class_credit);
	      teacher[teacher_count].credit += reff[(*counter)].class_credit;
	      teacher[teacher_count].students++;
		  }
	}		
    
    
}

/**************************************************************************
Function:	prints the teacher report to a file.
Arguments:	prof_reference [], int *
Returns:	none
Notes:		NA
**************************************************************************/
void
PrintTeacherOutput (prof_reference proff[], int *counter)
{
   proff[*counter].teacher_gpa = (double) proff[*counter].points /
      (double) proff[*counter].credit;
   printf ("%-10s \t\t%2d \t\t%5.2f \n", proff[*counter].name,
	    proff[*counter].students, proff[*counter].teacher_gpa);

}


/**************************************************************************
Function:	prints the teacher that aren't associated with a name to a file
Arguments:	misc_teachers []
Returns:	none
Notes:		NA
**************************************************************************/
void PrintMiscTeachers   (misc_teachers teacher[])
{
	int counter = 0;

	while (teacher[counter].reference != 0)
	{
		teacher[counter].gpa = (double) teacher[counter].points /
	      (double) teacher[counter].credit;
	   printf ("%d    \t\t%2d \t\t%5.2f \n", teacher[counter].reference,
		    teacher[counter].students, teacher[counter].gpa);
	   counter++;
	}

}


/**************************************************************************
Function:	prints the teacher report to a file.
Arguments:	prof_reference [], int, int
Returns:	none
Notes:		NA
**************************************************************************/
void
PrintStudentSummery (int status[], int total_students,
		     student stud[], int *counter, int improved[])
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

   printf ("%-10s \t %3d \t   %5.0f \t %d\n", rank, 
status[*counter],
	    (( (double) status[*counter] / (double) total_students ) * 
100), improved[*counter]);
}
