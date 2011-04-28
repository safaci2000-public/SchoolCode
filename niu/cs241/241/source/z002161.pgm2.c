/***********************************************************************
	Program:		Assinment 2
	Author:		Samir Faci
	LogonID:		z002161
	Due Date:   09/27/2000

	Function:	prints a report containing a list of all students and their
					beginning of the semester status and their end of semester
					status.  data is read from a data file.

	Input:		none

	Output:		to screen

	Notes:		I like this one much better then the last prgm.  :)

***********************************************************************/


#include <stdio.h>

typedef enum {FALSE, TRUE} bool;

void clrscr();
/************************************************************************
Function:  controls the flow of the program
Argumetns: none
Returns:   int
Notes:     none
************************************************************************/


int main()
{
 bool primes[2001];
 bool psqrts[2001];        // check
 bool divby13[2001];
 bool fibon[2001];
 bool other[2001];
 int counter;					// variable used for for loop
 int counter2;					// variable used to calculate the fibon #s.
 int sum;						// varaible used to calcualte teh fibon #s.
 char ch;						// used to pause program.
 int track;
 int line;



 for (counter = 0; counter < 2001; counter++)
	{
	 primes[counter] = 0;
	 psqrts[counter] = 0;
	 divby13[counter] = 0;
	 fibon[counter] = 0;
	 other[counter] = 1;
	}




	/*      begin prime numbers                    */
 track = 0;
 for (counter = 3; counter < 2001; counter++)
	{

	 for (counter2 = 1; counter2 < 2001; counter2++)
		{
		 if (counter % counter2 != 0)
			track++;
		}
	 if (track == (counter2 - 3))
		{
		 primes[counter] = 1;
		 other[counter] = 0;
		}
	 else
		{
		 primes[counter] = 0;
		 other[counter] = 1;
		}
	 track = 0;
	}

/* code above checks for prime numbers.  and sets primes[number] to
	 if it is.  it also changes the value of other[number] to a 0.  */

 clrscr();
 printf("\nPrime Numbers:  \n\n");
 track = 0;
 line = 0;
 for (counter = 0; counter < 2001; counter++)
	{
	  if (primes[counter] ==  1)
		{
		 printf("%4d   ", counter);
		 track++;
		 if (track % 10 == 0)
			{
				printf("\n");
				line++;
			}
		 if (line == 16)
			{
				printf("\n\n Press Enter to view the Next Page");
				scanf("%c", &ch);
				clrscr();
				line = 0;
			}
		}
	}
	printf("\n\nPress enter to view next number series:  ");
	scanf("%c", &ch);

/* code above prints prime numbers            */

/*              end prime numbers             */


/*              begin perfect squares         */

 for (counter =1; counter <45; counter++)
	{
	 if ( (counter * counter) < 2001)
		{
			psqrts[counter* counter] = 1;
			other[counter * counter] = 0;
		}
	 else
		{
			psqrts[counter* counter] = 0;
			other [counter * counter] = 1;
		}

	}


	/*  code above calculate the perfect squares  */


 clrscr();
 printf("\nPerfect Squares:  \n\n");
 track = 0;
 for (counter = 0; counter < 2001; counter++)
	{
	  if (psqrts[counter] ==  1)
		{
		 printf("%4d   ", counter);
		 track++;
		 if (track % 10 == 0)
			printf("\n");
		}
	}
	printf("\n\n Press Enter to view the next number series:  ");
	scanf("%c", &ch);

	/* code above prints the calculated squares */



	/*            end perfect squares           */


	/*            begin #s divisible by 13      */


 for (counter = 13; counter <2001; counter++)
	{
		if (counter % 13 == 0)
			{
				divby13[counter] = 1;
				other[counter] = 1;
			}
		else
			divby13[counter] = 0;
	}

	/* code above calculates #s divisible by 13 */

 clrscr();
 printf("Numbers Divisible By 13:  \n\n");
 track = 0;
 for (counter = 0; counter < 2001; counter++)
	{

	  if (divby13[counter] ==  1)

		{
		 printf("%4d   ", counter);
		 track++;

		 if (track % 10 == 0)

			{
			 printf("\n");
			}

		}
	}
	printf("\n\n Press Enter the view the next number series:  ");
	scanf("%c", &ch);

	/* code above prints #s divisible by 13     */


	/* end numbers divisible by 13              */


	/*    begin fibonacci number sequence       */

 counter = 0;
 counter2 = 1;

 while (counter < 2001)
	{
	  sum = counter + counter2;
	  fibon[sum]= 1;
	  counter = counter2;
	  counter2= sum;
	}

	/* code above calculate the fabonacci number
		sequence											  */


 clrscr();
 printf("\nFabonacci Sequence:  \n\n");
 track = 0;
 for (counter = 0; counter < 2001; counter++)
	{
	  if (fibon[counter] ==  1)
		{
		 printf("%4d   ", counter);
		 track++;
		 if (track % 10 == 0)
			printf("\n");
		}
	}
	printf("\n\n Press enter to view the next number series:  ");
	scanf("%c", &ch);

	/* code above prints the fabo--whatever series */

	/*      end fabo.... series                    */

 clrscr();
 printf("\nOther:  \n\n");

 track = 0;
 line = 0;
 for (counter = 0; counter < 2001; counter++)
	{
	  if (other[counter] ==  1)
		{
		 printf("%4d   ", counter);
		 track++;
		 if (track % 10 == 0)
			{
				printf("\n");
				line++;
			}
		}
		 if (line == 16)
			{
				printf("\n\n Press Enter to view the Next Page");
				scanf("%c", &ch);
				clrscr();
				line = 0;
			}

	}
	printf("\n\n THE END!!!!  \n");
	printf("Thank you for using a product of the CS241 curriculum");
	scanf("%c", &ch);


 return 0;
}

/************************************************************************
Function:	clears the screen
Arguments:	none
notes:		none

**************************************************************************/
void clrscr()
{
 printf("%c[2J",27);
 fflush(stdout);

}
