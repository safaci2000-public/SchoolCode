/*****************************************************************************
 * Proffessor:  Ibrahim Onyuksel
 * TA:		    Dessislava Nacheva
 * Assign:      Program 1
 * Sec:			440-Sec 2
 *
 * Purpose:     program reads and tests several pairs of fractions, reduce
 * 				each fraction to it's lowest terms, add 2 fractions and then
 * 				reduce the resulting sum to its lowest term.
 * 
 * Notes:		My spacing will most likely be off when you read my source.
 * 				i always set the tab space to 4, the code looks cleaner that
 * 				way.
 * 				"set tabstop=4" in vi will set it to 4.
*****************************************************************************/
//#include "/usr2/onyuksel/courses/440/common/440.h"
#include <iostream>
using namespace std;

/****************************************************************************
 * Method Name:  main
 * purpose:      controls the flow of the program.
 * Parameters:   none
 *
 * returns:      int 
 *
 * notes:
****************************************************************************/
int gcd(int, int);


int main(void)
{
 int top1, 			// the nominator of the 1st fraction.
 	 top2,			// the nominator of the 2nd fraction.
	 bottom1,		// the denominator of the 1st fraction.
	 bottom2,		// the denominator of the 2nd fraction.
	 result_top,    // the nominator of the resulting fraction.
	 result_bottom; // the denominator of the resulting fraction.
 int gcd_int;		// the Greatest common denominator returned by
 					// the method gcd.
 int gcd_int2,
 	 gcd_final;

 	cout << "\t\t*** Fraction Reduction Program ***" << endl << endl;
		
	// read in the integers that make up the fractions and print 'em
	// to screen.
	
	while (cin >> top1 >> bottom1 >> top2 >> bottom2 )
	{

	    cout << '\t' << top1 << ' ' << bottom1 << ' ' << top2 << ' ' << bottom2
			<< endl << endl;

		// if any of integers read in is smaller then zero, then
		// kick out of loop iteration and read in next set of data.

		if (top1 < 0 || top2 < 0 || bottom1 < 0 || bottom2 < 0)
		{
			cerr << "\t!!! Invalid Input !!!" << endl << endl << endl;
			continue;
		}

		// gets greatest commond divisor for 1st fraction and reduce.

		gcd_int = gcd(top1, bottom1);
		top1 /= gcd_int;
		bottom1 /= gcd_int;

		// gets greates common divisor for 2nd fraction and reduce.
		
		gcd_int2 = gcd (top2, bottom2);
		top2 /= gcd_int2;
		bottom2 /= gcd_int2;

		// calculates the sum of the two fractions.

		result_top = ((top1 * bottom2) + (top2 * bottom1));
		result_bottom = (bottom1 * bottom2);

		// reduces the final result.

		gcd_final = gcd(result_top, result_bottom);

		result_top /= gcd_final;
		result_bottom /= gcd_final;
		
		// prints result in user friendly manner.
		cout <<	'\t' << top1 << '/' << bottom1 << " + " << top2 << '/' << 
				bottom2 << " = " << result_top << '/' << result_bottom << 
				endl << endl << endl;


	} 

	cout << "\t\t*** End of Program Execution ***" << endl;
	
	return 0;
}
/*****************************************************************************
 * Method:  gcd
 * 
 * Function:		returns the Greatest commond dividor of two integers.
 *
 * Arguments:  		num1		1st number to be taken into acct
 * 								when calculating the GCD.
 * 					num2		2nd number to be taken into acct.
 * 								when calculating the GCD.
 * 
 * Returns:         an integer, w/h is the Greatest Common Divisor of the
 * 					two integers passed in.
 *
 * Notes:			NA
 *
******************************************************************************/
int gcd( int num1, int num2)
{

    while (num1 > 0)
	{
		return gcd(num2 % num1, num1);

	}

	return num2;
}

