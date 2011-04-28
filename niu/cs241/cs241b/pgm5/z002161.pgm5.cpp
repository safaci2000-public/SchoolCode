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

#include <iomanip>
#include <iostream>
#include <string>
using namespace std;

#include "z002161.pgm5.class.h"


void quick_sort(students * &, string, int, int);
void quick_sort(students * &, float, int, int);
void swap(students * &, int , int );

void heap_sort (students * &, string, int , struct heaptree *&);
void buildHeapTree(struct heaptree * &head, students data);
void buildHeapArray(struct heaptree *, students *& );

void heap_sort (students * &, float, int, heaptree * &);
void buildHeapArrayAvg(struct heaptree *, students *&);
void buildHeapTreeAvg(struct heaptree * &head, students data);

void printdata(students *&, int);
void dealwithcmdargmts(int num_of_params, int num_of_studs, heaptree *&, students *&, int location[], int argc, char *argv[] );

struct heaptree
{
	students value;
	heaptree *left;
	heaptree *right;
};

int main(int argc, char* argv[])
{
    int num_of_studs = 0;	// number of students to be read in.
	int num_of_params = 0,	// keeps track of number of parameters passed that matter. (hr, qr, ...etc)
		location[4] = {0};	// array of integers that stores location of parameters passed by user.

	heaptree *headptr = NULL;	// pointer to root of tree.


	students *classptr = new students;	// pointer that will eventually point to an array of objects.

	students *temp;						// temporary pointer used to delete left over memory.

	system ("clear");
	cin >> num_of_studs;
	
	temp = (*classptr).buildAr(classptr, num_of_studs);

	delete temp;




	for (int counter = 0; counter < num_of_studs; counter++)
	{
		classptr[counter].calcAvgQuizScore();
		classptr[counter].calcAvgTest();
		classptr[counter].calcGrade();
	}


	dealwithcmdargmts(num_of_params, num_of_studs, headptr, classptr, location, argc, argv );

	(*classptr).calcClassAvg(classptr, num_of_studs);

	delete [] classptr;

	return 0;
}



/**************************************************************************
Function:	Quick sort the object array by social security number.

Arguments:	students *&classptr,	// pointer to array of objects.
			string social,			// a string used for function overloading.
			int left,				// left most member of array.
			int right,				// right most memeber of array.
Returns:	none.
Notes:
**************************************************************************/
void quick_sort(students * &classptr, string social, int left, int right)
{
	int current = 0,			// used to point to current member of array
								// being looked at.
		last = 0;				// used to point to last member of array looked at.

	string bogus("Junk");		// used to signal w/h version of the overloaded
								// quick the program should perform.


	if (left >= right)
		return;

	swap(classptr, left, (left+right)/2);

	last = left;

	for (current = left + 1; current <= right; current++)
		if (classptr[current] < classptr[left])
			swap(classptr, ++last, current);
	swap(classptr, left, last);

	quick_sort(classptr, bogus, left, last-1);
	quick_sort(classptr, bogus, last+1, right);


}




/**************************************************************************
Function:	Quick sort the object array by social security number.

Arguments:	students *&classptr,	// pointer to array of objects.
			float total,			// a float used for function overloading.
			int left,				// left most member of array.
			int right,				// right most memeber of array.
Returns:	
Notes:
**************************************************************************/
void quick_sort(students * &classptr, float total, int left, int right)
{
	int current = 0, 
		last = 0;

	float junk = 3;


	if (left >= right)
		return;

	swap(classptr, left, (left+right)/2);

	last = left;

	for (current = left + 1; current <= right; current++)
		if (classptr[current].gettotalavg() < classptr[left].gettotalavg())
			swap(classptr, ++last, current);
	swap(classptr, left, last);

	quick_sort(classptr, junk, left, last-1);
	quick_sort(classptr, junk, last+1, right);


}


/**************************************************************************
Function:	takes the array of objects and the location of two members and
			swap their location.

Arguments:	students *&classptr,		// array of objects.
			int first,					// first location.
			int last,					// second location
Returns:	
Notes:
**************************************************************************/
void swap(students * &classptr, int first, int last)
{
	students temp;		// temporary object used for the swap.

	temp = classptr[first];
	classptr[first] = classptr[last];
	classptr[last] = temp;
}



/**************************************************************************
Function:	calls function that deal with the heap sort.

Arguments:	students * & classptr,		// points to an array of objects.
			string stuff,				// used to signal what to sort by
										// social sec. # or total_avg.
			int size,					// size of array of objects.
			heaptree * & head			// pointer to root node.
Returns:	
Notes:
**************************************************************************/
void heap_sort (students * &classptr, string stuff, int size, heaptree * &head)
{

 for (int counter = 0; counter < size; counter++)
	 buildHeapTree(head, classptr[counter]);

 
 buildHeapArray(head, classptr);

 delete head;
 head = NULL;


}


/**************************************************************************
Function:	Converts the heap tree to an array of objects pointed by
			classptr.

Arguments:	struct heaptree *hdptr,		// a pointer to hdptr
			students *& classptr		// a pointer to an alias of students
										// objects.
Returns:	none
Notes:
**************************************************************************/
void buildHeapArray(struct heaptree *hdptr, students *& classptr)
{
 static int counter = 0;

 if (hdptr == NULL)
	 return;
 
 buildHeapArray(hdptr->left, classptr);
 
 classptr[counter] = hdptr->value;
 counter++;

 buildHeapArray(hdptr->right, classptr);
 
}

/**************************************************************************
Function:	builds binary search tree or heap tree of the data in the object
			array.

Arguments:	struct heaptree *& head,	a pointer to a link of the root 
										of the tree
			students data,				an object of the students data.

Returns:	none, modified data is passed by reference.

**************************************************************************/
void buildHeapTree(struct heaptree * &head, students data)
{
 struct heaptree *newptr;	// used to prepare node and allocate mem to it.

 if ( head == NULL)
	{
	 newptr = new heaptree;
	 newptr->value = data;
	 head = newptr;
	 head->left = head->right = NULL;
	}

 else if ( data > head->value || data == head->value)
	{
	 buildHeapTree(head->right, data);
	}
 else if ( data < head->value )
	buildHeapTree(head->left, data);
}


/**************************************************************************
Function:	calls function that deal with the heap sort.

Arguments:	students * & classptr,		// points to an array of objects.
			string stuff,				// used to signal what to sort by
										// social sec. # or total_avg.
			int size,					// size of array of objects.
			heaptree * & head			// pointer to root node.
Returns:	
Notes:
**************************************************************************/
void heap_sort (students * &classptr, float stuff, int size, heaptree * &head)
{

 for (int counter = 0; counter < size; counter++)
	 buildHeapTreeAvg(head, classptr[counter]);

 
 buildHeapArrayAvg(head, classptr);

 delete head;
 head = NULL;

}


/**************************************************************************
Function:	Converts the heap tree to an array of objects pointed by
			classptr.

Arguments:	struct heaptree *hdptr,		// a pointer to hdptr
			students *& classptr		// a pointer to an alias of students
										// objects.
Returns:	none
Notes:
**************************************************************************/
void buildHeapArrayAvg(struct heaptree *hdptr, students *& classptr)
{
 static int counter2 = 0;

 if (hdptr == NULL)
	 return;
 
 buildHeapArrayAvg(hdptr->left, classptr);
 
 classptr[counter2] = hdptr->value;
 counter2++;

 buildHeapArrayAvg(hdptr->right, classptr);
 
}

/**************************************************************************
Function:	builds binary search tree or heap tree of the data in the object
			array.

Arguments:	struct heaptree *& head,	a pointer to a link of the root 
										of the tree
			students data,				an object of the students data.

Returns:	none, modified data is passed by reference.

**************************************************************************/
void buildHeapTreeAvg(struct heaptree * &head, students data)
{
 struct heaptree *newptr;

 if ( head == NULL)
	{
	 newptr = new heaptree;
	 newptr->value = data;
	 head = newptr;
	 head->left = head->right = NULL;
	}

 else if ( data.gettotalavg() > head->value.gettotalavg() )
	{
	 buildHeapTreeAvg(head->right, data);
	}
 else if ( data.gettotalavg() < head->value.gettotalavg() )
	buildHeapTreeAvg(head->left, data);
}


/**************************************************************************
Function:	Prints every member of the class by using the operator 
			overloading of the class.  It also inserts a page break at the
			end of the page
Arguments:	students *& classptr	// pointer to array of objects.
			int size,				// size of array.

Returns:	none

**************************************************************************/
void printdata(students *& classptr, int size)
{
	for (int counter = 0; counter < size; counter++)
			cout << classptr[counter] << endl;

	cout << "\f";


}


/**************************************************************************
Function:	deals with command line parametters and every possible way the 
			user can screw up or do unusual things, this function handles
			the chaos element of the user.
			

Arguments:	num_of_params,		// number of recognized parameters passed.
			num_of_studs,		// number of students read in.
			headptr,			// pointer to root node.
			classptr,			// pointer to array of objects.
			int location[],		// array with location of useful parameters.
			int argc,			// number of raw parameters passed.
			char *argv[],		// array of c-style strings containing
								// parameters passed.
Returns:	

**************************************************************************/
void dealwithcmdargmts(int num_of_params, int num_of_studs, heaptree *& headptr, students *& classptr, int location[], int argc, char *argv[] )
{


		for (int counter = 1; counter < argc; counter++)
	{
		if (strcmp(argv[counter], "-hr") == 0 || strcmp(argv[counter], "-hn") == 0 ||
			strcmp(argv[counter], "-qr") == 0 || strcmp(argv[counter], "-qn") == 0)
		{
			location[num_of_params] = counter;
			num_of_params++;
		}
	}


	if (num_of_params > 2)
	{
		system("clear");
		cout << endl << endl;
		cout << "This program only does two types of sort which can be specified with command" << endl;
		cout << "line arguments.  You specified more then the maximum number alowed (2)," << endl;
		cout << "Please run the program again with an adequate number of parameters" << endl;
		cout << endl << endl << "Thank you for trying a product of the CS241 curriculum!!!" << endl;
		exit(101);
	}


	if (num_of_params == 0)
	{
		cout << endl << "Objects sorted by Social Security using recursive Quicksort " << endl << endl;
		quick_sort(classptr, classptr[0].getsoc(), 0, (num_of_studs -1));
		printdata(classptr, num_of_studs);

		
		cout << endl << "Objects sorted by Total Avg using recursive Heapsort " << endl << endl;
		heap_sort(classptr, classptr[0].gettotalavg(), num_of_studs, headptr);
		printdata(classptr, num_of_studs);
		

	}
	if (strcmp(argv[location[0]], "-hn") == 0 || strcmp(argv[location[0]], "-qn") == 0)
	{
		cout << "first parameter is not supported, switching to default sort (Quick sort, recursive)" << endl << endl;
		quick_sort(classptr, classptr[0].getsoc(), 0, (num_of_studs -1));
		printdata(classptr, num_of_studs);
		
	}
		
	if (strcmp(argv[location[1]], "-hn") == 0 || strcmp(argv[location[1]], "-qn") == 0)
	{
		cout << "second parameter is not supported, switching to default sort (Heap sort, recursive)" << endl << endl;
		heap_sort(classptr, classptr[0].gettotalavg(), num_of_studs, headptr);
		printdata(classptr, num_of_studs);
	}
	if (strcmp(argv[location[1]], "-qr") == 0)
	{
		cout << "Overrided second sort with a recuvsive quick sort" << endl;
		quick_sort(classptr, classptr[0].gettotalavg(), 0, (num_of_studs -1));
		printdata(classptr, num_of_studs);
	}
	if (strcmp(argv[location[0]], "-hr") == 0)
	{
		cout << "Overrided first sort with a recuvsive heap sort" << endl;
		heap_sort(classptr, classptr[0].getsoc(), num_of_studs, headptr);
		printdata(classptr, num_of_studs);
	}

	if (strcmp(argv[location[0]], "-qr") == 0)
	{
		cout << endl << "Objects sorted by Social Security using recursive Quicksort " << endl << endl;
		quick_sort(classptr, classptr[0].getsoc(), 0, (num_of_studs -1));
		printdata(classptr, num_of_studs);
	}
	if (strcmp(argv[location[1]], "-hr") == 0)
	{
		cout << endl << "Objects sorted by Total Avg using recursive Heapsort " << endl << endl;
		heap_sort(classptr, classptr[0].gettotalavg(), num_of_studs, headptr);
		printdata(classptr, num_of_studs);
	}
	
	if (num_of_params == 1)
	{
		cout << endl << "Objects sorted by Total Avg using recursive Heapsort " << endl << endl;
		heap_sort(classptr, classptr[0].gettotalavg(), num_of_studs, headptr);
		printdata(classptr, num_of_studs);

	}

}
