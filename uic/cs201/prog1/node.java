/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaskar DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 2/ Program 1 /Part B
 *
 * Purpose:     Defines the node of the linked list
 * 				
******************************************************************************/
class node{
	public int value;	 // value of the node
	public node next; // reference to next node
	public node prev; // reference to previous node

/*****************************************************************************
 * Method:  		node()
 * Function:		default contstructor, sets everything to 0/null
 * Arguments:  		None
 * Returns:         None 
******************************************************************************/
	node()
	{
		value=0;
		prev=next=null;
	}
/*****************************************************************************
 * Method:  		node()
 * Function:		contstructor, initializes values to passed parms
 * Arguments:  		None
 * Returns:         None 
******************************************************************************/
	node(int new_value)
	{
		value = new_value;
		next=prev=null;
	}
}

