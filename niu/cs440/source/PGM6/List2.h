/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:		    Dessislava Nacheva
 * Assign:      Program 6
 * Sec:			440-Sec 2
 *
 * Purpose:     Implements my own version of the C++ list container.
 * 				header file for the generic class handles a Linked List.       
 * 				and provides access methods for manipulating and 
 * 				handeling the data.
 * 				
 * Notes:		"set tabstop=4" in vi will set it to 4.	
 *
 * 				
*****************************************************************************/
#ifndef H_440
#define H_440
#include "440.h"
//#include "/usr2/onyuksel/courses/440/common/440.h"
#endif
#include "node.h"
#include <typeinfo>
#include <string>
const int LSIZE=8;					// # to print per line.
const int FIRST=1;					// used in insort2.


template<class T> class List
{
	public:
		List();						// constructor
		List(const List<T>&);		// copy constructor
		~List();					// destructor

		List<T>& operator=(const List<T>&);	// overloads the = operator.
		int size() const;			// returns size of list.
		bool isEmpty() const;		// checks if list is empty
		void clear();				// clears list.
		int search(const T&);		// searches list for an element.
		List<T>& insert(int, const T&);	//inserts an element into the list.
		List<T>& replace(int, const T&);	// replaces an element in the list.
		List<T>& remove(int, T&);		//remove an element from the list.
		List<T>& reverse();			// reverses the order of the elements in 
									// the list.
		List<T>& half();			// deletes every other element.
		void traverse(void (&)(T&, int), int);// traverses the list.
		T getvalue(int loc);		// returns value

	private:
		Node<T>* head;				// pointer w/h point to 1st element of list.
		Node<T>* currptr;			// used in local functions to traverse 
									// function.
		int length;					// length of list.
		Node<T>* setPos(int);
		void copyList(const List<T>& );	// copy list data
};

/***************** Begin constructors & destructors **************************/



/*****************************************************************************
 * Method:  		List()	
 * 
 * Function:		Default constructs w/h nulls the next pointer and sets
 * 					the length of the list to 0.                      	
 *
 * Arguments:  		None.
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T> 
List<T>::List()
{
	head = 0;
	length = 0;
}
/*****************************************************************************
 * Method:  		List(List <T>&)	
 * 
 * Function:		copy constructs w/h allocates memory to the Linked List
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
	copyList(source);	
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
 * Notes:			calls the clear method to delete the dynamic memory.
 *
******************************************************************************/
template<class T>
List<T>::~List()
{

	(*this).clear();	
}

/************************** End Constructors & Destructors ******************/


/*****************************************************************************
 * Method:  		isEmpty()
 * 
 * Function:		Checks to see if list is empty.
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
 * Method:  		size()
 * 
 * Function:		returns length of the Linked List.
 * 					
 * Arguments:  		None.
 * 
 * Returns:         returns length of the Linked List.
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
 * Function:		clears the list by setting length to 0 and deleting 
 * 					dynamic memory.
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
	Node<T>** arr = new Node<T>*[length];	// declares a dynamically 
										// allocated array of points.
	int count = 0;					// used as a node counter.

	currptr = head;					// sets currptr to the head node.

	while (currptr)					// while currptr != 0;
	{
		arr[count] = currptr;		// puts address of node in array.
		count++;					// increments node count.
		currptr = currptr->next;	// step to the next node.
	}
	for (; count ==0; count--)		// decrement count 'till it reaches zero.
	{
		delete arr[count];			// deletes the address stores in the 
									// array.
	}
	
	delete[] arr;					// deletes the array of pointers.

	head = 0;						// sets the head pointer to null
	currptr = head;					// sets currptr to point to head.
	(*this).length = 0;				// resets the length to 0.
}
/*****************************************************************************
 * Method:  		search(const T& toFind)
 * 
 * Function:		searches for the element passed in to see if it's in the 
 * 					Linked List.
 * 					If value is not found it returns a -1
 * 					
 *
 * Arguments:  		T& toFind:  value being searched in Linked List.
 * 
 * Returns:         either location of element that was found or -1 if
 * 					the element wasn't found in Linked List.
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
int List<T>::search(const T& toFind)
{
	currptr = head;				// resets currptr to point to head.
	int location_count = 0;		// used to stores position of node.

	while (currptr)
	{
		if(currptr->entry == toFind)	// if found return location.
				return location_count;
		location_count++;				// increment location count.
		currptr = currptr->next;
	}

	return -1;		// signals that search failed.
}

/*****************************************************************************
 * Method:  		insert(int location, T& element)	
 * 
 * Function:		to insert an element inside the list at position. 
 * 					
 * Arguments:  		int location:  location where the element is to be inserted.
 * 					T& element: 	element that should be inserted.
 * 
 * Returns:         returns reference to current object.
 *
 *
 * Notes:			gives an error if location is out of bounds. 
 *
******************************************************************************/
template<class T>
List<T>& List<T>::insert(int location, const T& element)
{


		/*   Checks to see if location specified is within range,
		 *   that is.. if location is either a negative # or if location
		 *   is greater then the length of the Linked List.
		 */

	if ( location < 0 || location > length) 
	{	
 			cerr << "  error: insert: out-of-range (k = " << location << 
					")" << endl;
			return *this;
	}


	Node<T>* new_node = new Node<T>(element);		
											// allocates mem for new Node.
	assert(new_node);						// checks if space if available.

	currptr = head;							// sets currptr to point to head 

	if (!location)							// if location != 0 
	{
		new_node->next = head;				// insert node at begginning of 
		head= new_node;						// Linked List.
		length++;
	}
	else if (location > 0 && location != length )	// if location is > the 0
												// and not equal to length of LL
	{
		currptr = head;						// insert Node in middle of	
		currptr= setPos(location);			// Linkd List.
		new_node->next = currptr->next;
		currptr->next = new_node;
		length++;
	}
	else if (location == length)		// if location is equal to length of
	{									// Linked List, insert at end.
		currptr = head;
		while(currptr->next)			// while currptr->next not null, 
			currptr = currptr->next;	// traverse list.

		currptr->next = new_node;		// insert list at location.
		new_node->next = NULL;			// nulls out next pointer.

		length++;						// increment LL length duh :>

	}

	return *this;						// returns object reference.
}


/*****************************************************************************
 * Method:  		replace(int location, T& element)
 * 
 * Function:		replaces element at location specified w/ element passed
 * 					in.
 *
 * Arguments:  		int location:  	location of element to replace
 * 					T& element:		value of element that will replace the 
 * 									former value of the element in the LL.
 * 
 * Returns:         reference to object
 *
 * Notes:			kicks out an error on out of Bounds index.
 *
******************************************************************************/
template<class T>
List<T>& List<T>::replace(int location, const T& element)
{
		currptr= head;			// sets currptr to point to head.

			/* checks to see if location isn't negative or greater then
			 * the length of the list, if it is, error message, which
			 * kicks u out of method.
			 */

		if (location < 0 || location >= length)
				cerr << endl << "  error: cannot remove element."
					 << "  location specified is invalid" << endl;
		else			// removes element at location specified.
		{
			for (int count =0; count < location; count++)
					currptr= currptr->next;
			currptr->entry = element;
		}
	return *this;	   // return reference to object.
}
/*****************************************************************************
 * Method:  		remove(int location, T& element)
 * 
 * Function:		removes element from location specified.  returns the 
 * 					element removed in T& element.
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
		
		/* same error check as usual...checks to see if location isn't 
		 * negative or if it isn't greater then the length of the LL */

		if (location < 0 || location >= length )
		{
			return *this;				// return reference to object.
		}
		

		currptr = head;				// resets currptr;

		if (!location)				// if != 0...
		{
			element = head->entry;		// remove from beg. of list.
			head = head->next;
			delete currptr;
			length--;
		}
		else if (location > 0 && location != length)	
		{
			currptr = head;
			currptr = setPos(location);		// remove from middle of list
			
			element = currptr->next->entry;
			currptr->next = currptr->next->next;
			length--;
		}
		else if (location == length && location != 0)	
		{
			while (currptr->next->next)
				currptr = currptr->next;		//remove from end of list.

			element = currptr->next->next->entry;
			delete currptr->next->next;
			currptr->next = NULL;
			length--;
		}


		return *this;
}
/*****************************************************************************
 * Method:  		reverse()
 * 
 * Function:		reverses the order of the elements in the Linked List.
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
	Node<T>** new_ptr = new Node<T>*[length];	// creates array of pointers
						// used to reset the pointers in the Linked List
						// to the correct order desired.

	int count = 0;		// node /position count.
	currptr = head;		// reset currptr as usual.

	while (currptr)		// while currptr != NULL 
	{ 
		new_ptr [count] = currptr;   // puts address of *next pointers into 
		currptr = currptr->next;	 // array.
		count++;					// increment array count.
	}

	count = length-1;				// sets count to last node.
	head = new_ptr[length-1];		// resets head to appropriate node.
	currptr = head;					// resets currptr as needed.
	
	while (count != 0)				// while count != to zero.
	{
			currptr->next = new_ptr[count];	//resets pointers of LL.
			currptr = currptr->next;
			count--;
	}
	currptr->next = new_ptr[count];			// set last node.
	currptr->next->next = 0;				// set null pointer.

	delete [] new_ptr;				// deletes pointer array.

	return *this;				// returns reference to object.
}
/*****************************************************************************
 * Method:  		half()
 * 
 * Function:		removes every other element in Linked List.
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
	currptr = head;				// this is getting old...but again...
								// resets currptr to point to head node.
	int remove_count = 0;		// number of node to be removed counter.
	Node<T>* remove;			// stores @ of Node to be removed.

	while(currptr)				// while currptr != NULL
	{
		remove_count++;			// increment node to be removed.
		remove = currptr->next;	// gets @ of node to be removed.
		if (currptr->next == NULL)	// if node after this is NULL
		{									// deal accordingly.
			currptr->next = 0;		// sets null pointer.
			remove_count--;			// take away one from remove count.
		}
		else
			currptr->next = currptr->next->next;	// skip node.
		delete remove;						// remove node from mem.
		currptr = currptr->next;			// goto next node.
	}
	length -= remove_count;				//update node count.

	return *this;				// return reference.
}

/*****************************************************************************
 * Method:  		operator=(const List<T> & element)
 * 
 * Function:		overloads the = operator and copies content of list passed 
 * 					in to current list.
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
	if ( (*this).head != element.head)
		copyList(element);		// calls copyList...	
	else
		cerr << "Error: self assignment" << endl;

	return *this;
}
/*****************************************************************************
 * Method:  		traverse(void (*func)(T& element,int), int)
 * 
 * Function:		traverses the list by calling a function by passing it
 * 					a function pointer.
 *
 * Arguments:  		function pointer.
 * 					int		# of elements to traverse.
 * 
 * Returns:         None 
 *
 * Notes:			NA
******************************************************************************/
template <class T>
void List<T>::traverse(void (&func)(T& element,int ), int len)
{
	currptr = head;		// resets currptr to head.
	for (int count = 0; count < len; count++)
	{
		(func)(currptr->entry, len);	// calls func passed by func pointer
		currptr = currptr->next;	// for every element in list.
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
		currptr = head;			// resets currptr.
		Node<T>* passed = ListToCopy.head;	// sets passed to point to LL
							// passed in head ptr.
		Node<T>* backup = 0; // backs up currptr to make a few corrections.

		currptr = new Node<T>;	// allocate mem for new nodes.
		assert(currptr);		// checks if mem is available.
		head = currptr;			// sets head to @ of new node created.
		while (passed)			// while passed != NULL
		{
			currptr->entry = passed->entry;	// set value of entries.
			currptr->next = new Node<T>;	// allocates mem.
			assert(currptr->next);		// check for mem availability.
			backup = currptr;			// backs up currptr.(also works as 
										// a prev-pointer
			currptr = currptr->next;	// goto next node.
			passed = passed->next;		// increment passed node.
		}	
		backup->next = 0;				// nulls last element.
		(*this).length = ListToCopy.length;	// sets new length;
}
/*****************************************************************************
 * Method:  		copyList(List<T>& ListToCopy )
 * 
 * Function:		copies content of list passed in to the current list.
 *
 * Arguments:  		List<T>& ListToCopy:  list that shall be copied onto 
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
Node<T>* List<T>::setPos(int location)
{
 currptr = head;				// resets currptr
 Node<T>* backup;				// backup pointer.
 int count = 0;					// sets count to 0


 for (count=0; count < location; count++)		// traverse LL
 {
	backup = currptr;
	currptr = currptr->next;				// point to next node.
 }

 return backup;						// return pointer to node found.

}

/*****************************************************************************
 * Method:  		getvalue(int loc)
 * 
 * Function:		returns the value of entry @ loc. specified.
 *
 * Arguments:  		int loc :  location to look @
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
template<class T>
T List<T>::getvalue( int loc)
{
  currptr = head;

  for (int cnt=0; cnt < loc; cnt++)
	{
		if (currptr->next != NULL)
			currptr = currptr->next;
	}

	return currptr->entry;

}
//***************************************************************************
//************************** END CLASS DEFINITION ***************************
//***************************************************************************

/*****************************************************************************
 * Method:  		print_entry(T& value, int)
 * 
 * Function:		print the value being passed in.
 * 					
 * Arguments:  		Value: value to be printed.
 * 					len:   # of elements that shall be printed.
 * 					
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/ 
template<class T>
void print_entry(T& value, int len)
{
 static int cnt = 0;

 		cnt++;			// tracks # of elements printed

		if (strcmp(typeid(T).name(), typeid(string).name()) != 0)
				cout << setw(8) << value;
		else
				cout << value << " ";
	
		
		if (!(cnt % LSIZE)) 
			cout << endl;

		if (cnt == len)
		{
			cout << endl;
			cnt = 0;			// after traverse is done..reset to 0
		}
		
}


/*****************************************************************************
 * Method:  		insort1()
 * 
 * Function:		uses a recursive inorder traversal to sort the list.	
 * 					
 * Arguments:  		n           		integer w/ number of elements in list
 * 					list        		list to be sorted.	
 * 					
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/ 
template<class T>
void insort1(List<T>& list, int  n)
{

	if (n > 1)
	{
		insort1(list, n -1);

		int posn = n -1;

		while (posn >= 0 && (list.getvalue(n) < list.getvalue(posn)) )
			posn--;

		posn++;

		T temp = list.getvalue(n);

		list.remove(n,temp); 
		list.insert(posn,temp);


	}
}

/*****************************************************************************
 * Method:  		insort2()
 * 
 * Function:		uses a recursive inorder traversal to sort the list.
 * 					It also prints out the data as it is sorted.
 * 					
 * Arguments:  		n      	integer w/ number of elements in list
 * 					list   	list to be sorted.	
 * 					
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/ 
template<class T>
void insort2(List<T>& list, int  n)
{
 static int track = n;	// static variable w/h keeps track of value of n.

 	if (n == FIRST)
	{
		cout << "*** size = " << FIRST << endl;
 		list.traverse(print_entry,FIRST);
	}
	if (n > 0)
	{

		insort2(list, n -1);
		if (n != track)
		{
			cout << "***size = " << n+1 << endl;
			list.traverse(print_entry,n+1);
		}
		int posn = n-1;
 
		while (posn >= 0 && (list.getvalue(n) < list.getvalue(posn)) )
			posn--;

		posn++;

		T temp = list.getvalue(n);

		list.remove(n,temp); 
		list.insert(posn,temp);

		
	}
	 if (n != track)
	 {		
		list.traverse(print_entry, n + 1);   
		cout << endl;
	 }
}
