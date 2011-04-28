/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:		    Dessislava Nacheva
 * Assign:      Program 6
 * Sec:			440-Sec 2
 *
 * Purpose:     a driver program used to call and use the List class defined
 * 				in the List2.h header file.  opens 4 files, reads in the data
 * 				after which it sorts it using a recursive insertion sort.
 * 				
 * Notes:		"set tabstop=4" in vi will set it to 4.	
 * 				
*****************************************************************************/
#include <iostream>
#include <fstream>
#include <cstdlib>
#include "List2.h"
using namespace std;

#ifndef H_440
#define H_440
#include "/usr2/onyuksel/courses/440/common/440.h"
#endif

int main(void)
{
	
	system("clear");
	
	ifstream f1("p6.d1"); assert(f1);
	ifstream f2("p6.d2"); assert(f2);		// opens files.
	ifstream f3("p6.d3"); assert(f3);
	ifstream f4("p6.d4"); assert(f4);

	int count[4] = {0};						// array of counters
	
	int int_value;
	float float_value;						// used to build List
	char * str_value;
   
	List<int> data1, data4;
	List<float> data2;						// List declartion
	List<string> data3;

	
	str_value = new char[50];				// gets rid of seg fault.
	
	cout << "\n\t*** CSCI 440: Program 6 - Output ***" << endl;

	
		/*			begin building / sorting of list		*/


	while (f1 >> int_value)
	{
		data1.insert(count[0], int_value);	
		count[0]++;
	}
	cout << "\nfirst list - unsorted" << endl;
	data1.traverse(print_entry, count[0]);

	insort1(data1, count[0]);
	cout << "\nfirst list - sorted" << endl;
	data1.traverse(print_entry, count[0]);
	
	
	while (f2 >> float_value)
	{
		
		data2.insert(count[1], float_value);
	    count[1]++;	
	}

	cout << "\nsecond list - unsorted" << endl;
	data2.traverse(print_entry, count[1]);

	insort1(data2, count[1]);
	cout << "\nsecond list - sorted" << endl;
	data2.traverse(print_entry, count[1]);


	while (f3 >> str_value)
	{
		data3.insert(count[2],str_value);	
		count[2]++;	
	}

	cout << "\nthird list - unsorted" << endl;
	data3.traverse(print_entry, count[2]);

	insort1(data3, count[2]);
	cout << "\nthird list - sorted" << endl;
	data3.traverse(print_entry, count[2]);

	while (f4 >> int_value)
	{
		data4.insert(count[3],int_value);	
		count[3]++;
	}
	
	cout << "\nfourth list - unsorted" << endl;
	data4.traverse(print_entry, count[3]);
	cout << endl;

	insort2(data4, count[3]);
	cout << "\nfourth list - sorted" << endl;
	data4.traverse(print_entry, count[3]);

	
		/*			end building /sorting of list     */

	cout << endl;	

	cout << "\t*** End of Program Execution ***" << endl;
	f1.close();
	f2.close();
	f3.close();			// closes files.
	f4.close();

	
	
	exit(EXIT_SUCCESS);	
}
