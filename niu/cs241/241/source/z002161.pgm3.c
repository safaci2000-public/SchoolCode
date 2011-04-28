/***********************************************************************
	Program:		Assinment 3
	Author:		Samir Faci
	LogonID:		z002161
	Due Date:   10/04/2000

	Function:	Program converts a gregorian date to a julian date.
					it also checks for valid input from the end user.

	Input:		user input.

	Output:		to screen

	Notes:		fun program...actually enjoyed writting it.
					also...i've been told of an interesting program ...
					could be an interesting class assign.
					basic arithmetic program...addition, substraction...etc.
					using Roman Numberals.  just a thought  
	Additional Note:  i've stoped by the TA offices and asked how the
			  program was supposed to be run and I was told it 
			  should be set as an infinite loop w/h is why it
			  has that infinite loop in there.  if i wasn't 
 			  supposed to do that..well sorry..just listening
			  to the TAs

***********************************************************************/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

typedef enum {FALSE, TRUE} bool;

void clrscr();
int intro();
bool error(int *, int *, char []);
void Julian_Greg(int *);
void greg_Julian(char []);


/************************************************************************
Function:  controls the flow of the program
Argumetns: none
Returns:   int
Notes:     none
************************************************************************/


int main()
{
 int choice;      // choice entered by the user (1 or 2)
 char ch,  			// variable used to pause the program.
		greg[10];	// stores the date entered by the user in Gregorian Calen.
 int julian = 0;	// stores the julian date
 bool test;			// a bool w/h tests if result if valid
 while (!EOF)
 {
 choice = intro(); // prints intro
 test = error(&choice, &julian, greg);

 while (test == 0)
	{

	 printf("\nError!!!!!!!!!!!.....enter a valid choice please...1 or 2 only\n");
	 choice = intro();
	 test = error(&choice, &julian, greg);

	}

 }
 return 0;
}

/************************************************************************
Function:	clears the screen
Arguments:	none
Returns:		none
notes:		none
**************************************************************************/
  void clrscr()
{
 printf("%c[2J",27);
 fflush(stdout);  

}   

/************************************************************************
Function:	prints an intro and asks for an input.
Arguments:	none
Returns:		integer.
notes:		none

**************************************************************************/
int intro()
{
 int choice;
 clrscr();
 printf("Please choose the type of conversion you would like to do.  \n\n\n");
 printf("\t 1.)  Julian date to a Gregorian Date\n");
 printf("\t 2.)  Gregorian to Julian\n");
 printf("\n\n\n\t\t Enter your choice ==>   ");
 scanf("%d", &choice);
 return choice;
}
/************************************************************************
Function:	converts a julian date into a Gregarian date.
Arguments:	int
Returns:		char []
notes:		none

**************************************************************************/
void Julian_Greg(int *julian)
{
 int month = 0,	// stores the month of the Gregorian Calendar.
	  day = 0;		// stores the day equivalent of the Gregorian Calendar.


 if (*julian > 0 && *julian <= 31)
	 {
	  month = 1;
	  day = *julian;
	 }
 else if (*julian > 31 && *julian <=50)
	{
	 month = 2;
	 day = *julian - 31;
	}
 else if (*julian > 60 && *julian <= 91)
	{
	 month = 3;
	 day = *julian - 60;
	}
 else if (*julian > 91 && *julian <= 121)
	{
	 month = 4;
	 day = *julian - 91;
	}
 else if (*julian > 121 && *julian <= 152)
	{
	 month = 5;
	 day = *julian - 121;
	}
 else if (*julian > 152 && *julian <= 182)
	{
	 month = 6;
	 day = *julian - 152;
	}
 else if (*julian > 182 && *julian <= 213)
	{
	 month = 7;
	 day = *julian - 182;
	}
 else if (*julian > 213 && *julian <= 244)
	{
	 month = 8;
	 day = *julian - 213;
	}
 else if (*julian > 244 && *julian <= 274)
	{
	 month = 9;
	 day = *julian - 244;
	}
 else if (*julian > 274 && *julian <= 305)
	{
	 month = 10;
	 day = *julian - 274;
	}
 else if (*julian > 305 && *julian <= 335)
	{
	 month = 11;
	 day = *julian - 305;
	}
 else if (*julian > 335 && *julian <= 366)
	{
	 month = 12;
	 day = *julian - 335;
	}
 /*  code above calculates the w/h gregorian month corresponds to the
	  Julian year.  It also establishes the day number of the gregorian
	  Calendar.  */

 else if (*julian < 0 || *julian > 366)
	{
	 printf("\nError!!!!!!!!!!!!!!  Enter a valid input!!!\n");
	}

 /* code above checks for a valid input from End User.  if it's invalid
	 it prints an error msg.  */

 if (*julian > 0 && *julian <= 366)
	printf("\n\nThe Equivalent of %d of the Julian Calendar is:  %02d/%02d/00\n",
	*julian, month, day);

 /* code above prints output in a formated user-friendly manner.  */

}
/************************************************************************
Function:	Converts a Gregarian Date into a Julian date.
Arguments:	char array
Returns:		none
notes:		none
**************************************************************************/
void greg_Julian(char greg[])
{
 int counter;			// used in for loop
 int month=0,			// stores the month entered.
	  day=0,				// stores the day entered.
	  error_day= 0,	// set to 2 if invalid input is entered.
	  error_month = 0,// set to 2 if invalid..input is entred.
	  caesar;			// stores the julian calendar date.

 char dayString[2];
 char monthString[2];

 
 monthString[0] = greg[0];
 monthString[1] = greg[1];
 monthString[2] = '\0';
 dayString[0] = greg[3];
 dayString[1] = greg[4];
 dayString[2] = '\0';


for (counter = 0; counter <2; counter++)
	{
	 error_day = isdigit(dayString[counter]);
	 error_month = isdigit(monthString[counter]);
	 if (error_day == 0 || error_month == 0)
		{
		 printf("Error!!!  Invalid Input entered!");
		 break;
		}
	}
  
 
  if (error_day !=0 && error_month != 0)
	{
	 month = atoi(monthString);
         day = atoi(dayString); 
	 switch (month)
		{
		 case 1:	 caesar = day;  break;
		 case 2:  caesar = 31 + day; break;
		 case 3:  caesar = 60 + day; break;
		 case 4:  caesar = 91 + day; break;
		 case 5:  caesar = 121 + day; break;
		 case 6:  caesar = 152 + day; break;
		 case 7:  caesar = 182 + day; break;
		 case 8:  caesar = 213 + day; break;
		 case 9:  caesar = 244 + day; break;
		 case 10: caesar = 274 + day; break;
		 case 11: caesar = 305 + day; break;
		 case 12: caesar = 335 + day; break;
		 default:  printf("Error!!  fix it"); break;
		}

	 printf("\n\nThe Julian equivalent of the Gregorian Date %s is:
%d
\n", greg, caesar);

	}  
}
/************************************************************************
Function:	Error checks the 1st input.
Arguments:	int.
Returns:		bool
notes:		none

**************************************************************************/


bool error(int *choice, int *julian, char greg[])
{

 if (*choice == 1)
	{
	 printf("\nPlease enter the Julian Year ==>  ");
	 *julian = 0;
	 scanf("%d", &(*julian));
	 Julian_Greg(&(*julian));
	 return 1;

	}
 else if (*choice == 2)
	{

	 printf("\nPlease enter the Gregarian Year ==>  ");
	 strcpy(greg, "Error!!!!");
	 scanf("%s", greg);
    greg_Julian(greg);
	 return 1;
	}
 else
	return 0;
}
