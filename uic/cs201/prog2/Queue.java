/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaska DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 3
 *
 * Purpose:     Queue Implementation 
 * 				// basedon code from 'Thinking in Java, 2nd ed.' by Bruce Eckel
******************************************************************************/
import java.util.*;

public class Queue {
  private LinkedList list = new LinkedList();
/*****************************************************************************
 * Method:  		enqueue()
 * Function:		insert member to queue
 * Arguments:  		None.
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
  public void enqueue(Object v) { list.addFirst(v); }
/*****************************************************************************
 * Method:  		dequeue()
 * Function:		deletes member from queue
 * Arguments:  		None.
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
  public Object dequeue() { 
    return list.removeLast(); 
  }
/*****************************************************************************
 * Method:  		isEmpty()
 * Function:		checks if queue is empty
 * Arguments:  		None.
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 public boolean isEmpty() { 
    return list.isEmpty(); 
  }
 } 
