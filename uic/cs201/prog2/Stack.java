/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaska DasGupta
 * TA:		    Guanrao Chen
 * Assign:      
 *
 * Purpose:     
 * 				
 * 				
 * 				
 * 				
******************************************************************************/
class Stack {
	// primitive declarations
	//
	//
	//
	public Stack()
	{

	}
/*****************************************************************************
 * Method:  		
 * 
 * Function:		
 * 					
 * 					
 * Arguments:  		
 * 
 * Returns:         None 
 *
 * Notes:			NA
 *
******************************************************************************/
LinkedList stack = new LinkedList();
    
    // Push on top of stack
	//     stack.addFirst(object);
	//         
	// Pop off top of stack
	Object o = stack.getFirst();
	// If the queue is to be used by multiple threads,
	// the queue must be wrapped with code to synchronize the methods
	stack = (LinkedList)Collections.synchronizedList(stack);


}

