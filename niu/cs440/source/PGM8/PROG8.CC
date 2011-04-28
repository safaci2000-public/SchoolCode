/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:          Dessislava Nacheva
 * Assign:      Program 8
 * Sec:         440-Sec 2
 *
 * Purpose:     driver program for the program.
 *                 
 * Notes:       use file redirection to test input data.
 *                 
*****************************************************************************/
#define _WIN        // defines w/h OS i'm using.

#ifdef _UNIX		// if mp then get files from location.
#include "/usr2/onyuksel/courses/440/common/Stack.h"
#include "/usr2/onyuksel/courses/440/common/440.h"
#include "parTree.h"
#define CLEAR "clear"	
using namespace std;
#endif

#ifdef _WIN		// if windows then get files locally
#include "Stack.h"
#include "440.h"
#include "parTree.h"
#define CLEAR "cls"			
using namespace std;
#endif

//#include <iostream>
//using namespace std;

int main(void)
{
	//					*** Prints lovely heading isn't nice :-P ?      //

	system(CLEAR);
    cout << "\t*********************************************************\n"
		 << "\t*                                                       *\n"
		 << "\t*                CSCI 440 - Program 8                   *\n"
		 << "\t*                     Spring 2002                       *\n"
		 << "\t*        Parse Trees and Expression Evaluation          *\n"
		 << "\t*                       Phase 1                         *\n"
		 << "\t*                                                       *\n"
		 << "\t*********************************************************\n";
	cout << endl;		// finishing touch 
	
	string in;	// reads in code world (EXPR, QUIT)
	char *expr = new char[40];	// expression w/h will be built into a tree
	parTree obj;			// parTree Object.
	do 
	{
		cin >> in;
		if (in == "EXPR")
		{
				// DO STUFF
			cin >> expr;
			cout << "EXPR\t" << expr << endl << endl;
			cout << "\tThe parse tree for the above expression is: \n" << endl;
			cout << "\tk\tentry[k]\tleft[k]\t\tright[k]\n";
			cout << "\t_\t--------\t-------\t\t--------\n";
			obj.makeTree(expr);
			obj.printTree();
			obj.clear();
		}
		else if (in == "QUIT")
			cout << "QUIT\n";

	}  while(in != "QUIT" && !cin.eof());

    exit(EXIT_SUCCESS);
}
