/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:		    Dessislava Nacheva
 * Assign:      Program 4
 * Sec:			440-Sec 2
 *
 * Purpose:     Implements my own version of the C++ list container.
 * 				header file for the generic class handles dynamically allocated
 * 				arrays and provides access methods for manipulating and 
 * 				handeling the data.
 * 				
 * Notes:		"set tabstop=4" in vi will set it to 4.	
 * 				
*****************************************************************************/
#ifndef H_440
#define H_440
#include "440.h"
#endif

template<class T> class List
{
	public:
		List(int=20);				// constructor
		List(const List<T>&);		// copy constructor
		~List();					// destructor

		bool isEmpty() const;		// checks if list is empty
		bool isFull() const;		// checks if list is full
		bool find(int, T&) const;	// returns position of an element.
		int search(const T&) const;	// searches list for an element.
		int size() const;			// returns size of list.
		void clear();				// clears list.
		List<T>& insert(int, const T&);	//inserts an element into the list.
		List<T>& remove(int, T&);		//remove an element from the list.
		List<T>& replace(int, const T&);	// replaces an element in the list.
		List<T>& reverse();			// reverses the order of the elements in 
									// the list.
		List<T>& half();			// deletes every other element.
		List<T>& operator=(const List<T>&);	// overloads the = operator.
		void traverse(void (&)(T&));	// traverses the list.
	 	int maxSize();		 			// returns the maximum size of the list

	private:
		T* entry;					// pointer w/h point to 1st element of list.
		int length,					// length of list.
			maxSz;					// Maximum size of list.
		void copyList(const List<T>& );	// copy list data
};

/***************** Begin constructors & destructors **************************/



/*****************************************************************************
 * Method:  		List(int)	
 * 
 * Function:		Default constructs w/h allocates memory to the array.	
 * 					Uses a default value of 20, if none are specified.	
 *
 * Arguments:  		int size which corresponds to the MaxSize of the array.
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T> 
List<T>::List(int size)
{
	entry = new T[size];
	maxSz= size;
	length = 0;
}
/*****************************************************************************
 * Method:  		List(List <T>&)	
 * 
 * Function:		copy constructs w/h allocates memory to the array	
 * 					by making a duplicate copy of the List object being passed.
 * 					Constructer works by calling the private CopyList method
 * 					by using the overloaded operator (=).
 *
 * Arguments:  		List<T> &   reference to the object which shall be copied	
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
List<T>::List(const List<T>& source)
{
	*this = source;

}
/*****************************************************************************
 * Method:  		~List()	
 * 
 * Function:		Default destructor which de-allocates the dynamic 
 * 					memory used by the class 
 *
 * Arguments:  		None.
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
List<T>::~List()
{
	delete[] entry;
	length= 0;
	maxSz = 0;
}

/************************** End Constructors & Destructors ******************/


/*****************************************************************************
 * Method:  		isEmpty()
 * 
 * Function:		Checks to see if list is empty.
 * 					
 *
 * Arguments:  		None
 * 
 * Returns:         True of false depending on if the list if empty or not.
 *
 * Notes:			NA
 *
******************************************************************************/

template<class T>
bool List<T>::isEmpty() const
{
	if (length == 0)
			return true;

	return false;
}

/*****************************************************************************
 * Method:  		isFull()
 * 
 * Function:		checks to see if list is Full
 * 					
 *
 * Arguments:  		None.
 * 
 * Returns:         bool, true of false depending on weather or not list is full
 *
 * Notes:			NA
 *
******************************************************************************/
template <class T>
bool List<T>::isFull() const
{
	if (length == maxSz)
		return true;
	return false;
}

/*****************************************************************************
 * Method:  		size()
 * 
 * Function:		returns length of the array.
 * 					
 *
 * Arguments:  		None.
 * 
 * Returns:         returns length of array.
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
int List<T>::size() const
{
	return length;
}
/*****************************************************************************
 * Method:  		clear()
 * 
 * Function:		clears the list by setting length to 0
 * 					
 *
 * Arguments:  		None
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
void List<T>::clear()
{
	(*this).length = 0;
}
/*****************************************************************************
 * Method:  		search(const T& toFind)
 * 
 * Function:		searches for the element passed in to see if it's in the 
 * 					array.  
 * 					If value is not found it returns a -1
 * 					
 *
 * Arguments:  		T& toFind:  value being searched in array
 * 
 * Returns:         either location of element that was found or -1 if
 * 					the element wasn't found in array.
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
int List<T>::search(const T& toFind) const
{
	for (int location = 0; location < length; location++)
	{
		if (toFind == entry[location])
				return location;
	}

	return -1;		// signals that search failed.
}

/*****************************************************************************
 * Method:  		find(int location, T& element)	
 * 
 * Function:		checks to see if entry at location specified matches
 * 					the value of the element passed in.
 *
 * Arguments:  		int location:  location of where the method is supposed to 
 * 									look.
 * 					T& element:		element with which to compare
 * 
 * Returns:         True of false depedning on weather value was found or not. 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
bool List<T>::find(int location, T& element) const
{
	if (location < 0 || location >= length )
	{
			cerr << endl << "  error:  find: out-of-range (k =" << 
					location << ")";
			return false;
	}
	
	if (entry[location] == element)
			return true;

	return false;
}

/*****************************************************************************
 * Method:  		insert(int location, T& element)	
 * 
 * Function:		to insert an element inside the list at position specified
 * 					and shifting all the elements over to accomodates the new
 * 					guy in town :)
 *
 * 					
 * Arguments:  		int location:  location where the element is to be inserted.
 * 					T& element: 	element that should be inserted.
 * 
 * Returns:         returns reference to current object.
 *
 *
 * Notes:			gives an error if location is out of bounds or list is 
 * 					currently full.
 *
******************************************************************************/
template<class T>
List<T>& List<T>::insert(int location, const T& element)
{
	if((*this).isFull() )
	{		
			cerr << "  error: insert: list is full" << endl;
			return *this;
	}
	else if ( location < 0 || location > length) 
	{	
 			cerr << "  error: insert: out-of-range (k = " << location << 
					")" << endl;
			return *this;
	}

	for (int cnt = length; cnt >= location; cnt--)
			entry[cnt+1] = entry[cnt];
	entry[location] = element;
	length++;			// increments length counter

	return *this;
}


/*****************************************************************************
 * Method:  		remove(int location, T& element)
 * 
 * Function:		removes element from location specified.  returns the 
 * 					element removed in T& element, as well as shifting over
 * 					all elements in array, if need be.
 * 					
 * Arguments:  		int location:  position of element to be removed.
 * 					T& element:	   stores value of element that is removed.
 * 
 * Returns:         reference to current object.
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
List<T>& List<T>::remove(int location, T& element)
{
		
		if (location < 0 || location >= length )
		{
			cerr << "  error: remove: out-of-range (k =" << 
					location << ")" << endl;
			return *this;
		}
		
		else 
		{
			element = entry[location];	// returns element being removed.

			for (int counter=location; counter < length; counter++)
				entry[counter] = entry[counter+1];
			length--;		// decrement length counter
		}
		

		return *this;
}
/*****************************************************************************
 * Method:  		replace(int location, T& element)
 * 
 * Function:		replaces element at location specified w/ element passed
 * 					in.
 *
 * Arguments:  		int location:  	location of element to replace
 * 					T& element:		value of element that will replace the 
 * 									former value of the element in the array.
 * 
 * Returns:         reference to object
 *
 * Notes:			kicks out an error on out of Bounds index.
 *
******************************************************************************/
template<class T>
List<T>& List<T>::replace(int location, const T& element)
{
		if (location < 0 || location >= length)
				cerr << endl << "  error: cannot remove element."
					 << "  location specified is invalid" << endl;
		else
			entry[location] = element;

	return *this;	   
}
/*****************************************************************************
 * Method:  		reverse()
 * 
 * Function:		reverses the order of the elements in the array.
 * 					
 * Arguments:  		None
 * 
 * Returns:         Reference to object.
 *
 * Notes:			NA
 *
******************************************************************************/

template<class T>
List<T>& List<T>::reverse()
{
	T *back = new T[maxSz];
	int counter;			// used as a loop counter
	int backcounter = length;	// used as a backward loop counter
	for (counter =0; counter < length; counter ++)
	{			
		backcounter--;
		back[counter] = entry[backcounter];
	}

	delete [] entry;	// deletes the entry array 
	entry = back;		// and replaces it w/ the reverse one.

	return *this;
}
/*****************************************************************************
 * Method:  		half()
 * 
 * Function:		removes every other element in array.
 * 					
 * Arguments:  		None.
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
List<T>& List<T>::half()
{
	T *keep = new T[maxSz];		// creates an array of half the size.
	int keepcount = 0;		// keep track of # of elements in array.
	
	for (int counter = 0; counter < length; counter+=2)
	{
	 keep[keepcount] = entry[counter];		// copies content to new array
	 keepcount++;							// counts # of elements.
	}

	delete [] entry;						// deletes old array.
	length = keepcount;						// updates the length
	entry = keep;							// updates entry pointer.

	return *this;
}

/*****************************************************************************
 * Method:  		operator=(const List<T> & element)
 * 
 * Function:		overloads the = operator and copies content of list passed 
 * 					in to current list.
 * 					
 *
 * Arguments:  		reference to object of List generic class
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
List<T>& List<T>::operator=(const List<T> & element)
{
	copyList(element);	

	return *this;
}
/*****************************************************************************
 * Method:  		traverse(void (*func)(T& element))
 * 
 * Function:		traverses the list by calling a function by passing it
 * 					a function pointer.
 * 					
 *
 * Arguments:  		function pointer.
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template <class T>
void List<T>::traverse(void (&func)(T& element))
{
	for (int counter =0; counter < length; counter ++)
	{
		(func)(entry[counter]);
	}
}
/*****************************************************************************
 * Method:  		copyList(List<T>& ListToCopy )
 * 
 * Function:		copies content of list passed in to the current list.
 * 					
 *
 * Arguments:  		List<T>& ListToCopy:  list that shall be copied onto 
 * 										  current object.
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
void List<T>::copyList(const List<T>& ListToCopy )
{
	entry = new T[ListToCopy.maxSz];
	
	for (int cnt = 0; cnt < ListToCopy.length; cnt ++)
			entry[cnt] = ListToCopy.entry[cnt];

	maxSz = ListToCopy.maxSz;		// sets maxSz to value from object passed
	length = ListToCopy.length;		// sets length to value from object passed

}

//***************************************************************************
//************************** END CLASS DEFINITION ***************************
//***************************************************************************

/*****************************************************************************
 * Method:  		increment(T& value)
 * 
 * Function:		increments value of T by 1
 * 					
 * Arguments:  		T& value:   value that should be incremented
 * 					
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
void increment(T &value)
{
		value++;
}

/*****************************************************************************
 * Method:  		decrement(T& value)
 * 
 * Function:		decrements the value of value by 1
 * 					
 * Arguments:  		value:  value that should be decremented	
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
void decrement(T &value)
{
		value --;
}
/*****************************************************************************
 * Method:  		print_entry(T& value)
 * 
 * Function:		print the value being passed in.
 * 					
 * Arguments:  		Value: value to be printed.
 * 					
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/ 
template<class T>
void print_entry(T& value)
{
		cout << value << " ";
}
