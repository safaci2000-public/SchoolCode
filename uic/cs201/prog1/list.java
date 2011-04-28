/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaskar DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 2/ Program 1 /Part B
 *
 * Purpose:     This class defines the Linked List implemenation for
 * 				my_Special_Order
 * 				
 * Notes:       LL refers to linked list through out doc.				
 * 				
*****************************************************************************/
class list {
	// primitive/variable declarations
	private node head;		//head pointer
	private node last;	    //last pointer
	private int  length;   // length of list

/*****************************************************************************
 * Method:  		list()
 * Function:		default construtor, nulls everything
 * Arguments:  		None
 * Returns:         None 
******************************************************************************/
	public list()
	{
		last = head = null;
		length = 0;
	}
/*****************************************************************************
 * Method:  		isEmpty()
 * Function:		returns true if Empty, false is not
 * Arguments:  		None
 * Returns:         bool
******************************************************************************/
	public boolean isEmpty()
	{
		return head==null;
	}
/*****************************************************************************
 * Method:  		size()
 * Function:		returns length of LL
 * Arguments:  		None
 * Returns:         int, size
******************************************************************************/
	public int size() { return length; } 
/*****************************************************************************
 * Method:  		insert()
 * Function:		inserts a node as the first node of the list
 * Arguments:  		None
 * Returns:         int, size
******************************************************************************/
	public void insertFirst(int val)
	{
		node newnode = new node(val);
		if (isEmpty() )
			last = newnode;
		else
			head.prev = newnode;
		newnode.next = head;
		head = newnode;
		length++;
	}
/*****************************************************************************
 * Method:  		insert()
 * Function:		inserts a node at the end of the list
 * Arguments:  		None
 * Returns:         int, size
******************************************************************************/
	public void insertLast(int val)
	{
		node newnode = new node(val);
		if (isEmpty() )
			head = newnode;
		else
		{
			last.next = newnode;
			newnode.prev = last;
		}
		last = newnode;
		length++;
	}
/*****************************************************************************
 * Method:  		displayForward()
 * Function:		prints list starting with the first node, ending with the
 * 					last
 * 					
 * Arguments:  		None
 * Returns:         node member which was deleted
******************************************************************************/
   public void displayForward()
   {
		//System.out.print("List (first-->last: ");
		node current = head;
		while (current != null)
		{
		  System.out.print(current.value + "  ");
		  current=current.next;
		}
		System.out.println("");
   }
	
/*****************************************************************************
 * Method:  		node deleteFirst()
 * Function:		deletes first node.
 * 					
 * Arguments:  		None
 * Returns:         node member which was deleted
******************************************************************************/
	public node deleteFirst()
	{
		if (isEmpty()) 
		{
			System.err.println("Error.  Trying to delete node from empty list\n");
			System.err.println("No action taken.  Returned empty node");
			return new node();
		}
		node temp = head;
		if(head.next == null)
			last = null;
		else
			head.next.prev=null;
		head=head.next;
		length--;
		return temp;
	}
/*****************************************************************************
 * Method:  		node deleteLast()
 * Function:		deletes last node.
 * 					
 * Arguments:  		None
 * Returns:         node member which was deleted
******************************************************************************/
	public node deleteLast()
	{
		if (isEmpty()) 
		{
			System.err.println("Error.  Trying to delete node from empty list\n");
			System.err.println("No action taken.  Returned empty node");
			return new node();
		}
		node  temp = last;
		if(head.next==null)
			head = null;
		else
			last.prev.next=null;
		last = last.prev;
		length--;
		return temp;
	}
/*****************************************************************************
 * Method:  		parta()
 * Function:		Finds the middle node, if there isn't one, it picks the 
 * 					left node.  It then traverses backwards thrhough the list.
 * 					Once head is reached, it returns the middle node and prints
 * 					the node forward.
 * 					
 * Arguments:  		none
 * Returns:         print to screen
******************************************************************************/
	public void parta()
	{
		int middle;
		middle = (int) Math.round(((double)length / 2));
		if (length == 0)
			return;
		
		node currptr;  // position of current pointer
		currptr = setPos(middle); 
		while (currptr != head)
		{
			System.out.print(currptr.value + "  ");
			currptr = currptr.prev;
		}
		System.out.print(currptr.value + "  "); // prints last value for loop
		currptr =setPos(middle);
		while (currptr != last)
		{
			currptr = currptr.next;
			System.out.print(currptr.value + "  ");
		}
		System.out.println("");

	}
/*****************************************************************************
 * Method:  		setPos(int)
 * Function:		traverses linked list and returns pointer at location
 * 					specified. 
 * Arguments:  		None
 * Returns:         int, size
******************************************************************************/
    node setPos(int location)
	{
		 node currptr = head;            // resets currptr
		 node backup = new node();      // backup pointer.
		 int count = 0;                 // sets count to 0
		 
		 for (count=0; count < location; count++)       // traverse LL
		 {
		     backup = currptr;
		     currptr = currptr.next;                // point to next node.
		  }
			 return backup;                     // return pointer to node found.
	}
}
