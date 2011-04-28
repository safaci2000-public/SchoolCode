/***********************************************************************
	Program:	Assinment 2
	Author:		Samir Faci
	LogonID:	z002161
	Due Date:   07/06/2001

	Function:	To categorize the integers from 1 to 3000 according to 
				the following criteria:  PRIMES, PSQRTS, DIVBY13,
				FACT (factorial), FIBON, OTHER.

	Input:		none, every number between 1 and 3000 is used a data
				but no user input is required.

	Output:		to screen

	Notes:		NA

***********************************************************************/


#include <stdio.h>

#define SQRT_OF_NUM_INTS 55		// the square root of 3000.
#define NUMBER_OF_INTS 3001		// the number of integer to be looked at
								// per page.
#define CLEAR  "clear"            // changed to cls or clear depending on 
								// which system the program is run on
								// (unix or PC compatible).
#define TEST 1					// used in bitwise operations.

typedef enum {FALSE, TRUE} bool;

void initialize(bool [], bool[], bool[], bool[], bool[]);
void primesfunc(bool [], bool []);
void psqrtsfunc(bool [], bool []);			// see function doc.
void divby13func(bool[], bool[]);
void fibonfunc( bool[], bool[]);
void printfunc(bool [], char []);

/************************************************************************
Function:  controls the flow of the program
Argumetns: none
Returns:   int
Notes:     none
************************************************************************/

int main()
{

 bool primes[3001]; // bool array of primes #s b/w 1 and 3000
 bool psqrts[3001]; // bool array of perfect squares b/w 1 and 3000.
 bool divby13[3001];// bool array of numbers divisible by 13.
 bool fibon[3001];  // bool array of fibon series #s b/w 1 and 3000
 bool other[3001];  // bool array of #s that dont fit into any of the
					// categories listed above.




  initialize(primes, psqrts, divby13, fibon, other);
  primesfunc(primes, other);
  psqrtsfunc(psqrts, other);
  divby13func(divby13, other);
  fibonfunc( fibon, other);


  printfunc(other, "Other:  ");

      /*  statement above prints every number that does not fit into *
	   *  the 4 categories tested above.							 *
	   *                                                             */

  printf("\nThanks you for using a product of the CS241 curriculum\n");
 return 0;
}

/************************************************************************
Function:	to initialize the bool arrays.
Arguments:	primes[],
			psqrts[],
			divby13[],		// further explanation for the function of
			fibon[],		// each of these array is given in the function
			other[],		// descriptions below.

notes:		none

**************************************************************************/
void printfunc(bool boolarray[], char title[])
{
 register int counter = 0;	// used as a counter in for loops used to print data.
 char ch;					// used to pause the program and give the user enought
							// time to see the screen output.
 int track = 0;				// keeps track of number of integers printed per line.
 int line = 0;				// keeps track of the num. of lines printed

 system (CLEAR);
 printf("\f\n%s\n\n", title);
 track = 0;
 line = 0;
 for (counter = 1; counter < NUMBER_OF_INTS; counter++)
	{
	  if (boolarray[counter] ==  1)
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
		printf("\n\n Press Enter to view the Next Page\n\f");
		//	scanf("%c", &ch);
			system (CLEAR);
			line = 0;
			}
		}
	}

//	printf("\n\nPress enter to view next number series:  ");
//	scanf("%c", &ch);
}


/************************************************************************
Function:	to initialize the bool arrays.
Arguments:	primes[],
			psqrts[],
			divby13[],		// further explanation for the function of
			fibon[],		// each of these array is given in the function
			other[],		// descriptions below.

notes:		none

**************************************************************************/
void initialize(bool primes[], bool psqrts[], bool divby13[], bool fibon[], bool other[])
{
 register int counter = 0;  // variable used by for loops.

 	
	for (counter = 0; counter < NUMBER_OF_INTS; counter++)
		{
		 primes[counter] = 0;
		 psqrts[counter] = 0;
		 divby13[counter] = 0;
		 fibon[counter] = 0;
		 other[counter] = 1;
		}

}

/************************************************************************
Function:	to find and print every number between 1 and 3000 that is 
			a prime number.
Arguments:	primes [],		bool array to store the prime numbers.
			other [],		bool array to store every number that isn't a 
							prime number.
notes:		none

**************************************************************************/
void primesfunc(bool primes[], bool other[])
{
  register int counter = 0,			// integer used in for loop
			   counter2 = 0;		// integer used in for loop
  int track = 0;					// variable used to calculate prime
									// numbers between 1 and 3000.

 other[1] = (other[1] ^ TEST);
 primes[1] = (primes[1] | TEST);

 for (counter = 3; counter < NUMBER_OF_INTS; counter++)
	{

	 for (counter2 = 1; counter2 < NUMBER_OF_INTS; counter2++)
		{
		 if (counter % counter2 != 0)
			track++;
		}
	 if (track == (counter2 - 3))
		{
		 primes[counter] = (primes[counter] | TEST);
		 if (other[counter] != 0)
			 other[counter] = (other[counter] ^ TEST);
		 else
		   other[counter] = (other[counter] & TEST);
		}


	 track = 0;
	}

  printfunc(primes, "Prime Number:  ");
  
}
/************************************************************************
Function:	to find and print every perfect square between 1 and 3000.  
			It flags that number in the array as 1 and the rest as 0.  
			it does the opposite for the other bool array.
Arguments:	psqrts [],		bool array to store the perfect squares.
			other [],		bool array to store every number that isn't a 
							perfect square
Returns:	chages the psqrts and the other array since it is passed by 
			reference
notes:		none

**************************************************************************/
void psqrtsfunc(bool psqrts[], bool other[])
{
 int counter = 0;		// used in for loops as a counter
						// per page.


 for (counter =1; counter <SQRT_OF_NUM_INTS; counter++)
	{
	 if ( (counter * counter) < NUMBER_OF_INTS)
		{
		psqrts[counter* counter] = (psqrts[counter * counter] | TEST);
		if (other[counter * counter] != 0)
			other[counter * counter] = (other[counter * counter] ^ TEST);
		else
			other[counter* counter] = (other[counter * counter] & TEST);
		}

	}


    printfunc(psqrts, "Perfect Squares:  ");

}
/************************************************************************
Function:	to find and print every number between 1 and 3000 that 
			is divisible by 13.
Arguments:	divby13 [],		bool array to store every number divisible
							by 13.
			other [],		bool array to store every number that isn't  
							divisible by 13
notes:		none

**************************************************************************/
void divby13func(bool divby13[], bool other[])
{
 register int counter = 0;  // used as a counter in for loops.


 for (counter = 13; counter < 3001; counter+= 13)
	{

	 if (counter % 13 == 0)
		{
		   divby13[counter] = (divby13[counter] | TEST);
		   if (other[counter] != 0)
				other[counter] = (other[counter] ^ TEST);
		   else
			    other[counter] = (other[counter] & TEST);
		}
	 else 
		divby13[counter] = (divby13[counter] & TEST);


	}

    printfunc(divby13, "Numbers Divisible By 13:  ");

 
}

/************************************************************************
Function:	to find and print every number between 1 and 3000 that isn't 
			part of the fibonacci number sequence.
Arguments:	fibon [],		bool array to store fibonacci num. sequence
			other [],		bool array to store every number that isn't a 
							number in the fibonacci number sequence in the
							1 to 3000 range.

notes:		none

**************************************************************************/
void fibonfunc( bool fibon[], bool other[])
{
 register int counter,	 // counter used in for loops.
			  counter2;  // counter used in for loops.
 int sum;				 // varaible used to calcualte the fibon #s.



 counter = 0;
 counter2 = 1;

 while (counter < NUMBER_OF_INTS)
	{
	  sum = counter + counter2;
	  fibon[sum]= (fibon[sum] | TEST);
	  if (other[sum] != 0)
		  other[sum] = (other[sum] ^ TEST);
	  else
		  other[sum] = (other[sum] & TEST);

	  counter = counter2;
	  counter2= sum;
	}



 printfunc(fibon, "Fabonacci Sequence:  ");
}

